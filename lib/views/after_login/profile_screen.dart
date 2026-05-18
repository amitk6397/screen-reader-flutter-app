import 'package:flutter/material.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';


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
                      // Avatar
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
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
                      const Icon(Icons.edit_outlined,
                          color: AppColors.textMuted, size: 18),
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
                    _menuSection('Preferences', [
                      _MenuItem(Icons.mic_none_rounded, 'Voice Settings',
                          AppColors.coverGreen),
                      _MenuItem(Icons.speed_rounded, 'Playback Speed',
                          AppColors.coverBlue),
                      _MenuItem(Icons.nightlight_round, 'Sleep Timer',
                          AppColors.coverPurple),
                    ]),
                    const SizedBox(height: 12),
                    _menuSection('Accessibility', [
                      _MenuItem(Icons.accessibility_new_rounded, 'Screen Reader',
                          AppColors.info),
                      _MenuItem(Icons.text_fields_rounded, 'Font Size',
                          AppColors.coverTeal),
                    ]),
                    const SizedBox(height: 12),
                    _menuSection('Account', [
                      _MenuItem(Icons.notifications_outlined, 'Notifications',
                          AppColors.warning),
                      _MenuItem(Icons.privacy_tip_outlined, 'Privacy',
                          AppColors.textMuted),
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

  Widget _menuSection(String title, List<_MenuItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8, left: 2),
          child: Text(title.toUpperCase(),
              style: AppTextStyles.labelMedium),
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
                  Padding(
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
                          child: Icon(item.icon,
                              color: item.color, size: 17),
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
  const _MenuItem(this.icon, this.label, this.color, {this.danger = false});
}