import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/text_style.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _logoController;
  late AnimationController _ringController;
  late AnimationController _loaderController;

  late Animation<double> _logoScale;
  late Animation<double> _logoFade;
  late Animation<double> _textFade;
  late Animation<double> _ringScale;
  late Animation<double> _loaderValue;

  @override
  void initState() {
    super.initState();

    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _ringController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat(reverse: true);
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat();

    _logoScale = Tween<double>(begin: 0.4, end: 1.0).animate(
      CurvedAnimation(parent: _logoController, curve: Curves.elasticOut),
    );
    _logoFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.0, 0.5, curve: Curves.easeIn)),
    );
    _textFade = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
          parent: _logoController,
          curve: const Interval(0.5, 1.0, curve: Curves.easeIn)),
    );
    _ringScale = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _ringController, curve: Curves.easeInOut),
    );
    _loaderValue = Tween<double>(begin: -0.4, end: 1.4).animate(
      CurvedAnimation(parent: _loaderController, curve: Curves.easeInOut),
    );

    _logoController.forward();

    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) Get.offNamed(AppRoutes.onboarding);
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _ringController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ── Pulse rings + logo ──────────────────────────────────────────
            AnimatedBuilder(
              animation: _ringController,
              builder: (_, __) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.scale(
                      scale: _ringScale.value * 1.6,
                      child: Container(
                        width: 160, height: 160,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.accent.withOpacity(0.04),
                              width: 1),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: _ringScale.value * 1.3,
                      child: Container(
                        width: 140, height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.accent.withOpacity(0.08),
                              width: 1),
                        ),
                      ),
                    ),
                    Transform.scale(
                      scale: _ringScale.value,
                      child: Container(
                        width: 120, height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                              color: AppColors.accent.withOpacity(0.14),
                              width: 1),
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                      animation: _logoController,
                      builder: (_, __) => FadeTransition(
                        opacity: _logoFade,
                        child: ScaleTransition(
                          scale: _logoScale,
                          child: Container(
                            width: 84, height: 84,
                            decoration: BoxDecoration(
                              color: AppColors.navyMid(context),
                              borderRadius: BorderRadius.circular(24),
                              border: Border.all(
                                  color: AppColors.accent, width: 2),
                            ),
                            child: const Icon(Icons.headphones_rounded,
                                color: AppColors.accent, size: 40),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),

            const SizedBox(height: 24),

            // ── App name ────────────────────────────────────────────────────
            FadeTransition(
              opacity: _textFade,
              child: Text('Audiara',
                  style: AppTextStyles.displayLarge.copyWith(
                      color: AppColors.textPrimary(context))),
            ),
            const SizedBox(height: 8),
            FadeTransition(
              opacity: _textFade,
              child: Text(
                'Read with your ears, not your eyes',
                style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.textMuted(context)),
              ),
            ),

            const SizedBox(height: 56),

            // ── Loading bar ─────────────────────────────────────────────────
            FadeTransition(
              opacity: _textFade,
              child: AnimatedBuilder(
                animation: _loaderController,
                builder: (_, __) => SizedBox(
                  width: 48, height: 3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Stack(
                      children: [
                        Container(color: AppColors.navyLight(context)),
                        FractionallySizedBox(
                          alignment: Alignment(
                              _loaderValue.value.clamp(-1.0, 1.0), 0),
                          widthFactor: 0.4,
                          child: Container(color: AppColors.accent),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}