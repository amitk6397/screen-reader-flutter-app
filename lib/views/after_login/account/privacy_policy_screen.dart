import 'package:flutter/material.dart';
import '../../../res/app_colors.dart';
import '../../../utils/text_style.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  bool _shareActivity = false;
  bool _personalizedAds = false;
  bool _analytics = true;
  bool _crashReports = true;
  bool _publicProfile = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 38,
                      height: 38,
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
                  const Text('Privacy', style: AppTextStyles.displaySmall),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Info Banner
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.info.withOpacity(0.08),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.info.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.shield_outlined,
                              color: AppColors.info, size: 20),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              'Your data is encrypted and never sold to third parties.',
                              style: TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 12,
                                color: AppColors.info,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _sectionLabel('Profile'),
                    const SizedBox(height: 8),
                    _toggleTile(
                      'Public Profile',
                      'Let others find and view your profile',
                      Icons.person_outline_rounded,
                      AppColors.coverTeal,
                      _publicProfile,
                          (v) => setState(() => _publicProfile = v),
                    ),
                    const SizedBox(height: 10),
                    _toggleTile(
                      'Share Reading Activity',
                      'Show your reading progress to followers',
                      Icons.bar_chart_rounded,
                      AppColors.coverBlue,
                      _shareActivity,
                          (v) => setState(() => _shareActivity = v),
                    ),

                    const SizedBox(height: 20),

                    _sectionLabel('Data & Analytics'),
                    const SizedBox(height: 8),
                    _toggleTile(
                      'Usage Analytics',
                      'Help improve the app with anonymous data',
                      Icons.analytics_outlined,
                      AppColors.coverGreen,
                      _analytics,
                          (v) => setState(() => _analytics = v),
                    ),
                    const SizedBox(height: 10),
                    _toggleTile(
                      'Crash Reports',
                      'Automatically send crash logs',
                      Icons.bug_report_outlined,
                      AppColors.coverPurple,
                      _crashReports,
                          (v) => setState(() => _crashReports = v),
                    ),
                    const SizedBox(height: 10),
                    _toggleTile(
                      'Personalized Ads',
                      'Show ads based on your interests',
                      Icons.ads_click_rounded,
                      AppColors.textMuted,
                      _personalizedAds,
                          (v) => setState(() => _personalizedAds = v),
                    ),

                    const SizedBox(height: 20),

                    _sectionLabel('Legal'),
                    const SizedBox(height: 8),
                    _linkTile('Privacy Policy', Icons.privacy_tip_outlined,
                        AppColors.info),
                    const SizedBox(height: 10),
                    _linkTile('Terms of Service', Icons.gavel_rounded,
                        AppColors.coverTeal),
                    const SizedBox(height: 10),
                    _linkTile('Data Deletion Request',
                        Icons.delete_forever_outlined, AppColors.danger,
                        danger: true),

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

  Widget _sectionLabel(String text) => Padding(
    padding: const EdgeInsets.only(left: 2, bottom: 2),
    child: Text(text.toUpperCase(), style: AppTextStyles.labelMedium),
  );

  Widget _toggleTile(String title, String subtitle, IconData icon, Color color,
      bool value, ValueChanged<bool> onChanged) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navyLight),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                    )),
                Text(subtitle,
                    style: const TextStyle(
                      fontFamily: 'DMSans',
                      fontSize: 11,
                      color: AppColors.textMuted,
                    )),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: color,
            activeTrackColor: color.withOpacity(0.3),
            inactiveTrackColor: AppColors.navyLight,
            inactiveThumbColor: AppColors.textMuted,
          ),
        ],
      ),
    );
  }

  Widget _linkTile(String label, IconData icon, Color color,
      {bool danger = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.navyLight),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 18),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label,
                style: TextStyle(
                  fontFamily: 'DMSans',
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: danger ? AppColors.danger : AppColors.textPrimary,
                )),
          ),
          Icon(Icons.chevron_right_rounded,
              color: AppColors.textMuted, size: 18),
        ],
      ),
    );
  }
}