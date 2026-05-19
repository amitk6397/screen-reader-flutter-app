import 'package:flutter/material.dart';
import 'package:screen_reader/views/after_login/account/privacy_policy_screen.dart';
import 'package:screen_reader/views/after_login/account/profile_edit.dart';
import 'package:screen_reader/views/after_login/account/sleep_time_screen.dart';
import 'package:screen_reader/views/after_login/account/voice_setting_scrren.dart';

import '../../../res/app_colors.dart';
import '../../../utils/text_style.dart';
import 'notification_screen.dart';
import 'playback_speed_screen.dart';
import 'screen_reader_screen.dart';
import 'font_size_screen.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
                child: Row(
                  children: [
                    const Text('Profile', style: AppTextStyles.displaySmall),
                    const Spacer(),
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.navyMid,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.navyLight),
                      ),
                      child: const Icon(Icons.settings_outlined,
                          color: AppColors.textMuted, size: 18),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Profile card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: AppColors.navyLight,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        color: AppColors.accent.withOpacity(0.2), width: 1),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: const BoxDecoration(
                          color: AppColors.accent,
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: Text(
                            'R',
                            style: TextStyle(
                              fontFamily: 'PlayfairDisplay',
                              fontSize: 26,
                              fontWeight: FontWeight.w700,
                              color: AppColors.navy,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('Rohan Sharma',
                                style: AppTextStyles.headingLarge),
                            const SizedBox(height: 2),
                            Text('rohan@example.com',
                                style: AppTextStyles.bodySmall),
                            const SizedBox(height: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 3),
                              decoration: BoxDecoration(
                                color: AppColors.accentDim,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Pro Member',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: AppColors.accent,
                                  fontFamily: 'DMSans',
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => const EditProfileScreen()),
                        ),
                        child: const Icon(Icons.edit_outlined,
                            color: AppColors.textMuted, size: 18),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Stats
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Row(
                  children: [
                    _statBox('47', 'Books Read'),
                    const SizedBox(width: 10),
                    _statBox('128h', 'Listened'),
                    const SizedBox(width: 10),
                    _statBox('12', 'Day Streak'),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Menu
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    _menuSection(context, 'Preferences', [
                      _MenuItem(Icons.mic_none_rounded, 'Voice Settings',
                          AppColors.coverGreen,
                          route: const VoiceSettingsScreen()),
                      _MenuItem(Icons.speed_rounded, 'Playback Speed',
                          AppColors.coverBlue,
                          route: const PlaybackSpeedScreen()),
                      _MenuItem(Icons.nightlight_round, 'Sleep Timer',
                          AppColors.coverPurple,
                          route: const SleepTimerScreen()),
                    ]),
                    const SizedBox(height: 12),
                    _menuSection(context, 'Accessibility', [
                      _MenuItem(Icons.accessibility_new_rounded, 'Screen Reader',
                          AppColors.info,
                          route: const ScreenReaderScreen()),
                      _MenuItem(Icons.text_fields_rounded, 'Font Size',
                          AppColors.coverTeal,
                          route: const FontSizeScreen()),
                    ]),
                    const SizedBox(height: 12),
                    _menuSection(context, 'Account', [
                      _MenuItem(Icons.notifications_outlined, 'Notifications',
                          AppColors.warning,
                          route: const NotificationsScreen()),
                      _MenuItem(Icons.privacy_tip_outlined, 'Privacy',
                          AppColors.textMuted,
                          route: const PrivacyScreen()),
                      _MenuItem(
                          Icons.logout_rounded, 'Log Out', AppColors.danger,
                          danger: true),
                    ]),
                  ],
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statBox(String value, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.navyLight, width: 1),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: const TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: AppColors.textMuted,
                fontFamily: 'DMSans',
                fontWeight: FontWeight.w500,
                letterSpacing: 0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _menuSection(
      BuildContext context, String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Text(title.toUpperCase(), style: AppTextStyles.labelMedium),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.navyMid,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.navyLight, width: 1),
          ),
          child: Column(
            children: items.asMap().entries.map((e) {
              final i = e.key;
              final item = e.value;
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (item.danger) {
                        // Logout popup
                        showLogoutDialog(context, onConfirm: () {
                          // TODO: Your logout logic here
                          // e.g., context.read<AuthBloc>().add(LogoutEvent());
                        });
                      } else if (item.route != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => item.route!),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
                      child: Row(
                        children: [
                          Container(
                            width: 34,
                            height: 34,
                            decoration: BoxDecoration(
                              color: item.color.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child:
                            Icon(item.icon, color: item.color, size: 17),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              item.label,
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: item.danger
                                    ? AppColors.danger
                                    : AppColors.textPrimary,
                              ),
                            ),
                          ),
                          Icon(Icons.chevron_right_rounded,
                              color: AppColors.textMuted, size: 18),
                        ],
                      ),
                    ),
                  ),
                  if (i < items.length - 1)
                    const Divider(
                        height: 1, color: AppColors.navyLight, indent: 60),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String label;
  final Color color;
  final bool danger;
  final Widget? route;

  const _MenuItem(this.icon, this.label, this.color,
      {this.danger = false, this.route});
}


/// Call this function to show the logout confirmation dialog.
/// Example usage:
///   showLogoutDialog(context, onConfirm: () { /* your logout logic */ });
void showLogoutDialog(BuildContext context, {required VoidCallback onConfirm}) {
  showDialog(
    context: context,
    barrierColor: Colors.black.withOpacity(0.6),
    builder: (_) => _LogoutDialog(onConfirm: onConfirm),
  );
}

class _LogoutDialog extends StatelessWidget {
  final VoidCallback onConfirm;
  const _LogoutDialog({required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 28),
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: AppColors.navyMid,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
              color: AppColors.danger.withOpacity(0.25), width: 1.5),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.danger.withOpacity(0.12),
                shape: BoxShape.circle,
                border: Border.all(
                    color: AppColors.danger.withOpacity(0.3), width: 1.5),
              ),
              child: const Icon(Icons.logout_rounded,
                  color: AppColors.danger, size: 28),
            ),

            const SizedBox(height: 18),

            const Text(
              'Log Out?',
              style: TextStyle(
                fontFamily: 'PlayfairDisplay',
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'You will be signed out of your account. Your reading progress and settings will be saved.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 13,
                color: AppColors.textMuted,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: AppColors.navyLight,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.navyLight),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      onConfirm();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        color: AppColors.danger,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Center(
                        child: Text(
                          'Log Out',
                          style: TextStyle(
                            fontFamily: 'DMSans',
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}