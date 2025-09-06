import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/app_database.dart';
import '../repository/vocabulary_repository.dart';

// データベースのプロバイダー（シングルトン）
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(() => db.close());
  return db;
});

// リポジトリのプロバイダー
final vocabularyRepositoryProvider = Provider<VocabularyRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return VocabularyRepository(db);
});

// 全単語リストのプロバイダー（Stream）
final vocabulariesStreamProvider = StreamProvider<List<Vocabulary>>((ref) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return repository.watchAllVocabularies();
});

// 未マスター単語リストのプロバイダー（Stream）
final unmasteredVocabulariesStreamProvider = StreamProvider.family<List<Vocabulary>, int>((ref, limit) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return repository.watchUnmasteredVocabularies(limit: limit);
});

// 単語統計のプロバイダー（DB変更を監視して自動更新）
final vocabularyStatsProvider = StreamProvider<VocabularyStats>((ref) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return repository.watchStats();
});

// クイズ用単語リストのプロバイダー
final quizVocabulariesProvider = FutureProvider<List<Vocabulary>>((ref) async {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return await repository.getQuizVocabularies();
});

// 最近追加された単語のプロバイダー
final recentVocabulariesProvider = FutureProvider.family<List<Vocabulary>, int>((ref, limit) async {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return await repository.getRecentVocabularies(limit: limit);
});

// 単語検索のプロバイダー
final searchVocabulariesProvider = FutureProvider.family<List<Vocabulary>, String>((ref, query) async {
  if (query.isEmpty) return [];
  final repository = ref.watch(vocabularyRepositoryProvider);
  return await repository.searchVocabularies(query);
});

// 単語追加のNotifierプロバイダー
class VocabularyAddNotifier extends StateNotifier<AsyncValue<void>> {
  final VocabularyRepository _repository;

  VocabularyAddNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<bool> addVocabulary({
    required String japanese,
    required String english,
    required String reading,
  }) async {
    state = const AsyncValue.loading();
    try {
      // 既存チェック
      final exists = await _repository.isVocabularyExists(english);
      if (exists) {
        state = AsyncValue.error('この単語は既に登録されています', StackTrace.current);
        return false;
      }

      await _repository.addVocabulary(
        japanese: japanese,
        english: english,
        reading: reading,
      );
      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<bool> addFromCameraDetection({
    required String english,
    String? japanese,
    String? reading,
  }) async {
    state = const AsyncValue.loading();
    try {
      // 既存チェック
      final exists = await _repository.isVocabularyExists(english);
      if (exists) {
        state = AsyncValue.error('この単語は既に登録されています', StackTrace.current);
        return false;
      }

      await _repository.addFromCameraDetection(
        english: english,
        japanese: japanese,
        reading: reading,
      );
      state = const AsyncValue.data(null);
      return true;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
}

final vocabularyAddNotifierProvider = StateNotifierProvider<VocabularyAddNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return VocabularyAddNotifier(repository);
});

// 単語の学習進捗更新のNotifierプロバイダー
class VocabularyProgressNotifier extends StateNotifier<AsyncValue<void>> {
  final VocabularyRepository _repository;

  VocabularyProgressNotifier(this._repository) : super(const AsyncValue.data(null));

  Future<bool> markAsMastered(int id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.markAsMastered(id);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<bool> incrementMasteredCount(int id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.incrementMasteredCount(id);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }

  Future<bool> deleteVocabulary(int id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.deleteVocabulary(id);
      state = const AsyncValue.data(null);
      return result;
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
      return false;
    }
  }
}

final vocabularyProgressNotifierProvider = StateNotifierProvider<VocabularyProgressNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(vocabularyRepositoryProvider);
  return VocabularyProgressNotifier(repository);
});
