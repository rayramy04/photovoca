import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/word_pair.dart';

// TODO: UIのチェックが終わったら削除.
final mockVocabularyProvider = Provider<List<WordPair>>((ref) {
  return [
    const WordPair(
      japanese: '机',
      english: 'desk',
      reading: 'つくえ',
      category: '家具',
    ),
    const WordPair(
      japanese: '椅子',
      english: 'chair',
      reading: 'いす',
      category: '家具',
    ),
    const WordPair(
      japanese: '本',
      english: 'book',
      reading: 'ほん',
      category: '学用品',
    ),
    const WordPair(
      japanese: 'ペン',
      english: 'pen',
      reading: 'ペン',
      category: '学用品',
    ),
    const WordPair(
      japanese: '鉛筆',
      english: 'pencil',
      reading: 'えんぴつ',
      category: '学用品',
    ),
    const WordPair(
      japanese: 'コンピューター',
      english: 'computer',
      reading: 'コンピューター',
      category: '電子機器',
    ),
    const WordPair(
      japanese: '携帯電話',
      english: 'mobile phone',
      reading: 'けいたいでんわ',
      category: '電子機器',
    ),
    const WordPair(
      japanese: '時計',
      english: 'clock',
      reading: 'とけい',
      category: '雑貨',
    ),
    const WordPair(
      japanese: 'カップ',
      english: 'cup',
      reading: 'カップ',
      category: '食器',
    ),
    const WordPair(
      japanese: '花',
      english: 'flower',
      reading: 'はな',
      category: '自然',
    ),
  ];
});