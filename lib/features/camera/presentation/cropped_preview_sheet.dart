import 'dart:typed_data';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../infrastructure/gemini_object_recognizer.dart';
import '../../../infrastructure/providers/database_providers.dart';
import '../domain/detected_object.dart';

class CroppedPreviewSheet extends ConsumerStatefulWidget {
  const CroppedPreviewSheet({super.key, required this.croppedBytes});

  final Uint8List croppedBytes;

  @override
  ConsumerState<CroppedPreviewSheet> createState() => _CroppedPreviewSheetState();
}

class _CroppedPreviewSheetState extends ConsumerState<CroppedPreviewSheet> {
  bool _loading = true;
  DetectedObject? _result;
  Object? _error;

  @override
  void initState() {
    super.initState();
    _identify();
  }

  Future<void> _identify() async {
    setState(() {
      _loading = true;
      _error = null;
      _result = null;
    });
    try {
      final recognizer = ref.read(geminiRecognizerProvider);
      final res = await recognizer.detectObjectNameFromImage(widget.croppedBytes);
      setState(() {
        _result = res;
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _error = e;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final h = MediaQuery.of(context).size.height;
    return CupertinoPopupSurface(
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: h * 0.72,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  'プレビュー',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      color: CupertinoColors.systemGrey6,
                      child: Center(
                        child: Image.memory(widget.croppedBytes, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_loading)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemGrey5,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CupertinoActivityIndicator(),
                        SizedBox(width: 8),
                        Text('識別中...'),
                      ],
                    ),
                  ),
                )
              else if (_error != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    decoration: BoxDecoration(
                      color: CupertinoColors.systemRed.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      '識別に失敗しました: $_error',
                      style: const TextStyle(color: CupertinoColors.systemRed),
                    ),
                  ),
                )
              else if (_result != null)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        _result!.nameEn,
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                      ),
                      if (_result!.nameJa != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            _result!.nameJa!,
                            style: const TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
                          ),
                        ),
                    ],
                  ),
                ),
              const SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Row(
                  children: [
                    Expanded(
                      child: CupertinoButton.filled(
                        onPressed: _result == null
                            ? null
                            : () async {
                                final res = _result!;
                                final en = res.nameEn;
                                final ja = res.nameJa;
                                final ok = await ref
                                    .read(vocabularyAddNotifierProvider.notifier)
                                    .addFromCameraDetection(english: en, japanese: ja);
                                if (ok) {
                                  // 直ちにホームの表示を更新させる
                                  ref.invalidate(vocabularyStatsProvider);
                                  ref.invalidate(recentVocabulariesProvider(5));
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop(res);
                                }
                              },
                        child: const Text('クイズに追加'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
