import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../infrastructure/providers/database_providers.dart';
import '../../camera/presentation/camera_sheet.dart';
import '../../camera/presentation/cropped_preview_sheet.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Future<void> _startCameraSheet() async {
    // カメラシートを開き、選択された領域のクロップ済み画像を受け取る
    final bytes = await showCupertinoModalPopup<Uint8List>(
      context: context,
      builder: (ctx) => const CameraSheet(),
    );
    if (!mounted || bytes == null) return;
    // 直ちにプレビューシートを表示（この時点でカメラはdismiss済み）
    await showCupertinoModalPopup(
      context: context,
      builder: (ctx) => CroppedPreviewSheet(croppedBytes: bytes),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statsAsync = ref.watch(vocabularyStatsProvider);
    final stats = statsAsync.asData?.value;
    final hasNoLocalWords = stats == null ? false : stats.totalCount == 0;
    final recentAsync = ref.watch(recentVocabulariesProvider(5));
    final recentPairs = recentAsync.asData?.value
            .map((v) => MapEntry(v.japanese, v.english))
            .toList() ??
        [];
    return CupertinoPageScaffold(
      backgroundColor: const Color(0xFF0F072C),
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: Color(0xFF0F072C),
        border: null,
        middle: Text('PhotoVoca', style: TextStyle(color: CupertinoColors.white, fontSize: 18, fontWeight: FontWeight.w700)),
      ),
      child: SafeArea(
        child: Stack(
          children: [
            ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
              children: [
                _TopStatusBar(
                  words: stats?.totalCount ?? 0,
                  mastered: stats?.masteredCount ?? 0,
                ),
                const SizedBox(height: 16),
                _PrimaryCTAButton(
                  label: 'クイズを開始',
                  icon: CupertinoIcons.play_circle,
                  onPressed: () => context.push('/quiz'),
                  gradientColors: const [Color(0xFF8E8EFF), Color(0xFF6C6CFF)],
                ),
                const SizedBox(height: 16),
                _PassportCard(
                  hasNoLocalWords: hasNoLocalWords,
                  statsWords: stats?.totalCount ?? 0,
                  statsMastered: stats?.masteredCount ?? 0,
                  recent: recentPairs,
                ),
              ],
            ),
            Positioned(
              left: 16,
              right: 16,
              bottom: 24,
              child: _PrimaryCTAButton(
                label: 'カメラで撮影',
                icon: CupertinoIcons.camera,
                onPressed: _startCameraSheet,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// period chips removed

class _PassportCard extends StatelessWidget {
  const _PassportCard({
    required this.hasNoLocalWords,
    required this.statsWords,
    required this.statsMastered,
    required this.recent,
  });
  final bool hasNoLocalWords;
  final int statsWords;
  final int statsMastered;
  final List<MapEntry<String, String>> recent;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1B0E4A), Color(0xFF0F072C)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: const Color(0xFF160B3C),
              child: hasNoLocalWords
                  ? const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: _IntroList(
                        items: [
                          MapEntry('ゆりかご', 'cradle'),
                        ],
                      ),
                    )
                  : (recent.isNotEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          child: _IntroList(items: recent),
                        )
                      : const Padding(
                          padding: EdgeInsets.symmetric(vertical: 24),
                          child: Center(child: CupertinoActivityIndicator()),
                        )),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

class _IntroList extends StatelessWidget {
  const _IntroList({required this.items});
  final List<MapEntry<String, String>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < items.length; i++) ...[
            _IntroListRow(japanese: items[i].key, english: items[i].value),
            if (i != items.length - 1) const SizedBox(height: 8),
          ],
        ],
      ),
    );
  }
}

class _IntroListRow extends StatelessWidget {
  const _IntroListRow({required this.japanese, required this.english});
  final String japanese;
  final String english;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1044),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              japanese,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                english,
                style: const TextStyle(
                  color: CupertinoColors.systemGrey,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TopStatusBar extends StatelessWidget {
  const _TopStatusBar({required this.words, required this.mastered});
  final int words;
  final int mastered;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'My study status',
          style: TextStyle(
            color: CupertinoColors.white,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: _MiniStat(label: 'Words', value: words.toString()),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _MiniStat(label: 'Mastered', value: mastered.toString()),
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1044),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
              fontSize: 12,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: CupertinoColors.white,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class _PrimaryCTAButton extends StatelessWidget {
  const _PrimaryCTAButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.gradientColors = const [Color(0xFF4C7DFF), Color(0xFF2A6BFF)],
  });

  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: gradientColors.last.withOpacity(0.35),
            blurRadius: 20,
            spreadRadius: 1,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: CupertinoButton(
        padding: const EdgeInsets.symmetric(vertical: 14),
        borderRadius: BorderRadius.circular(28),
        color: const Color(0x00000000),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: CupertinoColors.white),
              const SizedBox(width: 8),
            ],
            Text(
              label,
              style: const TextStyle(
                color: CupertinoColors.white,
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
