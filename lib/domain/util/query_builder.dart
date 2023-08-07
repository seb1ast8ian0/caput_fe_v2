import 'dart:developer';

import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';

class QueryBuilder{


  static String buildQuery(Filter filter) {

    //log(_buildTagQuery(filter.tags, filter.tagsOperator));

    String mainQuery = 
      'SELECT DISTINCT '
      'neurons.neuron_id, neurons.user_id, neurons.creation_ts, neurons.update_ts '
      'FROM neuron_tag_relations as ntr '
      'FULL JOIN neurons '
      'ON ntr.neuron_id = neurons.neuron_id '
      'WHERE ${_buildTagQuery(filter.tags, filter.tagsOperator)}';

    String payloadQuery = 
      'SELECT '
      'type, caption, mq.neuron_id, mq.user_id, mq.creation_ts, mq.update_ts '
      'FROM ($mainQuery) AS mq '
      'INNER JOIN payloads '
      'ON mq.neuron_id = payloads.neuron_id '
      'WHERE ${_buildTypeQuery(filter.neuronTypes)}';

    String taskQuery = 
      'SELECT '
      'tasks.date_ts as task_date_ts, pq.type, pq.caption, pq.neuron_id, pq.user_id, pq.creation_ts, pq.update_ts '
      'FROM ($payloadQuery) AS pq '
      'LEFT JOIN tasks '
      'ON pq.neuron_id = tasks.neuron_id';

    String dateQuery = 
      'SELECT '
      'dates.date_ts as date_date_ts, tq.type, tq.caption, tq.neuron_id, tq.user_id, tq.task_date_ts, tq.type, tq.creation_ts, tq.update_ts '
      'FROM ($taskQuery) AS tq '
      'LEFT JOIN dates '
      'ON tq.neuron_id = dates.neuron_id '
      'WHERE ${_buildTimeQuery(filter.dateOption)}';

      //print(_buildTimeQuery(filter.dateOption));
      //print("---");

    return dateQuery;
}

  static String _buildTagQuery(List<Tag> tags, LogicalOperator operator){

    if(tags.isEmpty){
      return "true";
    }

    if(operator == LogicalOperator.and){

      String tagsString = tags.map((tag) => '\'${tag.tagId}\'').join(', ');

      return 
        "tag_id IN ($tagsString) "
        "GROUP BY neurons.neuron_id "
        "HAVING COUNT(DISTINCT tag_id) = ${tags.length}";


    } else {

      return tags
        .map((tag) => 'tag_id = \'${tag.tagId}\'')
        .join(' ${operator.name} ');

    }

  }

  static String _buildTypeQuery(List<NeuronType> neuronTypes){

    if (neuronTypes.isEmpty) {
      return 'true';
    }

    return neuronTypes
        .map((type) => 'type = \'${type.name}\'')
        .join(' or ');

  }

  static String _buildTimeQuery(DateOption dateOption){

    String result = "true";
    String noteQuery = "OR (task_date_ts IS NULL AND date_date_ts IS NULL)";

    if(dateOption == DateOption.today){
      result =  "date(task_date_ts, 'unixepoch') = date('now') OR date(date_date_ts, 'unixepoch') = date('now') $noteQuery";
    }

    if(dateOption == DateOption.tomorrow){
      result =  "date(task_date_ts, 'unixepoch') = date('now', '+1 day') OR date(date_date_ts, 'unixepoch') = date('now', '+1 day') $noteQuery";
    }

    if(dateOption == DateOption.oneWeek){
      result =  "(date(task_date_ts, 'unixepoch') <= date('now', '+7 days')"
                "AND date(task_date_ts, 'unixepoch') >= date('now'))"
                "OR (date(date_date_ts, 'unixepoch') <= date('now', '+7 days')"
                "AND date(date_date_ts, 'unixepoch') >= date('now')) $noteQuery";
    }

    if(dateOption == DateOption.oneMonth){
      result =  "(date(task_date_ts, 'unixepoch') <= date('now', '+31 days')"
                "AND date(task_date_ts, 'unixepoch') >= date('now'))"
                "OR (date(date_date_ts, 'unixepoch') <= date('now', '+31 days')"
                "AND date(date_date_ts, 'unixepoch') >= date('now')) $noteQuery";
    }

    return result;

  }



}