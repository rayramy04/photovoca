import 'package:drift/drift.dart';
import '../database/app_database.dart';

// リポジトリインターフェース
abstract class IVocabularyRepository {
  Future<List<Vocabulary>> getAllVocabularies();
  Future<List<Vocabulary>> getUnmasteredVocabularies({int limit = 10});
  Future<List<Vocabulary>> getRandomVocabularies({int limit = 10});
  Future<List<Vocabulary>> getRecentVocabularies({int limit = 20});
  Future<List<Vocabulary>> searchVocabularies(String query);
  Future<int> addVocabulary({
    required String japanese,
    required String english,
    required String reading,
  });
  Future<bool> updateVocabulary(Vocabulary vocabulary);
  Future<bool> deleteVocabulary(int id);
  Future<bool> markAsMastered(int id);
  Future<bool> incrementMasteredCount(int id);
  Future<VocabularyStats> getStats();
  Stream<VocabularyStats> watchStats();
  Stream<List<Vocabulary>> watchAllVocabularies();
  Stream<List<Vocabulary>> watchUnmasteredVocabularies({int limit = 10});
}

// リポジトリ実装
class VocabularyRepository implements IVocabularyRepository {
  final AppDatabase _db;

  VocabularyRepository(this._db);

  @override
  Future<List<Vocabulary>> getAllVocabularies() {
    return _db.getAllVocabularies();
  }

  @override
  Future<List<Vocabulary>> getUnmasteredVocabularies({int limit = 10}) {
    return _db.getUnmasteredVocabularies(limit: limit);
  }

  @override
  Future<List<Vocabulary>> getRandomVocabularies({int limit = 10}) {
    return _db.getRandomVocabularies(limit: limit);
  }

  @override
  Future<List<Vocabulary>> getRecentVocabularies({int limit = 20}) {
    return _db.getRecentVocabularies(limit: limit);
  }

  @override
  Future<List<Vocabulary>> searchVocabularies(String query) {
    return _db.searchVocabularies(query);
  }

  @override
  Future<int> addVocabulary({
    required String japanese,
    required String english,
    required String reading,
  }) {
    return _db.insertVocabulary(
      VocabulariesCompanion(
        japanese: Value(japanese),
        english: Value(english),
        reading: Value(reading),
      ),
    );
  }

  @override
  Future<bool> updateVocabulary(Vocabulary vocabulary) {
    return _db.updateVocabulary(vocabulary);
  }

  @override
  Future<bool> deleteVocabulary(int id) async {
    final result = await _db.deleteVocabulary(id);
    return result > 0;
  }

  @override
  Future<bool> markAsMastered(int id) {
    return _db.markAsMastered(id);
  }

  @override
  Future<bool> incrementMasteredCount(int id) {
    return _db.incrementMasteredCount(id);
  }

  @override
  Future<VocabularyStats> getStats() {
    return _db.getStats();
  }

  @override
  Stream<VocabularyStats> watchStats() {
    return _db.watchStats();
  }

  @override
  Stream<List<Vocabulary>> watchAllVocabularies() {
    return _db.select(_db.vocabularies).watch();
  }

  @override
  Stream<List<Vocabulary>> watchUnmasteredVocabularies({int limit = 10}) {
    return (_db.select(_db.vocabularies)
          ..where((t) => t.isMastered.equals(false))
          ..orderBy([
            (t) => OrderingTerm(expression: t.masteredCount),
            (t) => OrderingTerm.random()
          ])
          ..limit(limit))
        .watch();
  }

  // カメラで撮影した物体から単語を追加するヘルパーメソッド
  Future<int> addFromCameraDetection({
    required String english,
    String? japanese,
    String? reading,
  }) async {
    // 日本語訳と読みがない場合はデフォルト値を設定
    final japaneseText = (japanese == null || japanese.trim().isEmpty) ? english : japanese;
    // 読みはDB制約で長さ1以上が必要。未指定なら日本語訳か英語で代用
    final fallback = japaneseText.isNotEmpty ? japaneseText : english;
    final readingText = (reading == null || reading.trim().isEmpty) ? fallback : reading;

    return addVocabulary(
      japanese: japaneseText,
      english: english,
      reading: readingText,
    );
  }

  // 既存の単語かチェック
  Future<bool> isVocabularyExists(String english) async {
    final results = await (_db.select(_db.vocabularies)
          ..where((t) => t.english.equals(english)))
        .get();
    return results.isNotEmpty;
  }

  // クイズ用の単語リストを取得（マスター済みと未マスターを混ぜる）
  Future<List<Vocabulary>> getQuizVocabularies({
    int unmasteredLimit = 7,
    int masteredLimit = 3,
  }) async {
    final unmastered = await getUnmasteredVocabularies(limit: unmasteredLimit);
    final mastered = await (_db.select(_db.vocabularies)
          ..where((t) => t.isMastered.equals(true))
          ..orderBy([(t) => OrderingTerm.random()])
          ..limit(masteredLimit))
        .get();

    final combined = [...unmastered, ...mastered];
    combined.shuffle(); // リストをシャッフル
    return combined;
  }
}
