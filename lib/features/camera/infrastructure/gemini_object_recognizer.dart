import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../domain/detected_object.dart';

final geminiRecognizerProvider = Provider<GeminiObjectRecognizer>((ref) {
  return GeminiObjectRecognizer(apiKey: dotenv.env['API_KEY'] ?? '');
});

class GeminiObjectRecognizer {
  GeminiObjectRecognizer({required this.apiKey});

  final String apiKey;

  Future<DetectedObject> detectObjectNameFromImage(Uint8List imageBytes) async {
    if (kDebugMode) {
      debugPrint(
        '[GEMINI] detect started. keyLen=${apiKey.length}, bytes=${imageBytes.length}',
      );
    }
    if (apiKey.isEmpty) {
      throw StateError('GEMINI_API_KEY is not set');
    }
    final model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(temperature: 0.2, maxOutputTokens: 80),
    );

    // 英語/日本語のセットをJSONのみで返すよう促す
    final prompt = Content.text(
      'You are an object name detector. Given an image, respond with a compact JSON object only, no explanations. '
      '{"en":"<english singular noun>","ja":"<japanese noun>"}. '
      'Example: {"en":"bottle","ja":"ボトル"}. '
      'Return just the JSON.',
    );

    final imagePart = DataPart('image/jpeg', imageBytes);
    final response = await model.generateContent([
      prompt,
      Content.multi([imagePart]),
    ]);

    final text = response.text?.trim() ?? '';
    if (kDebugMode) {
      debugPrint('[GEMINI] response text="$text"');
    }
    try {
      final map = _tryParseJson(text);
      final en = (map['en'] as String?)?.trim();
      final ja = (map['ja'] as String?)?.trim();
      if (en != null && en.isNotEmpty) {
        return DetectedObject(nameEn: en, nameJa: ja, confidence: 0.0);
      }
    } catch (_) {}
    // フォールバック: 英語名のみ
    return DetectedObject(nameEn: text, confidence: 0.0);
  }
}

Map<String, dynamic> _tryParseJson(String raw) {
  var s = raw.trim();
  if (s.startsWith('```')) {
    final start = s.indexOf('{');
    final end = s.lastIndexOf('}');
    if (start != -1 && end != -1 && end > start) {
      s = s.substring(start, end + 1);
    }
  }
  return jsonDecode(s) as Map<String, dynamic>;
}
