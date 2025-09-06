import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:sqlite3/sqlite3.dart';
import 'package:sqlite3_flutter_libs/sqlite3_flutter_libs.dart';

part 'app_database.g.dart';

// シンプルな語彙テーブル定義（画像なし）
class Vocabularies extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get japanese => text().withLength(min: 1, max: 100)();
  TextColumn get english => text().withLength(min: 1, max: 100)();
  TextColumn get reading => text().withLength(min: 1, max: 100)(); // ひらがな読み
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  IntColumn get masteredCount => integer().withDefault(const Constant(0))(); // マスター回数
  BoolColumn get isMastered => boolean().withDefault(const Constant(false))(); // マスター済みフラグ
  DateTimeColumn get lastReviewedAt => dateTime().nullable()(); // 最後に復習した日時
}

@DriftDatabase(tables: [Vocabularies])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // 全単語を取得
  Future<List<Vocabulary>> getAllVocabularies() => select(vocabularies).get();

  // 単語を追加
  Future<int> insertVocabulary(VocabulariesCompanion entry) =>
      into(vocabularies).insert(entry);

  // 単語を更新
  Future<bool> updateVocabulary(Vocabulary vocabulary) =>
      update(vocabularies).replace(vocabulary);

  // 単語を削除
  Future<int> deleteVocabulary(int id) =>
      (delete(vocabularies)..where((t) => t.id.equals(id))).go();

  // マスターしていない単語を取得（クイズ用）
  Future<List<Vocabulary>> getUnmasteredVocabularies({int limit = 10}) {
    return (select(vocabularies)
          ..where((t) => t.isMastered.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.masteredCount),
            (t) => OrderingTerm.random()
          ])
          ..limit(limit))
        .get();
  }

  // ランダムな単語を取得（クイズ用）
  Future<List<Vocabulary>> getRandomVocabularies({int limit = 10}) {
    return (select(vocabularies)
          ..orderBy([(t) => OrderingTerm.random()])
          ..limit(limit))
        .get();
  }

  // 単語をマスター済みにする
  Future<bool> markAsMastered(int id) {
    return (update(vocabularies)..where((t) => t.id.equals(id))).write(
      VocabulariesCompanion(
        isMastered: const Value(true),
        masteredCount: Value.absent(),
        lastReviewedAt: Value(DateTime.now()),
      ),
    ).then((value) => value > 0);
  }

  // マスター回数を増やす
  Future<bool> incrementMasteredCount(int id) async {
    final vocabulary = await (select(vocabularies)
          ..where((t) => t.id.equals(id)))
        .getSingleOrNull();
    
    if (vocabulary == null) return false;
    
    return (update(vocabularies)..where((t) => t.id.equals(id))).write(
      VocabulariesCompanion(
        masteredCount: Value(vocabulary.masteredCount + 1),
        lastReviewedAt: Value(DateTime.now()),
        isMastered: Value(vocabulary.masteredCount + 1 >= 3), // 3回以上でマスター
      ),
    ).then((value) => value > 0);
  }

  // 最近追加された単語を取得
  Future<List<Vocabulary>> getRecentVocabularies({int limit = 20}) {
    return (select(vocabularies)
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)])
          ..limit(limit))
        .get();
  }

  // 単語を検索
  Future<List<Vocabulary>> searchVocabularies(String query) {
    return (select(vocabularies)
          ..where((t) => 
              t.japanese.contains(query) |
              t.english.contains(query) |
              t.reading.contains(query)))
        .get();
  }

  // 統計情報を取得
  Future<VocabularyStats> getStats() async {
    final total = await (selectOnly(vocabularies)
          ..addColumns([vocabularies.id.count()]))
        .map((row) => row.read(vocabularies.id.count()) ?? 0)
        .getSingle();

    final mastered = await (selectOnly(vocabularies)
          ..where(vocabularies.isMastered.equals(true))
          ..addColumns([vocabularies.id.count()]))
        .map((row) => row.read(vocabularies.id.count()) ?? 0)
        .getSingle();

    return VocabularyStats(
      totalCount: total,
      masteredCount: mastered,
      unmasteredCount: total - mastered,
    );
  }

  // 統計情報を監視（テーブル変更に追随してUI更新）
  Stream<VocabularyStats> watchStats() {
    return select(vocabularies).watch().map((rows) {
      final total = rows.length;
      final mastered = rows.where((v) => v.isMastered).length;
      return VocabularyStats(
        totalCount: total,
        masteredCount: mastered,
        unmasteredCount: total - mastered,
      );
    });
  }
}

// 統計情報クラス
class VocabularyStats {
  final int totalCount;
  final int masteredCount;
  final int unmasteredCount;

  VocabularyStats({
    required this.totalCount,
    required this.masteredCount,
    required this.unmasteredCount,
  });

  double get masteredPercentage => 
      totalCount > 0 ? (masteredCount / totalCount) * 100 : 0;
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'vocabulary.db'));
    assert(() {
      // 開発時にDBパスを出力して実体を確認できるように
      // ignore: avoid_print
      print('[DB] path: ' + file.path);
      return true;
    }());

    if (Platform.isAndroid) {
      await applyWorkaroundToOpenSqlite3OnOldAndroidVersions();
    }

    final cachebase = (await getTemporaryDirectory()).path;
    sqlite3.tempDirectory = cachebase;

    return NativeDatabase.createInBackground(file);
  });
}
