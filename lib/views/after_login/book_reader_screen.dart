import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';
import '../../view_model/after_login_ctr/book_reader_controller.dart';

class BookReaderScreen extends StatefulWidget {
  final BookModel book;
  const BookReaderScreen({super.key, required this.book});

  @override
  State<BookReaderScreen> createState() => _BookReaderScreenState();
}

class _BookReaderScreenState extends State<BookReaderScreen> {
  final ScreenReaderController _reader = Get.find<ScreenReaderController>();
  int _currentChapter = 0;
  bool _showControls = true;

  BookChapter get chapter => widget.book.chapters[_currentChapter];

  void _speakChapter() =>
      _reader.speak('${chapter.title}. ${chapter.content}');

  void _nextChapter() {
    if (_currentChapter < widget.book.chapters.length - 1) {
      _reader.stop();
      setState(() => _currentChapter++);
    }
  }

  void _prevChapter() {
    if (_currentChapter > 0) {
      _reader.stop();
      setState(() => _currentChapter--);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header (no observables here — no Obx needed) ──────────────
            _buildHeader(),

            // ── Chapter indicator + pulsing dot ───────────────────────────
            _buildChapterBar(),

            // ── Scrollable content ────────────────────────────────────────
            Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _showControls = !_showControls),
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text(
                        chapter.title,
                        style: const TextStyle(
                          fontFamily: 'PlayfairDisplay',
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 16),

                      // ── WORD HIGHLIGHT ────────────────────────────────
                      // Obx sirf is widget ke liye — teeno observables
                      // isi Obx ke direct scope mein read ho rahe hain
                      Obx(() {
                        final isActive = _reader.currentText.value.isNotEmpty;
                        final start = isActive ? _reader.currentWordStart.value : -1;
                        final end   = isActive ? _reader.currentWordEnd.value   : -1;
                        return _HighlightedText(
                          text: chapter.content,
                          currentStart: start,
                          currentEnd: end,
                        );
                      }),

                      const SizedBox(height: 80),
                    ],
                  ),
                ),
              ),
            ),

            // ── Playback controls ─────────────────────────────────────────
            if (_showControls) _buildControls(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              _reader.stop();
              Get.back();
            },
            child: Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: AppColors.navyMid,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.navyLight),
              ),
              child: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: AppColors.textMuted, size: 16),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.book.title,
                    style: AppTextStyles.headingSmall,
                    overflow: TextOverflow.ellipsis),
                Text(widget.book.author, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
          GestureDetector(
            onTap: _showSettingsSheet,
            child: Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: AppColors.navyMid,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.navyLight),
              ),
              child: const Icon(Icons.tune_rounded,
                  color: AppColors.textMuted, size: 18),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: widget.book.coverColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                  color: widget.book.coverColor.withOpacity(0.4)),
            ),
            child: Text(
              'Chapter ${_currentChapter + 1} / ${widget.book.chapters.length}',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: widget.book.coverColor,
              ),
            ),
          ),
          const Spacer(),
          // Obx sirf pulsing dot ke liye — ek hi observable: isPlaying
          Obx(() => _reader.isPlaying
              ? _PulsingDot(color: widget.book.coverColor)
              : const SizedBox.shrink()),
        ],
      ),
    );
  }

  /// Controls section — har observable apne Obx mein wrap hai
  Widget _buildControls() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 20),
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        border: Border(
            top: BorderSide(color: AppColors.navyLight.withOpacity(0.5))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [

          // Speed + pitch text — apna Obx
          Obx(() => Text(
            '${_reader.speechRate.value.toStringAsFixed(1)}x speed  •  '
                'Pitch ${_reader.pitch.value.toStringAsFixed(1)}',
            style: const TextStyle(
              fontFamily: 'DMSans',
              fontSize: 11,
              color: AppColors.textMuted,
            ),
          )),

          const SizedBox(height: 14),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Prev chapter
              _ControlButton(
                icon: Icons.skip_previous_rounded,
                size: 28,
                enabled: _currentChapter > 0,
                onTap: _prevChapter,
              ),

              // Replay
              _ControlButton(
                icon: Icons.replay_10_rounded,
                size: 28,
                onTap: () => _reader.speak(chapter.content),
              ),

              // Play / Pause — apna Obx
              Obx(() => GestureDetector(
                onTap: () => _reader.isStopped
                    ? _speakChapter()
                    : _reader.togglePlayPause(),
                child: Container(
                  width: 60, height: 60,
                  decoration: BoxDecoration(
                    color: widget.book.coverColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: widget.book.coverColor.withOpacity(0.4),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    _reader.isPlaying
                        ? Icons.pause_rounded
                        : Icons.play_arrow_rounded,
                    color: Colors.white,
                    size: 30,
                  ),
                ),
              )),

              // Stop
              _ControlButton(
                icon: Icons.stop_rounded,
                size: 28,
                onTap: () => _reader.stop(),
              ),

              // Next chapter
              _ControlButton(
                icon: Icons.skip_next_rounded,
                size: 28,
                enabled: _currentChapter < widget.book.chapters.length - 1,
                onTap: _nextChapter,
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showSettingsSheet() {
    Get.bottomSheet(
      _TtsSettingsSheet(reader: _reader),
      backgroundColor: AppColors.navyMid,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
    );
  }
}

// ─── Control Button ────────────────────────────────────────────────────────────

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final double size;
  final VoidCallback onTap;
  final bool enabled;

  const _ControlButton({
    required this.icon,
    required this.size,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Icon(icon,
          color: enabled ? AppColors.textPrimary : AppColors.textMuted,
          size: size),
    );
  }
}

// ─── Word Highlight Text ───────────────────────────────────────────────────────
// Pure StatelessWidget — observables bahar se values ke roop mein aate hain

class _HighlightedText extends StatelessWidget {
  final String text;
  final int currentStart;
  final int currentEnd;

  const _HighlightedText({
    required this.text,
    required this.currentStart,
    required this.currentEnd,
  });

  @override
  Widget build(BuildContext context) {
    const baseStyle = TextStyle(
      fontFamily: 'DMSans',
      fontSize: 15,
      color: AppColors.textPrimary,
      height: 1.8,
    );

    if (currentStart < 0 || currentStart >= text.length) {
      return Text(text, style: baseStyle);
    }

    final safeEnd = currentEnd.clamp(0, text.length);
    final before  = text.substring(0, currentStart);
    final word    = text.substring(currentStart, safeEnd);
    final after   = text.substring(safeEnd);

    return RichText(
      text: TextSpan(
        style: baseStyle,
        children: [
          TextSpan(text: before),
          TextSpan(
            text: word,
            style: TextStyle(
              backgroundColor: AppColors.accent.withOpacity(0.25),
              color: AppColors.accent,
              fontWeight: FontWeight.w700,
            ),
          ),
          TextSpan(text: after),
        ],
      ),
    );
  }
}

// ─── TTS Settings Bottom Sheet ─────────────────────────────────────────────────
// Har slider ka apna Obx — ek bada Obx nahi

class _TtsSettingsSheet extends StatelessWidget {
  final ScreenReaderController reader;
  const _TtsSettingsSheet({required this.reader});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
          16, 16, 16, MediaQuery.of(context).viewInsets.bottom + 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 36, height: 4,
              decoration: BoxDecoration(
                color: AppColors.navyLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Reader Settings',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              )),
          const SizedBox(height: 20),

          // Speed slider — apna Obx
          Obx(() => _SheetSlider(
            label: 'Speed',
            value: reader.speechRate.value,
            displayValue:
            '${reader.speechRate.value.toStringAsFixed(1)}x',
            min: 0.1,
            max: 1.0,
            icon: Icons.speed_rounded,
            color: AppColors.coverBlue,
            onChanged: reader.setSpeechRate,
          )),
          const SizedBox(height: 14),

          // Pitch slider — apna Obx
          Obx(() => _SheetSlider(
            label: 'Pitch',
            value: reader.pitch.value,
            displayValue: reader.pitch.value.toStringAsFixed(1),
            min: 0.5,
            max: 2.0,
            icon: Icons.graphic_eq_rounded,
            color: AppColors.coverPurple,
            onChanged: reader.setPitch,
          )),
          const SizedBox(height: 14),

          // Volume slider — apna Obx
          Obx(() => _SheetSlider(
            label: 'Volume',
            value: reader.volume.value,
            displayValue: '${(reader.volume.value * 100).round()}%',
            min: 0.0,
            max: 1.0,
            icon: Icons.volume_up_rounded,
            color: AppColors.coverGreen,
            onChanged: reader.setVolume,
          )),

          // Language chips — apna Obx
          Obx(() {
            if (reader.availableLanguages.isEmpty) return const SizedBox.shrink();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                const Text('LANGUAGE',
                    style: TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textMuted,
                      letterSpacing: 1,
                    )),
                const SizedBox(height: 8),
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: reader.availableLanguages.take(8).length,
                    itemBuilder: (_, i) {
                      final lang = reader.availableLanguages[i];
                      final isSelected = reader.language.value == lang;
                      return GestureDetector(
                        onTap: () => reader.setLanguage(lang),
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.accent.withOpacity(0.15)
                                : AppColors.navyLight,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: isSelected
                                  ? AppColors.accent
                                  : AppColors.navyLight,
                            ),
                          ),
                          child: Text(lang,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? AppColors.accent
                                    : AppColors.textMuted,
                              )),
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _SheetSlider extends StatelessWidget {
  final String label;
  final double value;
  final String displayValue;
  final double min;
  final double max;
  final IconData icon;
  final Color color;
  final ValueChanged<double> onChanged;

  const _SheetSlider({
    required this.label,
    required this.value,
    required this.displayValue,
    required this.min,
    required this.max,
    required this.icon,
    required this.color,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34, height: 34,
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 16),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: color,
              inactiveTrackColor: AppColors.navyLight,
              thumbColor: color,
              overlayColor: color.withOpacity(0.1),
              trackHeight: 3,
            ),
            child: Slider(
              value: value,
              min: min,
              max: max,
              onChanged: onChanged,
            ),
          ),
        ),
        SizedBox(
          width: 42,
          child: Text(displayValue,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: color,
              )),
        ),
      ],
    );
  }
}

// ─── Pulsing Dot ───────────────────────────────────────────────────────────────

class _PulsingDot extends StatefulWidget {
  final Color color;
  const _PulsingDot({required this.color});

  @override
  State<_PulsingDot> createState() => _PulsingDotState();
}

class _PulsingDotState extends State<_PulsingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900))
      ..repeat(reverse: true);
    _anim = Tween(begin: 0.4, end: 1.0)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _anim,
      child: Row(
        children: [
          Container(
            width: 6, height: 6,
            decoration:
            BoxDecoration(color: widget.color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 4),
          Text('Reading',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: widget.color,
              )),
        ],
      ),
    );
  }
}

// ─── Screen Reader Bar ─────────────────────────────────────────────────────────

class ScreenReaderBar extends GetWidget<ScreenReaderController> {
  const ScreenReaderBar({super.key});

  @override
  Widget build(BuildContext context) {
    // Single Obx — controller.isPlaying aur controller.isStopped
    // dono is ek Obx ke direct scope mein hain
    return Obx(() {
      if (controller.isStopped) return const SizedBox.shrink();
      return Container(
        margin: const EdgeInsets.all(12),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
              color: AppColors.accent.withOpacity(0.4), width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 8, height: 8,
              decoration: BoxDecoration(
                color: controller.isPlaying
                    ? AppColors.accent
                    : AppColors.textMuted,
                shape: BoxShape.circle,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                controller.isPlaying ? 'Reading...' : 'Paused',
                style: const TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            _BarButton(
              icon: Icons.replay_rounded,
              onTap: () => controller.speak(controller.currentText.value),
            ),
            _BarButton(
              icon: controller.isPlaying
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              highlight: true,
              onTap: controller.togglePlayPause,
            ),
            _BarButton(
              icon: Icons.stop_rounded,
              onTap: controller.stop,
            ),
          ],
        ),
      );
    });
  }
}

class _BarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool highlight;

  const _BarButton({
    required this.icon,
    required this.onTap,
    this.highlight = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 34, height: 34,
        margin: const EdgeInsets.only(left: 6),
        decoration: BoxDecoration(
          color: highlight
              ? AppColors.accent.withOpacity(0.15)
              : AppColors.navyLight,
          borderRadius: BorderRadius.circular(10),
          border: highlight
              ? Border.all(color: AppColors.accent.withOpacity(0.5))
              : null,
        ),
        child: Icon(icon,
            color: highlight ? AppColors.accent : AppColors.textMuted,
            size: 18),
      ),
    );
  }
}

class ScreenReaderOverlay extends StatelessWidget {
  final Widget child;
  const ScreenReaderOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const Positioned(
          bottom: 0, left: 0, right: 0,
          child: ScreenReaderBar(),
        ),
      ],
    );
  }
}