import 'package:flutter/material.dart';
import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({super.key});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen>
    with SingleTickerProviderStateMixin {
  bool _isPlaying = true;
  double _progress = 0.38;
  int _selectedSpeed = 2; // 1.25x
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  final List<String> _speeds = ['0.75×', '1×', '1.25×', '1.5×', '2×'];
  final BookModel _book = sampleBooks[0];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  String _formatTime(double ratio, int totalSec) {
    final s = (ratio * totalSec).toInt();
    final m = s ~/ 60;
    final sec = s % 60;
    return '${m.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    const totalSec = 2890;

    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ─────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: Row(
                children: [
                  Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textPrimary(context), size: 28),
                  const Spacer(),
                  Text('NOW PLAYING',
                      style: AppTextStyles.labelMedium.copyWith(
                          color: AppColors.textMuted(context))),
                  const Spacer(),
                  Icon(Icons.more_vert_rounded,
                      color: AppColors.textPrimary(context), size: 22),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Art ────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: AnimatedBuilder(
                animation: _pulseController,
                builder: (_, child) => Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: _isPlaying ? _pulseAnim.value * 1.1 : 1.0,
                      child: Container(
                        width: 240, height: 240,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _book.coverColor.withOpacity(0.05),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: _isPlaying ? _pulseAnim.value : 1.0,
                      child: Container(
                        width: 200, height: 200,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _book.coverColor.withOpacity(0.1),
                        ),
                      ),
                    ),
                    Container(
                      width: 200, height: 200,
                      decoration: BoxDecoration(
                        color: AppColors.navyMid(context),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                            color: AppColors.navyLight(context), width: 1.5),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.headphones_rounded,
                              color: AppColors.accent, size: 64),
                          const SizedBox(height: 8),
                          Container(
                            height: 3, width: 40,
                            decoration: BoxDecoration(
                              color: AppColors.accent.withOpacity(0.4),
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // ── Title + heart ──────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(_book.currentChapter,
                            style: AppTextStyles.labelLarge.copyWith(
                                color: AppColors.textMuted(context))),
                        const SizedBox(height: 4),
                        Text(_book.title,
                            style: AppTextStyles.displaySmall.copyWith(
                                color: AppColors.textPrimary(context))),
                        const SizedBox(height: 2),
                        Text(_book.author,
                            style: AppTextStyles.bodyMedium.copyWith(
                                color: AppColors.textMuted(context))),
                      ],
                    ),
                  ),
                  Container(
                    width: 40, height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.accentDim,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.favorite_border_rounded,
                        color: AppColors.accent, size: 20),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Seek bar ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  SliderTheme(
                    data: SliderThemeData(
                      trackHeight: 4,
                      thumbShape: const RoundSliderThumbShape(
                          enabledThumbRadius: 7),
                      overlayShape: SliderComponentShape.noOverlay,
                      activeTrackColor: AppColors.accent,
                      inactiveTrackColor: AppColors.navyLight(context),
                      thumbColor: Colors.white,
                    ),
                    child: Slider(
                      value: _progress,
                      onChanged: (v) => setState(() => _progress = v),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(_formatTime(_progress, totalSec),
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted(context))),
                        Text(_formatTime(1.0, totalSec),
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted(context))),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Controls ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _ctrlBtn(context, Icons.replay_10_rounded),
                  _ctrlBtn(context, Icons.skip_previous_rounded),
                  GestureDetector(
                    onTap: () =>
                        setState(() => _isPlaying = !_isPlaying),
                    child: Container(
                      width: 64, height: 64,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Icon(
                        _isPlaying
                            ? Icons.pause_rounded
                            : Icons.play_arrow_rounded,
                        color: AppColors.navy(context),
                        size: 32,
                      ),
                    ),
                  ),
                  _ctrlBtn(context, Icons.skip_next_rounded),
                  _ctrlBtn(context, Icons.forward_10_rounded),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // ── Speed chips ────────────────────────────────────────────────
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_speeds.length, (i) {
                final sel = i == _selectedSpeed;
                return GestureDetector(
                  onTap: () => setState(() => _selectedSpeed = i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: sel
                          ? AppColors.accentDim
                          : AppColors.navyMid(context),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: sel
                            ? AppColors.accentBorder
                            : AppColors.navyLight(context),
                        width: 1.5,
                      ),
                    ),
                    child: Text(
                      _speeds[i],
                      style: TextStyle(
                        fontFamily: 'DMSans',
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: sel
                            ? AppColors.accent
                            : AppColors.textMuted(context),
                      ),
                    ),
                  ),
                );
              }),
            ),

            const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _ctrlBtn(BuildContext context, IconData icon) {
    return Container(
      width: 46, height: 46,
      decoration: BoxDecoration(
        color: AppColors.navyMid(context),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navyLight(context), width: 1),
      ),
      child: Icon(icon, color: AppColors.textSecondary, size: 22),
    );
  }
}