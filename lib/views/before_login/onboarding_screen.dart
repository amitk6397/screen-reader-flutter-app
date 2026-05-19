import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../../routes/app_routes.dart';
import '../../utils/text_style.dart';
import 'register_screen.dart';
import 'login_screen.dart';

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
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            // Page View (Art Area)
            Expanded(
              flex: 5,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (i) => setState(() => _currentPage = i),
                itemCount: _pages.length,
                itemBuilder: (_, i) => _OnboardPage(data: _pages[i]),
              ),
            ),

            // Bottom Content
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 28),

                    // Dots
                    Row(
                      children: List.generate(
                        _pages.length,
                            (i) => AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(right: 6),
                          height: 4,
                          width: i == _currentPage ? 20 : 8,
                          decoration: BoxDecoration(
                            color: i == _currentPage
                                ? AppColors.accent
                                : AppColors.navyLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Title
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _pages[_currentPage].title,
                        key: ValueKey(_currentPage),
                        style: AppTextStyles.displayMedium,
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        _pages[_currentPage].subtitle,
                        key: ValueKey('sub$_currentPage'),
                        style: AppTextStyles.bodyLarge,
                      ),
                    ),

                    const Spacer(),

                    // Primary Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: _next,
                        child: Text(
                          _currentPage == _pages.length - 1
                              ? 'Get Started'
                              : 'Continue',
                        ),
                      ),
                    ),

                    // const SizedBox(height: 12),
                    //
                    // // Secondary
                    // SizedBox(
                    //   width: double.infinity,
                    //   height: 50,
                    //   child: OutlinedButton(
                    //     onPressed: () =>  Get.offNamed(AppRoutes.login
                    //     ),
                    //     child: const Text('Already have an account'),
                    //   ),
                    // ),

                    const SizedBox(height: 24),
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

class _OnboardPage extends StatelessWidget {
  final _OnboardData data;
  const _OnboardPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.navyMid,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Dashed rotating ring
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0, end: 1),
            duration: const Duration(seconds: 10),
            builder: (_, v, child) => Transform.rotate(
              angle: v * 6.28,
              child: child,
            ),
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: data.iconColor.withOpacity(0.25),
                  width: 1.5,
                  strokeAlign: BorderSide.strokeAlignOutside,
                ),
              ),
            ),
          ),
          // Inner glow circle
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: data.iconColor.withOpacity(0.12),
            ),
          ),
          // Icon
          Icon(data.icon, size: 52, color: data.iconColor),
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