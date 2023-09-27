
import 'package:Caput/domain/entities/filter/filter.dart';
import 'package:Caput/domain/entities/neuron/tag.dart';
import 'package:Caput/domain/get_models/database_controller.dart';
import 'package:Caput/domain/usecases/filter/add_filter_usecase.dart';
import 'package:Caput/domain/usecases/filter/get_filter_usecase.dart';
import 'package:Caput/domain/usecases/filter/get_filters_usecase.dart';
import 'package:Caput/infrastructure/repositories/drift/tag_repository.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

void main(){

  group("filter usecase test -> ", () {

    setUp(() async {

      Get.put(DatabaseController(
        NativeDatabase.memory()
      ));

    });
    
    tearDown(() async {
      
      DatabaseController database = Get.find();
      await database.database.close();
      Get.reset();
      
    });

    test("test add_ & get_filter_usecase", () async {

      AddFilterUsecase addFilterUsecase = AddFilterUsecase();
      GetFilterUsecase getFilterUsecase = GetFilterUsecase();
      TagRepositoryDrift tagRepo = TagRepositoryDrift();

      List<Tag> tags = _getTags();

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags, 
        tagsOperator: LogicalOperator.or, 
        neuronTypes: const [NeuronType.note], 
        dateOption: DateOption.all
      );

      for(Tag tag in tags){
        tagRepo.addTag(tag);
      }
      addFilterUsecase.execute(filter);
      Filter result = await getFilterUsecase.execute(filter.filterId);

      expect(filter.filterId, result.filterId);

    });

    test("test get_filters_usecase", () async {

      AddFilterUsecase addFilterUsecase = AddFilterUsecase();
      GetFiltersUsecase getFiltersUsecase = GetFiltersUsecase();
      TagRepositoryDrift tagRepo = TagRepositoryDrift();

      List<Tag> tags = _getTags();

      Filter filter = Filter(
        filterId: const Uuid().v4(), 
        userId: const Uuid().v4(), 
        caption: "test filter", 
        creationTs: DateTime.now(), 
        updateTs: DateTime.now(), 
        tags: tags, 
        tagsOperator: LogicalOperator.or, 
        neuronTypes: const [NeuronType.note], 
        dateOption: DateOption.all
      );

      for(Tag tag in tags){
        tagRepo.addTag(tag);
      }
      addFilterUsecase.execute(filter);
      List<Filter> result = await getFiltersUsecase.execute();

      expect(result.length, 1);

    });

    
  });

}

List<Tag> _getTags(){

  return [
    Tag(
      tagId: const Uuid().v4(), 
      userId: const Uuid().v4(), 
      caption: "tag1", 
      body: "body1", 
      creationTs: DateTime.now(), 
      updateTs: DateTime.now()
    ),
    Tag(
      tagId: const Uuid().v4(), 
      userId: const Uuid().v4(), 
      caption: "tag2", 
      body: "body2", 
      creationTs: DateTime.now(), 
      updateTs: DateTime.now()
    )
  ];

}