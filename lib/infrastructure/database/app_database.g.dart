// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $VocabulariesTable extends Vocabularies
    with TableInfo<$VocabulariesTable, Vocabulary> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VocabulariesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _japaneseMeta = const VerificationMeta(
    'japanese',
  );
  @override
  late final GeneratedColumn<String> japanese = GeneratedColumn<String>(
    'japanese',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _englishMeta = const VerificationMeta(
    'english',
  );
  @override
  late final GeneratedColumn<String> english = GeneratedColumn<String>(
    'english',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _readingMeta = const VerificationMeta(
    'reading',
  );
  @override
  late final GeneratedColumn<String> reading = GeneratedColumn<String>(
    'reading',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _masteredCountMeta = const VerificationMeta(
    'masteredCount',
  );
  @override
  late final GeneratedColumn<int> masteredCount = GeneratedColumn<int>(
    'mastered_count',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _isMasteredMeta = const VerificationMeta(
    'isMastered',
  );
  @override
  late final GeneratedColumn<bool> isMastered = GeneratedColumn<bool>(
    'is_mastered',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_mastered" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _lastReviewedAtMeta = const VerificationMeta(
    'lastReviewedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastReviewedAt =
      GeneratedColumn<DateTime>(
        'last_reviewed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    japanese,
    english,
    reading,
    createdAt,
    masteredCount,
    isMastered,
    lastReviewedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vocabularies';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vocabulary> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('japanese')) {
      context.handle(
        _japaneseMeta,
        japanese.isAcceptableOrUnknown(data['japanese']!, _japaneseMeta),
      );
    } else if (isInserting) {
      context.missing(_japaneseMeta);
    }
    if (data.containsKey('english')) {
      context.handle(
        _englishMeta,
        english.isAcceptableOrUnknown(data['english']!, _englishMeta),
      );
    } else if (isInserting) {
      context.missing(_englishMeta);
    }
    if (data.containsKey('reading')) {
      context.handle(
        _readingMeta,
        reading.isAcceptableOrUnknown(data['reading']!, _readingMeta),
      );
    } else if (isInserting) {
      context.missing(_readingMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('mastered_count')) {
      context.handle(
        _masteredCountMeta,
        masteredCount.isAcceptableOrUnknown(
          data['mastered_count']!,
          _masteredCountMeta,
        ),
      );
    }
    if (data.containsKey('is_mastered')) {
      context.handle(
        _isMasteredMeta,
        isMastered.isAcceptableOrUnknown(data['is_mastered']!, _isMasteredMeta),
      );
    }
    if (data.containsKey('last_reviewed_at')) {
      context.handle(
        _lastReviewedAtMeta,
        lastReviewedAt.isAcceptableOrUnknown(
          data['last_reviewed_at']!,
          _lastReviewedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vocabulary map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vocabulary(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      japanese: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}japanese'],
      )!,
      english: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}english'],
      )!,
      reading: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reading'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      masteredCount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mastered_count'],
      )!,
      isMastered: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_mastered'],
      )!,
      lastReviewedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_reviewed_at'],
      ),
    );
  }

  @override
  $VocabulariesTable createAlias(String alias) {
    return $VocabulariesTable(attachedDatabase, alias);
  }
}

class Vocabulary extends DataClass implements Insertable<Vocabulary> {
  final int id;
  final String japanese;
  final String english;
  final String reading;
  final DateTime createdAt;
  final int masteredCount;
  final bool isMastered;
  final DateTime? lastReviewedAt;
  const Vocabulary({
    required this.id,
    required this.japanese,
    required this.english,
    required this.reading,
    required this.createdAt,
    required this.masteredCount,
    required this.isMastered,
    this.lastReviewedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['japanese'] = Variable<String>(japanese);
    map['english'] = Variable<String>(english);
    map['reading'] = Variable<String>(reading);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['mastered_count'] = Variable<int>(masteredCount);
    map['is_mastered'] = Variable<bool>(isMastered);
    if (!nullToAbsent || lastReviewedAt != null) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt);
    }
    return map;
  }

  VocabulariesCompanion toCompanion(bool nullToAbsent) {
    return VocabulariesCompanion(
      id: Value(id),
      japanese: Value(japanese),
      english: Value(english),
      reading: Value(reading),
      createdAt: Value(createdAt),
      masteredCount: Value(masteredCount),
      isMastered: Value(isMastered),
      lastReviewedAt: lastReviewedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastReviewedAt),
    );
  }

  factory Vocabulary.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vocabulary(
      id: serializer.fromJson<int>(json['id']),
      japanese: serializer.fromJson<String>(json['japanese']),
      english: serializer.fromJson<String>(json['english']),
      reading: serializer.fromJson<String>(json['reading']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      masteredCount: serializer.fromJson<int>(json['masteredCount']),
      isMastered: serializer.fromJson<bool>(json['isMastered']),
      lastReviewedAt: serializer.fromJson<DateTime?>(json['lastReviewedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'japanese': serializer.toJson<String>(japanese),
      'english': serializer.toJson<String>(english),
      'reading': serializer.toJson<String>(reading),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'masteredCount': serializer.toJson<int>(masteredCount),
      'isMastered': serializer.toJson<bool>(isMastered),
      'lastReviewedAt': serializer.toJson<DateTime?>(lastReviewedAt),
    };
  }

  Vocabulary copyWith({
    int? id,
    String? japanese,
    String? english,
    String? reading,
    DateTime? createdAt,
    int? masteredCount,
    bool? isMastered,
    Value<DateTime?> lastReviewedAt = const Value.absent(),
  }) => Vocabulary(
    id: id ?? this.id,
    japanese: japanese ?? this.japanese,
    english: english ?? this.english,
    reading: reading ?? this.reading,
    createdAt: createdAt ?? this.createdAt,
    masteredCount: masteredCount ?? this.masteredCount,
    isMastered: isMastered ?? this.isMastered,
    lastReviewedAt: lastReviewedAt.present
        ? lastReviewedAt.value
        : this.lastReviewedAt,
  );
  Vocabulary copyWithCompanion(VocabulariesCompanion data) {
    return Vocabulary(
      id: data.id.present ? data.id.value : this.id,
      japanese: data.japanese.present ? data.japanese.value : this.japanese,
      english: data.english.present ? data.english.value : this.english,
      reading: data.reading.present ? data.reading.value : this.reading,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      masteredCount: data.masteredCount.present
          ? data.masteredCount.value
          : this.masteredCount,
      isMastered: data.isMastered.present
          ? data.isMastered.value
          : this.isMastered,
      lastReviewedAt: data.lastReviewedAt.present
          ? data.lastReviewedAt.value
          : this.lastReviewedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vocabulary(')
          ..write('id: $id, ')
          ..write('japanese: $japanese, ')
          ..write('english: $english, ')
          ..write('reading: $reading, ')
          ..write('createdAt: $createdAt, ')
          ..write('masteredCount: $masteredCount, ')
          ..write('isMastered: $isMastered, ')
          ..write('lastReviewedAt: $lastReviewedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    japanese,
    english,
    reading,
    createdAt,
    masteredCount,
    isMastered,
    lastReviewedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vocabulary &&
          other.id == this.id &&
          other.japanese == this.japanese &&
          other.english == this.english &&
          other.reading == this.reading &&
          other.createdAt == this.createdAt &&
          other.masteredCount == this.masteredCount &&
          other.isMastered == this.isMastered &&
          other.lastReviewedAt == this.lastReviewedAt);
}

class VocabulariesCompanion extends UpdateCompanion<Vocabulary> {
  final Value<int> id;
  final Value<String> japanese;
  final Value<String> english;
  final Value<String> reading;
  final Value<DateTime> createdAt;
  final Value<int> masteredCount;
  final Value<bool> isMastered;
  final Value<DateTime?> lastReviewedAt;
  const VocabulariesCompanion({
    this.id = const Value.absent(),
    this.japanese = const Value.absent(),
    this.english = const Value.absent(),
    this.reading = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.masteredCount = const Value.absent(),
    this.isMastered = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
  });
  VocabulariesCompanion.insert({
    this.id = const Value.absent(),
    required String japanese,
    required String english,
    required String reading,
    this.createdAt = const Value.absent(),
    this.masteredCount = const Value.absent(),
    this.isMastered = const Value.absent(),
    this.lastReviewedAt = const Value.absent(),
  }) : japanese = Value(japanese),
       english = Value(english),
       reading = Value(reading);
  static Insertable<Vocabulary> custom({
    Expression<int>? id,
    Expression<String>? japanese,
    Expression<String>? english,
    Expression<String>? reading,
    Expression<DateTime>? createdAt,
    Expression<int>? masteredCount,
    Expression<bool>? isMastered,
    Expression<DateTime>? lastReviewedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (japanese != null) 'japanese': japanese,
      if (english != null) 'english': english,
      if (reading != null) 'reading': reading,
      if (createdAt != null) 'created_at': createdAt,
      if (masteredCount != null) 'mastered_count': masteredCount,
      if (isMastered != null) 'is_mastered': isMastered,
      if (lastReviewedAt != null) 'last_reviewed_at': lastReviewedAt,
    });
  }

  VocabulariesCompanion copyWith({
    Value<int>? id,
    Value<String>? japanese,
    Value<String>? english,
    Value<String>? reading,
    Value<DateTime>? createdAt,
    Value<int>? masteredCount,
    Value<bool>? isMastered,
    Value<DateTime?>? lastReviewedAt,
  }) {
    return VocabulariesCompanion(
      id: id ?? this.id,
      japanese: japanese ?? this.japanese,
      english: english ?? this.english,
      reading: reading ?? this.reading,
      createdAt: createdAt ?? this.createdAt,
      masteredCount: masteredCount ?? this.masteredCount,
      isMastered: isMastered ?? this.isMastered,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (japanese.present) {
      map['japanese'] = Variable<String>(japanese.value);
    }
    if (english.present) {
      map['english'] = Variable<String>(english.value);
    }
    if (reading.present) {
      map['reading'] = Variable<String>(reading.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (masteredCount.present) {
      map['mastered_count'] = Variable<int>(masteredCount.value);
    }
    if (isMastered.present) {
      map['is_mastered'] = Variable<bool>(isMastered.value);
    }
    if (lastReviewedAt.present) {
      map['last_reviewed_at'] = Variable<DateTime>(lastReviewedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VocabulariesCompanion(')
          ..write('id: $id, ')
          ..write('japanese: $japanese, ')
          ..write('english: $english, ')
          ..write('reading: $reading, ')
          ..write('createdAt: $createdAt, ')
          ..write('masteredCount: $masteredCount, ')
          ..write('isMastered: $isMastered, ')
          ..write('lastReviewedAt: $lastReviewedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VocabulariesTable vocabularies = $VocabulariesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [vocabularies];
}

typedef $$VocabulariesTableCreateCompanionBuilder =
    VocabulariesCompanion Function({
      Value<int> id,
      required String japanese,
      required String english,
      required String reading,
      Value<DateTime> createdAt,
      Value<int> masteredCount,
      Value<bool> isMastered,
      Value<DateTime?> lastReviewedAt,
    });
typedef $$VocabulariesTableUpdateCompanionBuilder =
    VocabulariesCompanion Function({
      Value<int> id,
      Value<String> japanese,
      Value<String> english,
      Value<String> reading,
      Value<DateTime> createdAt,
      Value<int> masteredCount,
      Value<bool> isMastered,
      Value<DateTime?> lastReviewedAt,
    });

class $$VocabulariesTableFilterComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get japanese => $composableBuilder(
    column: $table.japanese,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get english => $composableBuilder(
    column: $table.english,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get masteredCount => $composableBuilder(
    column: $table.masteredCount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isMastered => $composableBuilder(
    column: $table.isMastered,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$VocabulariesTableOrderingComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get japanese => $composableBuilder(
    column: $table.japanese,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get english => $composableBuilder(
    column: $table.english,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reading => $composableBuilder(
    column: $table.reading,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get masteredCount => $composableBuilder(
    column: $table.masteredCount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isMastered => $composableBuilder(
    column: $table.isMastered,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VocabulariesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VocabulariesTable> {
  $$VocabulariesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get japanese =>
      $composableBuilder(column: $table.japanese, builder: (column) => column);

  GeneratedColumn<String> get english =>
      $composableBuilder(column: $table.english, builder: (column) => column);

  GeneratedColumn<String> get reading =>
      $composableBuilder(column: $table.reading, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<int> get masteredCount => $composableBuilder(
    column: $table.masteredCount,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isMastered => $composableBuilder(
    column: $table.isMastered,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastReviewedAt => $composableBuilder(
    column: $table.lastReviewedAt,
    builder: (column) => column,
  );
}

class $$VocabulariesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VocabulariesTable,
          Vocabulary,
          $$VocabulariesTableFilterComposer,
          $$VocabulariesTableOrderingComposer,
          $$VocabulariesTableAnnotationComposer,
          $$VocabulariesTableCreateCompanionBuilder,
          $$VocabulariesTableUpdateCompanionBuilder,
          (
            Vocabulary,
            BaseReferences<_$AppDatabase, $VocabulariesTable, Vocabulary>,
          ),
          Vocabulary,
          PrefetchHooks Function()
        > {
  $$VocabulariesTableTableManager(_$AppDatabase db, $VocabulariesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VocabulariesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VocabulariesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VocabulariesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> japanese = const Value.absent(),
                Value<String> english = const Value.absent(),
                Value<String> reading = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> masteredCount = const Value.absent(),
                Value<bool> isMastered = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
              }) => VocabulariesCompanion(
                id: id,
                japanese: japanese,
                english: english,
                reading: reading,
                createdAt: createdAt,
                masteredCount: masteredCount,
                isMastered: isMastered,
                lastReviewedAt: lastReviewedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String japanese,
                required String english,
                required String reading,
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> masteredCount = const Value.absent(),
                Value<bool> isMastered = const Value.absent(),
                Value<DateTime?> lastReviewedAt = const Value.absent(),
              }) => VocabulariesCompanion.insert(
                id: id,
                japanese: japanese,
                english: english,
                reading: reading,
                createdAt: createdAt,
                masteredCount: masteredCount,
                isMastered: isMastered,
                lastReviewedAt: lastReviewedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$VocabulariesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VocabulariesTable,
      Vocabulary,
      $$VocabulariesTableFilterComposer,
      $$VocabulariesTableOrderingComposer,
      $$VocabulariesTableAnnotationComposer,
      $$VocabulariesTableCreateCompanionBuilder,
      $$VocabulariesTableUpdateCompanionBuilder,
      (
        Vocabulary,
        BaseReferences<_$AppDatabase, $VocabulariesTable, Vocabulary>,
      ),
      Vocabulary,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VocabulariesTableTableManager get vocabularies =>
      $$VocabulariesTableTableManager(_db, _db.vocabularies);
}
