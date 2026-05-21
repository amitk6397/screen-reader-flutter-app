import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import 'package:screen_reader/utils/textstyle.dart'; // As per your file path

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardData> _pages = const [
    _OnboardData(
      icon: Icons.menu_book_rounded,
      iconColor: AppColors.coverGreen,
      title: 'Listen to anything\non your screen',
      subtitle:
          'Audiara reads books, articles, messages and web pages aloud — naturally, beautifully, hands-free.',
    ),
    _OnboardData(
      icon: Icons.nightlight_round,
      iconColor: AppColors.coverPurple,
      title: 'Night reading\nwithout eye strain',
      subtitle:
          'Perfect for bedtime. Let Audiara read while you relax in the dark — no bright screens, zero strain.',
    ),
    _OnboardData(
      icon: Icons.accessibility_new_rounded,
      iconColor: AppColors.coverBlue,
      title: 'Built for everyone,\nalways accessible',
      subtitle:
          'Designed for visually impaired users and anyone who prefers audio. Customise voice, speed and tone.',
    ),
  ];

  void _next() {
    if (_currentPage < _pages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    } else {
      Get.offNamed(AppRoutes.register);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: SafeArea(
        child: Column(
          children: [
            // ── Page View (Illustration Area) ─────────────────────────────────
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _OnboardPage(data: _pages[i]),
              ),
            ),

            // ── Bottom Content ───────────────────────────────────────────────
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 32),

                    // Progress Dots
                    Row(
                      children: List.generate(
                        _pages.length,
                        (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 7),
                          height: 4,
                          width: i == _currentPage ? 22 : 8,
                          decoration: BoxDecoration(
                            color: i == _currentPage
                                ? AppColors.accent
                                : AppColors.navyLight(context),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Title
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: Text(
                        _pages[_currentPage].title,
                        key: ValueKey(_currentPage),
                        style: text26(
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary(context),
                          context: context,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // Subtitle
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 350),
                      child: Text(
                        _pages[_currentPage].subtitle,
                        key: ValueKey('sub$_currentPage'),
                        style: text16(
                          fontWeight: FontWeight.w400,
                          color: AppColors.textMuted(context),
                          context: context,
                        ),
                      ),
                    ),

                    const Spacer(),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: _next,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Get Started'
                              : 'Continue',
                          style: text16(
                            fontWeight: FontWeight.w600,
                            context: context,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Onboard Illustration Page
// ─────────────────────────────────────────────
class _OnboardPage extends StatelessWidget {
  final _OnboardData data;

  const _OnboardPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navyMid(context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Rotating outer ring
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(seconds: 12),
            builder: (_, value, child) =>
                Transform.rotate(angle: value * 6.28, child: child),
            child: Container(
              width: 172,
              height: 172,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: data.iconColor.withOpacity(0.22),
                  width: 1.8,
                ),
              ),
            ),
          ),

          // Inner glow circle
          Container(
            width: 128,
            height: 128,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.iconColor.withOpacity(0.13),
            ),
          ),

          // Main Icon
          Icon(data.icon, size: 58, color: data.iconColor),
        ],
      ),
    );
  }
}

class _OnboardData {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;

  const _OnboardData({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });
}
