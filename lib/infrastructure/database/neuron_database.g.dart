// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'neuron_database.dart';

// ignore_for_file: type=lint
class $NeuronsTable extends Neurons with TableInfo<$NeuronsTable, NeuronDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NeuronsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTsMeta =
      const VerificationMeta('creationTs');
  @override
  late final GeneratedColumn<DateTime> creationTs = GeneratedColumn<DateTime>(
      'creation_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTsMeta =
      const VerificationMeta('updateTs');
  @override
  late final GeneratedColumn<DateTime> updateTs = GeneratedColumn<DateTime>(
      'update_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [neuronId, userId, creationTs, updateTs];
  @override
  String get aliasedName => _alias ?? 'neurons';
  @override
  String get actualTableName => 'neurons';
  @override
  VerificationContext validateIntegrity(Insertable<NeuronDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('creation_ts')) {
      context.handle(
          _creationTsMeta,
          creationTs.isAcceptableOrUnknown(
              data['creation_ts']!, _creationTsMeta));
    } else if (isInserting) {
      context.missing(_creationTsMeta);
    }
    if (data.containsKey('update_ts')) {
      context.handle(_updateTsMeta,
          updateTs.isAcceptableOrUnknown(data['update_ts']!, _updateTsMeta));
    } else if (isInserting) {
      context.missing(_updateTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {neuronId};
  @override
  NeuronDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NeuronDBO(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      creationTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_ts'])!,
      updateTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_ts'])!,
    );
  }

  @override
  $NeuronsTable createAlias(String alias) {
    return $NeuronsTable(attachedDatabase, alias);
  }
}

class NeuronDBO extends DataClass implements Insertable<NeuronDBO> {
  final String neuronId;
  final String userId;
  final DateTime creationTs;
  final DateTime updateTs;
  const NeuronDBO(
      {required this.neuronId,
      required this.userId,
      required this.creationTs,
      required this.updateTs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    map['user_id'] = Variable<String>(userId);
    map['creation_ts'] = Variable<DateTime>(creationTs);
    map['update_ts'] = Variable<DateTime>(updateTs);
    return map;
  }

  NeuronsCompanion toCompanion(bool nullToAbsent) {
    return NeuronsCompanion(
      neuronId: Value(neuronId),
      userId: Value(userId),
      creationTs: Value(creationTs),
      updateTs: Value(updateTs),
    );
  }

  factory NeuronDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NeuronDBO(
      neuronId: serializer.fromJson<String>(json['neuronId']),
      userId: serializer.fromJson<String>(json['userId']),
      creationTs: serializer.fromJson<DateTime>(json['creationTs']),
      updateTs: serializer.fromJson<DateTime>(json['updateTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
      'userId': serializer.toJson<String>(userId),
      'creationTs': serializer.toJson<DateTime>(creationTs),
      'updateTs': serializer.toJson<DateTime>(updateTs),
    };
  }

  NeuronDBO copyWith(
          {String? neuronId,
          String? userId,
          DateTime? creationTs,
          DateTime? updateTs}) =>
      NeuronDBO(
        neuronId: neuronId ?? this.neuronId,
        userId: userId ?? this.userId,
        creationTs: creationTs ?? this.creationTs,
        updateTs: updateTs ?? this.updateTs,
      );
  @override
  String toString() {
    return (StringBuffer('NeuronDBO(')
          ..write('neuronId: $neuronId, ')
          ..write('userId: $userId, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(neuronId, userId, creationTs, updateTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NeuronDBO &&
          other.neuronId == this.neuronId &&
          other.userId == this.userId &&
          other.creationTs == this.creationTs &&
          other.updateTs == this.updateTs);
}

class NeuronsCompanion extends UpdateCompanion<NeuronDBO> {
  final Value<String> neuronId;
  final Value<String> userId;
  final Value<DateTime> creationTs;
  final Value<DateTime> updateTs;
  final Value<int> rowid;
  const NeuronsCompanion({
    this.neuronId = const Value.absent(),
    this.userId = const Value.absent(),
    this.creationTs = const Value.absent(),
    this.updateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NeuronsCompanion.insert({
    required String neuronId,
    required String userId,
    required DateTime creationTs,
    required DateTime updateTs,
    this.rowid = const Value.absent(),
  })  : neuronId = Value(neuronId),
        userId = Value(userId),
        creationTs = Value(creationTs),
        updateTs = Value(updateTs);
  static Insertable<NeuronDBO> custom({
    Expression<String>? neuronId,
    Expression<String>? userId,
    Expression<DateTime>? creationTs,
    Expression<DateTime>? updateTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (userId != null) 'user_id': userId,
      if (creationTs != null) 'creation_ts': creationTs,
      if (updateTs != null) 'update_ts': updateTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NeuronsCompanion copyWith(
      {Value<String>? neuronId,
      Value<String>? userId,
      Value<DateTime>? creationTs,
      Value<DateTime>? updateTs,
      Value<int>? rowid}) {
    return NeuronsCompanion(
      neuronId: neuronId ?? this.neuronId,
      userId: userId ?? this.userId,
      creationTs: creationTs ?? this.creationTs,
      updateTs: updateTs ?? this.updateTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (creationTs.present) {
      map['creation_ts'] = Variable<DateTime>(creationTs.value);
    }
    if (updateTs.present) {
      map['update_ts'] = Variable<DateTime>(updateTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NeuronsCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('userId: $userId, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TagsTable extends Tags with TableInfo<$TagsTable, TagDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
      'body', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTsMeta =
      const VerificationMeta('creationTs');
  @override
  late final GeneratedColumn<DateTime> creationTs = GeneratedColumn<DateTime>(
      'creation_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTsMeta =
      const VerificationMeta('updateTs');
  @override
  late final GeneratedColumn<DateTime> updateTs = GeneratedColumn<DateTime>(
      'update_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [tagId, userId, caption, body, creationTs, updateTs];
  @override
  String get aliasedName => _alias ?? 'tags';
  @override
  String get actualTableName => 'tags';
  @override
  VerificationContext validateIntegrity(Insertable<TagDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
          _bodyMeta, body.isAcceptableOrUnknown(data['body']!, _bodyMeta));
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('creation_ts')) {
      context.handle(
          _creationTsMeta,
          creationTs.isAcceptableOrUnknown(
              data['creation_ts']!, _creationTsMeta));
    } else if (isInserting) {
      context.missing(_creationTsMeta);
    }
    if (data.containsKey('update_ts')) {
      context.handle(_updateTsMeta,
          updateTs.isAcceptableOrUnknown(data['update_ts']!, _updateTsMeta));
    } else if (isInserting) {
      context.missing(_updateTsMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {tagId};
  @override
  TagDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagDBO(
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption'])!,
      body: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}body'])!,
      creationTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_ts'])!,
      updateTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_ts'])!,
    );
  }

  @override
  $TagsTable createAlias(String alias) {
    return $TagsTable(attachedDatabase, alias);
  }
}

class TagDBO extends DataClass implements Insertable<TagDBO> {
  final String tagId;
  final String userId;
  final String caption;
  final String body;
  final DateTime creationTs;
  final DateTime updateTs;
  const TagDBO(
      {required this.tagId,
      required this.userId,
      required this.caption,
      required this.body,
      required this.creationTs,
      required this.updateTs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['tag_id'] = Variable<String>(tagId);
    map['user_id'] = Variable<String>(userId);
    map['caption'] = Variable<String>(caption);
    map['body'] = Variable<String>(body);
    map['creation_ts'] = Variable<DateTime>(creationTs);
    map['update_ts'] = Variable<DateTime>(updateTs);
    return map;
  }

  TagsCompanion toCompanion(bool nullToAbsent) {
    return TagsCompanion(
      tagId: Value(tagId),
      userId: Value(userId),
      caption: Value(caption),
      body: Value(body),
      creationTs: Value(creationTs),
      updateTs: Value(updateTs),
    );
  }

  factory TagDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagDBO(
      tagId: serializer.fromJson<String>(json['tagId']),
      userId: serializer.fromJson<String>(json['userId']),
      caption: serializer.fromJson<String>(json['caption']),
      body: serializer.fromJson<String>(json['body']),
      creationTs: serializer.fromJson<DateTime>(json['creationTs']),
      updateTs: serializer.fromJson<DateTime>(json['updateTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'tagId': serializer.toJson<String>(tagId),
      'userId': serializer.toJson<String>(userId),
      'caption': serializer.toJson<String>(caption),
      'body': serializer.toJson<String>(body),
      'creationTs': serializer.toJson<DateTime>(creationTs),
      'updateTs': serializer.toJson<DateTime>(updateTs),
    };
  }

  TagDBO copyWith(
          {String? tagId,
          String? userId,
          String? caption,
          String? body,
          DateTime? creationTs,
          DateTime? updateTs}) =>
      TagDBO(
        tagId: tagId ?? this.tagId,
        userId: userId ?? this.userId,
        caption: caption ?? this.caption,
        body: body ?? this.body,
        creationTs: creationTs ?? this.creationTs,
        updateTs: updateTs ?? this.updateTs,
      );
  @override
  String toString() {
    return (StringBuffer('TagDBO(')
          ..write('tagId: $tagId, ')
          ..write('userId: $userId, ')
          ..write('caption: $caption, ')
          ..write('body: $body, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(tagId, userId, caption, body, creationTs, updateTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagDBO &&
          other.tagId == this.tagId &&
          other.userId == this.userId &&
          other.caption == this.caption &&
          other.body == this.body &&
          other.creationTs == this.creationTs &&
          other.updateTs == this.updateTs);
}

class TagsCompanion extends UpdateCompanion<TagDBO> {
  final Value<String> tagId;
  final Value<String> userId;
  final Value<String> caption;
  final Value<String> body;
  final Value<DateTime> creationTs;
  final Value<DateTime> updateTs;
  final Value<int> rowid;
  const TagsCompanion({
    this.tagId = const Value.absent(),
    this.userId = const Value.absent(),
    this.caption = const Value.absent(),
    this.body = const Value.absent(),
    this.creationTs = const Value.absent(),
    this.updateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TagsCompanion.insert({
    required String tagId,
    required String userId,
    required String caption,
    required String body,
    required DateTime creationTs,
    required DateTime updateTs,
    this.rowid = const Value.absent(),
  })  : tagId = Value(tagId),
        userId = Value(userId),
        caption = Value(caption),
        body = Value(body),
        creationTs = Value(creationTs),
        updateTs = Value(updateTs);
  static Insertable<TagDBO> custom({
    Expression<String>? tagId,
    Expression<String>? userId,
    Expression<String>? caption,
    Expression<String>? body,
    Expression<DateTime>? creationTs,
    Expression<DateTime>? updateTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (tagId != null) 'tag_id': tagId,
      if (userId != null) 'user_id': userId,
      if (caption != null) 'caption': caption,
      if (body != null) 'body': body,
      if (creationTs != null) 'creation_ts': creationTs,
      if (updateTs != null) 'update_ts': updateTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TagsCompanion copyWith(
      {Value<String>? tagId,
      Value<String>? userId,
      Value<String>? caption,
      Value<String>? body,
      Value<DateTime>? creationTs,
      Value<DateTime>? updateTs,
      Value<int>? rowid}) {
    return TagsCompanion(
      tagId: tagId ?? this.tagId,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      body: body ?? this.body,
      creationTs: creationTs ?? this.creationTs,
      updateTs: updateTs ?? this.updateTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (creationTs.present) {
      map['creation_ts'] = Variable<DateTime>(creationTs.value);
    }
    if (updateTs.present) {
      map['update_ts'] = Variable<DateTime>(updateTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsCompanion(')
          ..write('tagId: $tagId, ')
          ..write('userId: $userId, ')
          ..write('caption: $caption, ')
          ..write('body: $body, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NeuronTagRelationsTable extends NeuronTagRelations
    with TableInfo<$NeuronTagRelationsTable, NeuronTagRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NeuronTagRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [neuronId, tagId];
  @override
  String get aliasedName => _alias ?? 'neuron_tag_relations';
  @override
  String get actualTableName => 'neuron_tag_relations';
  @override
  VerificationContext validateIntegrity(Insertable<NeuronTagRelation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  NeuronTagRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NeuronTagRelation(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $NeuronTagRelationsTable createAlias(String alias) {
    return $NeuronTagRelationsTable(attachedDatabase, alias);
  }
}

class NeuronTagRelation extends DataClass
    implements Insertable<NeuronTagRelation> {
  final String neuronId;
  final String tagId;
  const NeuronTagRelation({required this.neuronId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  NeuronTagRelationsCompanion toCompanion(bool nullToAbsent) {
    return NeuronTagRelationsCompanion(
      neuronId: Value(neuronId),
      tagId: Value(tagId),
    );
  }

  factory NeuronTagRelation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NeuronTagRelation(
      neuronId: serializer.fromJson<String>(json['neuronId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  NeuronTagRelation copyWith({String? neuronId, String? tagId}) =>
      NeuronTagRelation(
        neuronId: neuronId ?? this.neuronId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('NeuronTagRelation(')
          ..write('neuronId: $neuronId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(neuronId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NeuronTagRelation &&
          other.neuronId == this.neuronId &&
          other.tagId == this.tagId);
}

class NeuronTagRelationsCompanion extends UpdateCompanion<NeuronTagRelation> {
  final Value<String> neuronId;
  final Value<String> tagId;
  final Value<int> rowid;
  const NeuronTagRelationsCompanion({
    this.neuronId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NeuronTagRelationsCompanion.insert({
    required String neuronId,
    required String tagId,
    this.rowid = const Value.absent(),
  })  : neuronId = Value(neuronId),
        tagId = Value(tagId);
  static Insertable<NeuronTagRelation> custom({
    Expression<String>? neuronId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NeuronTagRelationsCompanion copyWith(
      {Value<String>? neuronId, Value<String>? tagId, Value<int>? rowid}) {
    return NeuronTagRelationsCompanion(
      neuronId: neuronId ?? this.neuronId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NeuronTagRelationsCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilterTagRelationsTable extends FilterTagRelations
    with TableInfo<$FilterTagRelationsTable, FilterTagRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilterTagRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _filterIdMeta =
      const VerificationMeta('filterId');
  @override
  late final GeneratedColumn<String> filterId = GeneratedColumn<String>(
      'filter_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _tagIdMeta = const VerificationMeta('tagId');
  @override
  late final GeneratedColumn<String> tagId = GeneratedColumn<String>(
      'tag_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [filterId, tagId];
  @override
  String get aliasedName => _alias ?? 'filter_tag_relations';
  @override
  String get actualTableName => 'filter_tag_relations';
  @override
  VerificationContext validateIntegrity(Insertable<FilterTagRelation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('filter_id')) {
      context.handle(_filterIdMeta,
          filterId.isAcceptableOrUnknown(data['filter_id']!, _filterIdMeta));
    } else if (isInserting) {
      context.missing(_filterIdMeta);
    }
    if (data.containsKey('tag_id')) {
      context.handle(
          _tagIdMeta, tagId.isAcceptableOrUnknown(data['tag_id']!, _tagIdMeta));
    } else if (isInserting) {
      context.missing(_tagIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FilterTagRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilterTagRelation(
      filterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filter_id'])!,
      tagId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag_id'])!,
    );
  }

  @override
  $FilterTagRelationsTable createAlias(String alias) {
    return $FilterTagRelationsTable(attachedDatabase, alias);
  }
}

class FilterTagRelation extends DataClass
    implements Insertable<FilterTagRelation> {
  final String filterId;
  final String tagId;
  const FilterTagRelation({required this.filterId, required this.tagId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['filter_id'] = Variable<String>(filterId);
    map['tag_id'] = Variable<String>(tagId);
    return map;
  }

  FilterTagRelationsCompanion toCompanion(bool nullToAbsent) {
    return FilterTagRelationsCompanion(
      filterId: Value(filterId),
      tagId: Value(tagId),
    );
  }

  factory FilterTagRelation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilterTagRelation(
      filterId: serializer.fromJson<String>(json['filterId']),
      tagId: serializer.fromJson<String>(json['tagId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'filterId': serializer.toJson<String>(filterId),
      'tagId': serializer.toJson<String>(tagId),
    };
  }

  FilterTagRelation copyWith({String? filterId, String? tagId}) =>
      FilterTagRelation(
        filterId: filterId ?? this.filterId,
        tagId: tagId ?? this.tagId,
      );
  @override
  String toString() {
    return (StringBuffer('FilterTagRelation(')
          ..write('filterId: $filterId, ')
          ..write('tagId: $tagId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(filterId, tagId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilterTagRelation &&
          other.filterId == this.filterId &&
          other.tagId == this.tagId);
}

class FilterTagRelationsCompanion extends UpdateCompanion<FilterTagRelation> {
  final Value<String> filterId;
  final Value<String> tagId;
  final Value<int> rowid;
  const FilterTagRelationsCompanion({
    this.filterId = const Value.absent(),
    this.tagId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilterTagRelationsCompanion.insert({
    required String filterId,
    required String tagId,
    this.rowid = const Value.absent(),
  })  : filterId = Value(filterId),
        tagId = Value(tagId);
  static Insertable<FilterTagRelation> custom({
    Expression<String>? filterId,
    Expression<String>? tagId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (filterId != null) 'filter_id': filterId,
      if (tagId != null) 'tag_id': tagId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilterTagRelationsCompanion copyWith(
      {Value<String>? filterId, Value<String>? tagId, Value<int>? rowid}) {
    return FilterTagRelationsCompanion(
      filterId: filterId ?? this.filterId,
      tagId: tagId ?? this.tagId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (filterId.present) {
      map['filter_id'] = Variable<String>(filterId.value);
    }
    if (tagId.present) {
      map['tag_id'] = Variable<String>(tagId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilterTagRelationsCompanion(')
          ..write('filterId: $filterId, ')
          ..write('tagId: $tagId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FilterNeuronRelationsTable extends FilterNeuronRelations
    with TableInfo<$FilterNeuronRelationsTable, FilterNeuronRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FilterNeuronRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _filterIdMeta =
      const VerificationMeta('filterId');
  @override
  late final GeneratedColumn<String> filterId = GeneratedColumn<String>(
      'filter_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [filterId, neuronId];
  @override
  String get aliasedName => _alias ?? 'filter_neuron_relations';
  @override
  String get actualTableName => 'filter_neuron_relations';
  @override
  VerificationContext validateIntegrity(
      Insertable<FilterNeuronRelation> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('filter_id')) {
      context.handle(_filterIdMeta,
          filterId.isAcceptableOrUnknown(data['filter_id']!, _filterIdMeta));
    } else if (isInserting) {
      context.missing(_filterIdMeta);
    }
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  FilterNeuronRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilterNeuronRelation(
      filterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filter_id'])!,
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
    );
  }

  @override
  $FilterNeuronRelationsTable createAlias(String alias) {
    return $FilterNeuronRelationsTable(attachedDatabase, alias);
  }
}

class FilterNeuronRelation extends DataClass
    implements Insertable<FilterNeuronRelation> {
  final String filterId;
  final String neuronId;
  const FilterNeuronRelation({required this.filterId, required this.neuronId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['filter_id'] = Variable<String>(filterId);
    map['neuron_id'] = Variable<String>(neuronId);
    return map;
  }

  FilterNeuronRelationsCompanion toCompanion(bool nullToAbsent) {
    return FilterNeuronRelationsCompanion(
      filterId: Value(filterId),
      neuronId: Value(neuronId),
    );
  }

  factory FilterNeuronRelation.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilterNeuronRelation(
      filterId: serializer.fromJson<String>(json['filterId']),
      neuronId: serializer.fromJson<String>(json['neuronId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'filterId': serializer.toJson<String>(filterId),
      'neuronId': serializer.toJson<String>(neuronId),
    };
  }

  FilterNeuronRelation copyWith({String? filterId, String? neuronId}) =>
      FilterNeuronRelation(
        filterId: filterId ?? this.filterId,
        neuronId: neuronId ?? this.neuronId,
      );
  @override
  String toString() {
    return (StringBuffer('FilterNeuronRelation(')
          ..write('filterId: $filterId, ')
          ..write('neuronId: $neuronId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(filterId, neuronId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilterNeuronRelation &&
          other.filterId == this.filterId &&
          other.neuronId == this.neuronId);
}

class FilterNeuronRelationsCompanion
    extends UpdateCompanion<FilterNeuronRelation> {
  final Value<String> filterId;
  final Value<String> neuronId;
  final Value<int> rowid;
  const FilterNeuronRelationsCompanion({
    this.filterId = const Value.absent(),
    this.neuronId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FilterNeuronRelationsCompanion.insert({
    required String filterId,
    required String neuronId,
    this.rowid = const Value.absent(),
  })  : filterId = Value(filterId),
        neuronId = Value(neuronId);
  static Insertable<FilterNeuronRelation> custom({
    Expression<String>? filterId,
    Expression<String>? neuronId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (filterId != null) 'filter_id': filterId,
      if (neuronId != null) 'neuron_id': neuronId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FilterNeuronRelationsCompanion copyWith(
      {Value<String>? filterId, Value<String>? neuronId, Value<int>? rowid}) {
    return FilterNeuronRelationsCompanion(
      filterId: filterId ?? this.filterId,
      neuronId: neuronId ?? this.neuronId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (filterId.present) {
      map['filter_id'] = Variable<String>(filterId.value);
    }
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FilterNeuronRelationsCompanion(')
          ..write('filterId: $filterId, ')
          ..write('neuronId: $neuronId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PayloadsTable extends Payloads
    with TableInfo<$PayloadsTable, PayloadDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PayloadsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _priorityMeta =
      const VerificationMeta('priority');
  @override
  late final GeneratedColumn<int> priority = GeneratedColumn<int>(
      'priority', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [neuronId, type, caption, priority];
  @override
  String get aliasedName => _alias ?? 'payloads';
  @override
  String get actualTableName => 'payloads';
  @override
  VerificationContext validateIntegrity(Insertable<PayloadDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('priority')) {
      context.handle(_priorityMeta,
          priority.isAcceptableOrUnknown(data['priority']!, _priorityMeta));
    } else if (isInserting) {
      context.missing(_priorityMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {neuronId};
  @override
  PayloadDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PayloadDBO(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption'])!,
      priority: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}priority'])!,
    );
  }

  @override
  $PayloadsTable createAlias(String alias) {
    return $PayloadsTable(attachedDatabase, alias);
  }
}

class PayloadDBO extends DataClass implements Insertable<PayloadDBO> {
  final String neuronId;
  final String type;
  final String caption;
  final int priority;
  const PayloadDBO(
      {required this.neuronId,
      required this.type,
      required this.caption,
      required this.priority});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    map['type'] = Variable<String>(type);
    map['caption'] = Variable<String>(caption);
    map['priority'] = Variable<int>(priority);
    return map;
  }

  PayloadsCompanion toCompanion(bool nullToAbsent) {
    return PayloadsCompanion(
      neuronId: Value(neuronId),
      type: Value(type),
      caption: Value(caption),
      priority: Value(priority),
    );
  }

  factory PayloadDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PayloadDBO(
      neuronId: serializer.fromJson<String>(json['neuronId']),
      type: serializer.fromJson<String>(json['type']),
      caption: serializer.fromJson<String>(json['caption']),
      priority: serializer.fromJson<int>(json['priority']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
      'type': serializer.toJson<String>(type),
      'caption': serializer.toJson<String>(caption),
      'priority': serializer.toJson<int>(priority),
    };
  }

  PayloadDBO copyWith(
          {String? neuronId, String? type, String? caption, int? priority}) =>
      PayloadDBO(
        neuronId: neuronId ?? this.neuronId,
        type: type ?? this.type,
        caption: caption ?? this.caption,
        priority: priority ?? this.priority,
      );
  @override
  String toString() {
    return (StringBuffer('PayloadDBO(')
          ..write('neuronId: $neuronId, ')
          ..write('type: $type, ')
          ..write('caption: $caption, ')
          ..write('priority: $priority')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(neuronId, type, caption, priority);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PayloadDBO &&
          other.neuronId == this.neuronId &&
          other.type == this.type &&
          other.caption == this.caption &&
          other.priority == this.priority);
}

class PayloadsCompanion extends UpdateCompanion<PayloadDBO> {
  final Value<String> neuronId;
  final Value<String> type;
  final Value<String> caption;
  final Value<int> priority;
  final Value<int> rowid;
  const PayloadsCompanion({
    this.neuronId = const Value.absent(),
    this.type = const Value.absent(),
    this.caption = const Value.absent(),
    this.priority = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PayloadsCompanion.insert({
    required String neuronId,
    required String type,
    required String caption,
    required int priority,
    this.rowid = const Value.absent(),
  })  : neuronId = Value(neuronId),
        type = Value(type),
        caption = Value(caption),
        priority = Value(priority);
  static Insertable<PayloadDBO> custom({
    Expression<String>? neuronId,
    Expression<String>? type,
    Expression<String>? caption,
    Expression<int>? priority,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (type != null) 'type': type,
      if (caption != null) 'caption': caption,
      if (priority != null) 'priority': priority,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PayloadsCompanion copyWith(
      {Value<String>? neuronId,
      Value<String>? type,
      Value<String>? caption,
      Value<int>? priority,
      Value<int>? rowid}) {
    return PayloadsCompanion(
      neuronId: neuronId ?? this.neuronId,
      type: type ?? this.type,
      caption: caption ?? this.caption,
      priority: priority ?? this.priority,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (priority.present) {
      map['priority'] = Variable<int>(priority.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PayloadsCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('type: $type, ')
          ..write('caption: $caption, ')
          ..write('priority: $priority, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, TaskDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _completedMeta =
      const VerificationMeta('completed');
  @override
  late final GeneratedColumn<bool> completed =
      GeneratedColumn<bool>('completed', aliasedName, false,
          type: DriftSqlType.bool,
          requiredDuringInsert: true,
          defaultConstraints: GeneratedColumn.constraintsDependsOnDialect({
            SqlDialect.sqlite: 'CHECK ("completed" IN (0, 1))',
            SqlDialect.mysql: '',
            SqlDialect.postgres: '',
          }));
  static const VerificationMeta _dateTsMeta = const VerificationMeta('dateTs');
  @override
  late final GeneratedColumn<DateTime> dateTs = GeneratedColumn<DateTime>(
      'date_ts', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [neuronId, completed, dateTs];
  @override
  String get aliasedName => _alias ?? 'tasks';
  @override
  String get actualTableName => 'tasks';
  @override
  VerificationContext validateIntegrity(Insertable<TaskDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    if (data.containsKey('completed')) {
      context.handle(_completedMeta,
          completed.isAcceptableOrUnknown(data['completed']!, _completedMeta));
    } else if (isInserting) {
      context.missing(_completedMeta);
    }
    if (data.containsKey('date_ts')) {
      context.handle(_dateTsMeta,
          dateTs.isAcceptableOrUnknown(data['date_ts']!, _dateTsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {neuronId};
  @override
  TaskDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TaskDBO(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
      completed: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}completed'])!,
      dateTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_ts']),
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }
}

class TaskDBO extends DataClass implements Insertable<TaskDBO> {
  final String neuronId;
  final bool completed;
  final DateTime? dateTs;
  const TaskDBO({required this.neuronId, required this.completed, this.dateTs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    map['completed'] = Variable<bool>(completed);
    if (!nullToAbsent || dateTs != null) {
      map['date_ts'] = Variable<DateTime>(dateTs);
    }
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      neuronId: Value(neuronId),
      completed: Value(completed),
      dateTs:
          dateTs == null && nullToAbsent ? const Value.absent() : Value(dateTs),
    );
  }

  factory TaskDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TaskDBO(
      neuronId: serializer.fromJson<String>(json['neuronId']),
      completed: serializer.fromJson<bool>(json['completed']),
      dateTs: serializer.fromJson<DateTime?>(json['dateTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
      'completed': serializer.toJson<bool>(completed),
      'dateTs': serializer.toJson<DateTime?>(dateTs),
    };
  }

  TaskDBO copyWith(
          {String? neuronId,
          bool? completed,
          Value<DateTime?> dateTs = const Value.absent()}) =>
      TaskDBO(
        neuronId: neuronId ?? this.neuronId,
        completed: completed ?? this.completed,
        dateTs: dateTs.present ? dateTs.value : this.dateTs,
      );
  @override
  String toString() {
    return (StringBuffer('TaskDBO(')
          ..write('neuronId: $neuronId, ')
          ..write('completed: $completed, ')
          ..write('dateTs: $dateTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(neuronId, completed, dateTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TaskDBO &&
          other.neuronId == this.neuronId &&
          other.completed == this.completed &&
          other.dateTs == this.dateTs);
}

class TasksCompanion extends UpdateCompanion<TaskDBO> {
  final Value<String> neuronId;
  final Value<bool> completed;
  final Value<DateTime?> dateTs;
  final Value<int> rowid;
  const TasksCompanion({
    this.neuronId = const Value.absent(),
    this.completed = const Value.absent(),
    this.dateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String neuronId,
    required bool completed,
    this.dateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  })  : neuronId = Value(neuronId),
        completed = Value(completed);
  static Insertable<TaskDBO> custom({
    Expression<String>? neuronId,
    Expression<bool>? completed,
    Expression<DateTime>? dateTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (completed != null) 'completed': completed,
      if (dateTs != null) 'date_ts': dateTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith(
      {Value<String>? neuronId,
      Value<bool>? completed,
      Value<DateTime?>? dateTs,
      Value<int>? rowid}) {
    return TasksCompanion(
      neuronId: neuronId ?? this.neuronId,
      completed: completed ?? this.completed,
      dateTs: dateTs ?? this.dateTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (completed.present) {
      map['completed'] = Variable<bool>(completed.value);
    }
    if (dateTs.present) {
      map['date_ts'] = Variable<DateTime>(dateTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('completed: $completed, ')
          ..write('dateTs: $dateTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, NoteDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [neuronId];
  @override
  String get aliasedName => _alias ?? 'notes';
  @override
  String get actualTableName => 'notes';
  @override
  VerificationContext validateIntegrity(Insertable<NoteDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {neuronId};
  @override
  NoteDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NoteDBO(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }
}

class NoteDBO extends DataClass implements Insertable<NoteDBO> {
  final String neuronId;
  const NoteDBO({required this.neuronId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      neuronId: Value(neuronId),
    );
  }

  factory NoteDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NoteDBO(
      neuronId: serializer.fromJson<String>(json['neuronId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
    };
  }

  NoteDBO copyWith({String? neuronId}) => NoteDBO(
        neuronId: neuronId ?? this.neuronId,
      );
  @override
  String toString() {
    return (StringBuffer('NoteDBO(')
          ..write('neuronId: $neuronId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => neuronId.hashCode;
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NoteDBO && other.neuronId == this.neuronId);
}

class NotesCompanion extends UpdateCompanion<NoteDBO> {
  final Value<String> neuronId;
  final Value<int> rowid;
  const NotesCompanion({
    this.neuronId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String neuronId,
    this.rowid = const Value.absent(),
  }) : neuronId = Value(neuronId);
  static Insertable<NoteDBO> custom({
    Expression<String>? neuronId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({Value<String>? neuronId, Value<int>? rowid}) {
    return NotesCompanion(
      neuronId: neuronId ?? this.neuronId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DatesTable extends Dates with TableInfo<$DatesTable, DateDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _neuronIdMeta =
      const VerificationMeta('neuronId');
  @override
  late final GeneratedColumn<String> neuronId = GeneratedColumn<String>(
      'neuron_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _dateTsMeta = const VerificationMeta('dateTs');
  @override
  late final GeneratedColumn<DateTime> dateTs = GeneratedColumn<DateTime>(
      'date_ts', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [neuronId, dateTs];
  @override
  String get aliasedName => _alias ?? 'dates';
  @override
  String get actualTableName => 'dates';
  @override
  VerificationContext validateIntegrity(Insertable<DateDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('neuron_id')) {
      context.handle(_neuronIdMeta,
          neuronId.isAcceptableOrUnknown(data['neuron_id']!, _neuronIdMeta));
    } else if (isInserting) {
      context.missing(_neuronIdMeta);
    }
    if (data.containsKey('date_ts')) {
      context.handle(_dateTsMeta,
          dateTs.isAcceptableOrUnknown(data['date_ts']!, _dateTsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {neuronId};
  @override
  DateDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DateDBO(
      neuronId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_id'])!,
      dateTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date_ts']),
    );
  }

  @override
  $DatesTable createAlias(String alias) {
    return $DatesTable(attachedDatabase, alias);
  }
}

class DateDBO extends DataClass implements Insertable<DateDBO> {
  final String neuronId;
  final DateTime? dateTs;
  const DateDBO({required this.neuronId, this.dateTs});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['neuron_id'] = Variable<String>(neuronId);
    if (!nullToAbsent || dateTs != null) {
      map['date_ts'] = Variable<DateTime>(dateTs);
    }
    return map;
  }

  DatesCompanion toCompanion(bool nullToAbsent) {
    return DatesCompanion(
      neuronId: Value(neuronId),
      dateTs:
          dateTs == null && nullToAbsent ? const Value.absent() : Value(dateTs),
    );
  }

  factory DateDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DateDBO(
      neuronId: serializer.fromJson<String>(json['neuronId']),
      dateTs: serializer.fromJson<DateTime?>(json['dateTs']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'neuronId': serializer.toJson<String>(neuronId),
      'dateTs': serializer.toJson<DateTime?>(dateTs),
    };
  }

  DateDBO copyWith(
          {String? neuronId, Value<DateTime?> dateTs = const Value.absent()}) =>
      DateDBO(
        neuronId: neuronId ?? this.neuronId,
        dateTs: dateTs.present ? dateTs.value : this.dateTs,
      );
  @override
  String toString() {
    return (StringBuffer('DateDBO(')
          ..write('neuronId: $neuronId, ')
          ..write('dateTs: $dateTs')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(neuronId, dateTs);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DateDBO &&
          other.neuronId == this.neuronId &&
          other.dateTs == this.dateTs);
}

class DatesCompanion extends UpdateCompanion<DateDBO> {
  final Value<String> neuronId;
  final Value<DateTime?> dateTs;
  final Value<int> rowid;
  const DatesCompanion({
    this.neuronId = const Value.absent(),
    this.dateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DatesCompanion.insert({
    required String neuronId,
    this.dateTs = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : neuronId = Value(neuronId);
  static Insertable<DateDBO> custom({
    Expression<String>? neuronId,
    Expression<DateTime>? dateTs,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (neuronId != null) 'neuron_id': neuronId,
      if (dateTs != null) 'date_ts': dateTs,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DatesCompanion copyWith(
      {Value<String>? neuronId, Value<DateTime?>? dateTs, Value<int>? rowid}) {
    return DatesCompanion(
      neuronId: neuronId ?? this.neuronId,
      dateTs: dateTs ?? this.dateTs,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (neuronId.present) {
      map['neuron_id'] = Variable<String>(neuronId.value);
    }
    if (dateTs.present) {
      map['date_ts'] = Variable<DateTime>(dateTs.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DatesCompanion(')
          ..write('neuronId: $neuronId, ')
          ..write('dateTs: $dateTs, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FiltersTable extends Filters with TableInfo<$FiltersTable, FilterDBO> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FiltersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _filterIdMeta =
      const VerificationMeta('filterId');
  @override
  late final GeneratedColumn<String> filterId = GeneratedColumn<String>(
      'filter_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
      'user_id', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _captionMeta =
      const VerificationMeta('caption');
  @override
  late final GeneratedColumn<String> caption = GeneratedColumn<String>(
      'caption', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _creationTsMeta =
      const VerificationMeta('creationTs');
  @override
  late final GeneratedColumn<DateTime> creationTs = GeneratedColumn<DateTime>(
      'creation_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _updateTsMeta =
      const VerificationMeta('updateTs');
  @override
  late final GeneratedColumn<DateTime> updateTs = GeneratedColumn<DateTime>(
      'update_ts', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _tagsOperatorMeta =
      const VerificationMeta('tagsOperator');
  @override
  late final GeneratedColumnWithTypeConverter<LogicalOperator, String>
      tagsOperator = GeneratedColumn<String>(
              'tags_operator', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<LogicalOperator>($FiltersTable.$convertertagsOperator);
  static const VerificationMeta _dateOptionMeta =
      const VerificationMeta('dateOption');
  @override
  late final GeneratedColumnWithTypeConverter<DateOption, String> dateOption =
      GeneratedColumn<String>('date_option', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<DateOption>($FiltersTable.$converterdateOption);
  static const VerificationMeta _neuronTypesMeta =
      const VerificationMeta('neuronTypes');
  @override
  late final GeneratedColumnWithTypeConverter<List<NeuronType>, String>
      neuronTypes = GeneratedColumn<String>('neuron_types', aliasedName, false,
              type: DriftSqlType.string, requiredDuringInsert: true)
          .withConverter<List<NeuronType>>($FiltersTable.$converterneuronTypes);
  @override
  List<GeneratedColumn> get $columns => [
        filterId,
        userId,
        caption,
        creationTs,
        updateTs,
        tagsOperator,
        dateOption,
        neuronTypes
      ];
  @override
  String get aliasedName => _alias ?? 'filters';
  @override
  String get actualTableName => 'filters';
  @override
  VerificationContext validateIntegrity(Insertable<FilterDBO> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('filter_id')) {
      context.handle(_filterIdMeta,
          filterId.isAcceptableOrUnknown(data['filter_id']!, _filterIdMeta));
    } else if (isInserting) {
      context.missing(_filterIdMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('caption')) {
      context.handle(_captionMeta,
          caption.isAcceptableOrUnknown(data['caption']!, _captionMeta));
    } else if (isInserting) {
      context.missing(_captionMeta);
    }
    if (data.containsKey('creation_ts')) {
      context.handle(
          _creationTsMeta,
          creationTs.isAcceptableOrUnknown(
              data['creation_ts']!, _creationTsMeta));
    } else if (isInserting) {
      context.missing(_creationTsMeta);
    }
    if (data.containsKey('update_ts')) {
      context.handle(_updateTsMeta,
          updateTs.isAcceptableOrUnknown(data['update_ts']!, _updateTsMeta));
    } else if (isInserting) {
      context.missing(_updateTsMeta);
    }
    context.handle(_tagsOperatorMeta, const VerificationResult.success());
    context.handle(_dateOptionMeta, const VerificationResult.success());
    context.handle(_neuronTypesMeta, const VerificationResult.success());
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {filterId};
  @override
  FilterDBO map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FilterDBO(
      filterId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}filter_id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}user_id'])!,
      caption: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}caption'])!,
      creationTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}creation_ts'])!,
      updateTs: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}update_ts'])!,
      tagsOperator: $FiltersTable.$convertertagsOperator.fromSql(
          attachedDatabase.typeMapping.read(
              DriftSqlType.string, data['${effectivePrefix}tags_operator'])!),
      dateOption: $FiltersTable.$converterdateOption.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}date_option'])!),
      neuronTypes: $FiltersTable.$converterneuronTypes.fromSql(attachedDatabase
          .typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}neuron_types'])!),
    );
  }

  @override
  $FiltersTable createAlias(String alias) {
    return $FiltersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LogicalOperator, String, String>
      $convertertagsOperator =
      const EnumNameConverter<LogicalOperator>(LogicalOperator.values);
  static JsonTypeConverter2<DateOption, String, String> $converterdateOption =
      const EnumNameConverter<DateOption>(DateOption.values);
  static TypeConverter<List<NeuronType>, String> $converterneuronTypes =
      NeuronTypesConverter();
}

class FilterDBO extends DataClass implements Insertable<FilterDBO> {
  final String filterId;
  final String userId;
  final String caption;
  final DateTime creationTs;
  final DateTime updateTs;
  final LogicalOperator tagsOperator;
  final DateOption dateOption;
  final List<NeuronType> neuronTypes;
  const FilterDBO(
      {required this.filterId,
      required this.userId,
      required this.caption,
      required this.creationTs,
      required this.updateTs,
      required this.tagsOperator,
      required this.dateOption,
      required this.neuronTypes});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['filter_id'] = Variable<String>(filterId);
    map['user_id'] = Variable<String>(userId);
    map['caption'] = Variable<String>(caption);
    map['creation_ts'] = Variable<DateTime>(creationTs);
    map['update_ts'] = Variable<DateTime>(updateTs);
    {
      final converter = $FiltersTable.$convertertagsOperator;
      map['tags_operator'] = Variable<String>(converter.toSql(tagsOperator));
    }
    {
      final converter = $FiltersTable.$converterdateOption;
      map['date_option'] = Variable<String>(converter.toSql(dateOption));
    }
    {
      final converter = $FiltersTable.$converterneuronTypes;
      map['neuron_types'] = Variable<String>(converter.toSql(neuronTypes));
    }
    return map;
  }

  FiltersCompanion toCompanion(bool nullToAbsent) {
    return FiltersCompanion(
      filterId: Value(filterId),
      userId: Value(userId),
      caption: Value(caption),
      creationTs: Value(creationTs),
      updateTs: Value(updateTs),
      tagsOperator: Value(tagsOperator),
      dateOption: Value(dateOption),
      neuronTypes: Value(neuronTypes),
    );
  }

  factory FilterDBO.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FilterDBO(
      filterId: serializer.fromJson<String>(json['filterId']),
      userId: serializer.fromJson<String>(json['userId']),
      caption: serializer.fromJson<String>(json['caption']),
      creationTs: serializer.fromJson<DateTime>(json['creationTs']),
      updateTs: serializer.fromJson<DateTime>(json['updateTs']),
      tagsOperator: $FiltersTable.$convertertagsOperator
          .fromJson(serializer.fromJson<String>(json['tagsOperator'])),
      dateOption: $FiltersTable.$converterdateOption
          .fromJson(serializer.fromJson<String>(json['dateOption'])),
      neuronTypes: serializer.fromJson<List<NeuronType>>(json['neuronTypes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'filterId': serializer.toJson<String>(filterId),
      'userId': serializer.toJson<String>(userId),
      'caption': serializer.toJson<String>(caption),
      'creationTs': serializer.toJson<DateTime>(creationTs),
      'updateTs': serializer.toJson<DateTime>(updateTs),
      'tagsOperator': serializer.toJson<String>(
          $FiltersTable.$convertertagsOperator.toJson(tagsOperator)),
      'dateOption': serializer.toJson<String>(
          $FiltersTable.$converterdateOption.toJson(dateOption)),
      'neuronTypes': serializer.toJson<List<NeuronType>>(neuronTypes),
    };
  }

  FilterDBO copyWith(
          {String? filterId,
          String? userId,
          String? caption,
          DateTime? creationTs,
          DateTime? updateTs,
          LogicalOperator? tagsOperator,
          DateOption? dateOption,
          List<NeuronType>? neuronTypes}) =>
      FilterDBO(
        filterId: filterId ?? this.filterId,
        userId: userId ?? this.userId,
        caption: caption ?? this.caption,
        creationTs: creationTs ?? this.creationTs,
        updateTs: updateTs ?? this.updateTs,
        tagsOperator: tagsOperator ?? this.tagsOperator,
        dateOption: dateOption ?? this.dateOption,
        neuronTypes: neuronTypes ?? this.neuronTypes,
      );
  @override
  String toString() {
    return (StringBuffer('FilterDBO(')
          ..write('filterId: $filterId, ')
          ..write('userId: $userId, ')
          ..write('caption: $caption, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs, ')
          ..write('tagsOperator: $tagsOperator, ')
          ..write('dateOption: $dateOption, ')
          ..write('neuronTypes: $neuronTypes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(filterId, userId, caption, creationTs,
      updateTs, tagsOperator, dateOption, neuronTypes);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FilterDBO &&
          other.filterId == this.filterId &&
          other.userId == this.userId &&
          other.caption == this.caption &&
          other.creationTs == this.creationTs &&
          other.updateTs == this.updateTs &&
          other.tagsOperator == this.tagsOperator &&
          other.dateOption == this.dateOption &&
          other.neuronTypes == this.neuronTypes);
}

class FiltersCompanion extends UpdateCompanion<FilterDBO> {
  final Value<String> filterId;
  final Value<String> userId;
  final Value<String> caption;
  final Value<DateTime> creationTs;
  final Value<DateTime> updateTs;
  final Value<LogicalOperator> tagsOperator;
  final Value<DateOption> dateOption;
  final Value<List<NeuronType>> neuronTypes;
  final Value<int> rowid;
  const FiltersCompanion({
    this.filterId = const Value.absent(),
    this.userId = const Value.absent(),
    this.caption = const Value.absent(),
    this.creationTs = const Value.absent(),
    this.updateTs = const Value.absent(),
    this.tagsOperator = const Value.absent(),
    this.dateOption = const Value.absent(),
    this.neuronTypes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FiltersCompanion.insert({
    required String filterId,
    required String userId,
    required String caption,
    required DateTime creationTs,
    required DateTime updateTs,
    required LogicalOperator tagsOperator,
    required DateOption dateOption,
    required List<NeuronType> neuronTypes,
    this.rowid = const Value.absent(),
  })  : filterId = Value(filterId),
        userId = Value(userId),
        caption = Value(caption),
        creationTs = Value(creationTs),
        updateTs = Value(updateTs),
        tagsOperator = Value(tagsOperator),
        dateOption = Value(dateOption),
        neuronTypes = Value(neuronTypes);
  static Insertable<FilterDBO> custom({
    Expression<String>? filterId,
    Expression<String>? userId,
    Expression<String>? caption,
    Expression<DateTime>? creationTs,
    Expression<DateTime>? updateTs,
    Expression<String>? tagsOperator,
    Expression<String>? dateOption,
    Expression<String>? neuronTypes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (filterId != null) 'filter_id': filterId,
      if (userId != null) 'user_id': userId,
      if (caption != null) 'caption': caption,
      if (creationTs != null) 'creation_ts': creationTs,
      if (updateTs != null) 'update_ts': updateTs,
      if (tagsOperator != null) 'tags_operator': tagsOperator,
      if (dateOption != null) 'date_option': dateOption,
      if (neuronTypes != null) 'neuron_types': neuronTypes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FiltersCompanion copyWith(
      {Value<String>? filterId,
      Value<String>? userId,
      Value<String>? caption,
      Value<DateTime>? creationTs,
      Value<DateTime>? updateTs,
      Value<LogicalOperator>? tagsOperator,
      Value<DateOption>? dateOption,
      Value<List<NeuronType>>? neuronTypes,
      Value<int>? rowid}) {
    return FiltersCompanion(
      filterId: filterId ?? this.filterId,
      userId: userId ?? this.userId,
      caption: caption ?? this.caption,
      creationTs: creationTs ?? this.creationTs,
      updateTs: updateTs ?? this.updateTs,
      tagsOperator: tagsOperator ?? this.tagsOperator,
      dateOption: dateOption ?? this.dateOption,
      neuronTypes: neuronTypes ?? this.neuronTypes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (filterId.present) {
      map['filter_id'] = Variable<String>(filterId.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (caption.present) {
      map['caption'] = Variable<String>(caption.value);
    }
    if (creationTs.present) {
      map['creation_ts'] = Variable<DateTime>(creationTs.value);
    }
    if (updateTs.present) {
      map['update_ts'] = Variable<DateTime>(updateTs.value);
    }
    if (tagsOperator.present) {
      final converter = $FiltersTable.$convertertagsOperator;
      map['tags_operator'] =
          Variable<String>(converter.toSql(tagsOperator.value));
    }
    if (dateOption.present) {
      final converter = $FiltersTable.$converterdateOption;
      map['date_option'] = Variable<String>(converter.toSql(dateOption.value));
    }
    if (neuronTypes.present) {
      final converter = $FiltersTable.$converterneuronTypes;
      map['neuron_types'] =
          Variable<String>(converter.toSql(neuronTypes.value));
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FiltersCompanion(')
          ..write('filterId: $filterId, ')
          ..write('userId: $userId, ')
          ..write('caption: $caption, ')
          ..write('creationTs: $creationTs, ')
          ..write('updateTs: $updateTs, ')
          ..write('tagsOperator: $tagsOperator, ')
          ..write('dateOption: $dateOption, ')
          ..write('neuronTypes: $neuronTypes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CaputDatabase extends GeneratedDatabase {
  _$CaputDatabase(QueryExecutor e) : super(e);
  late final $NeuronsTable neurons = $NeuronsTable(this);
  late final $TagsTable tags = $TagsTable(this);
  late final $NeuronTagRelationsTable neuronTagRelations =
      $NeuronTagRelationsTable(this);
  late final $FilterTagRelationsTable filterTagRelations =
      $FilterTagRelationsTable(this);
  late final $FilterNeuronRelationsTable filterNeuronRelations =
      $FilterNeuronRelationsTable(this);
  late final $PayloadsTable payloads = $PayloadsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $NotesTable notes = $NotesTable(this);
  late final $DatesTable dates = $DatesTable(this);
  late final $FiltersTable filters = $FiltersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        neurons,
        tags,
        neuronTagRelations,
        filterTagRelations,
        filterNeuronRelations,
        payloads,
        tasks,
        notes,
        dates,
        filters
      ];
}
