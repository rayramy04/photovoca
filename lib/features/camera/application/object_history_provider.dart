import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../domain/detected_object.dart';

final objectHistoryProvider = NotifierProvider<ObjectHistoryNotifier, List<DetectedObject>>(
  ObjectHistoryNotifier.new,
);

class ObjectHistoryNotifier extends Notifier<List<DetectedObject>> {
  @override
  List<DetectedObject> build() {
    return [];
  }

  void addObject(DetectedObject object) {
    final existingIndex = state.indexWhere((item) => item.nameEn == object.nameEn);
    
    if (existingIndex >= 0) {
      final updatedList = List<DetectedObject>.from(state);
      updatedList[existingIndex] = object;
      state = updatedList;
    } else {
      state = [...state, object];
    }
  }

  void clearHistory() {
    state = [];
  }
}