import 'package:flutter/material.dart';
import '../../../res/app_colors.dart';
import '../../../utils/text_style.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  bool _pushEnabled = true;
  bool _newReleases = true;
  bool _readingReminder = true;
  bool _weeklyDigest = false;
  bool _promotions = false;
  bool _streakAlert = true;
  TimeOfDay _reminderTime = const TimeOfDay(hour: 20, minute: 0);

  Future<void> _pickTime() async {
    final t = await showTimePicker(
      context: context,
      initialTime: _reminderTime,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.dark(
            primary: AppColors.accent,
            surface: AppColors.navyMid,
          ),
        ),
        child: child!,
      ),
    );
    if (t != null) setState(() => _reminderTime = t);
  }

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
                  const Text('Notifications', style: AppTextStyles.displaySmall),
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
                    // Master Toggle
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _pushEnabled
                            ? AppColors.warning.withOpacity(0.08)
                            : AppColors.navyMid,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                          color: _pushEnabled
                              ? AppColors.warning.withOpacity(0.4)
                              : AppColors.navyLight,
                          width: _pushEnabled ? 1.5 : 1,
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 46,
                            height: 46,
                            decoration: BoxDecoration(
                              color: AppColors.warning.withOpacity(0.15),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(Icons.notifications_active_rounded,
                                color: AppColors.warning, size: 22),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text('Push Notifications',
                                    style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textPrimary,
                                    )),
                                SizedBox(height: 2),
                                Text('Enable all notifications',
                                    style: TextStyle(
                                      fontFamily: 'DMSans',
                                      fontSize: 12,
                                      color: AppColors.textMuted,
                                    )),
                              ],
                            ),
                          ),
                          Switch(
                            value: _pushEnabled,
                            onChanged: (v) => setState(() => _pushEnabled = v),
                            activeColor: AppColors.warning,
                            activeTrackColor: AppColors.warning.withOpacity(0.3),
                            inactiveTrackColor: AppColors.navyLight,
                            inactiveThumbColor: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    _sectionLabel('Activity'),
                    const SizedBox(height: 8),

                    _notifTile(
                      'New Releases',
                      'When authors you follow release new books',
                      Icons.new_releases_outlined,
                      AppColors.accent,
                      _newReleases,
                          (v) => setState(() => _newReleases = v),
                    ),
                    const SizedBox(height: 10),
                    _notifTile(
                      'Streak Alert',
                      'Reminder to keep your reading streak',
                      Icons.local_fire_department_outlined,
                      AppColors.coverGreen,
                      _streakAlert,
                          (v) => setState(() => _streakAlert = v),
                    ),
                    const SizedBox(height: 10),
                    _notifTile(
                      'Weekly Digest',
                      'Weekly summary of your progress',
                      Icons.summarize_outlined,
                      AppColors.coverBlue,
                      _weeklyDigest,
                          (v) => setState(() => _weeklyDigest = v),
                    ),
                    const SizedBox(height: 10),
                    _notifTile(
                      'Promotions',
                      'Special deals and discounts',
                      Icons.local_offer_outlined,
                      AppColors.coverTeal,
                      _promotions,
                          (v) => setState(() => _promotions = v),
                    ),

                    const SizedBox(height: 20),

                    _sectionLabel('Reading Reminder'),
                    const SizedBox(height: 8),

                    _notifTile(
                      'Daily Reminder',
                      'Remind me to read every day',
                      Icons.alarm_rounded,
                      AppColors.coverPurple,
                      _readingReminder,
                          (v) => setState(() => _readingReminder = v),
                    ),

                    if (_readingReminder) ...[
                      const SizedBox(height: 10),
                      GestureDetector(
                        onTap: _pickTime,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 14),
                          decoration: BoxDecoration(
                            color: AppColors.navyMid,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.navyLight),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.access_time_rounded,
                                  color: AppColors.textMuted, size: 18),
                              const SizedBox(width: 12),
                              const Text('Reminder Time',
                                  style: TextStyle(
                                    fontFamily: 'DMSans',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  )),
                              const Spacer(),
                              Text(
                                _reminderTime.format(context),
                                style: const TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.accent,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Icon(Icons.chevron_right_rounded,
                                  color: AppColors.textMuted, size: 18),
                            ],
                          ),
                        ),
                      ),
                    ],

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

  Widget _notifTile(String title, String subtitle, IconData icon, Color color,
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
            value: value && _pushEnabled,
            onChanged: _pushEnabled ? onChanged : null,
            activeColor: color,
            activeTrackColor: color.withOpacity(0.3),
            inactiveTrackColor: AppColors.navyLight,
            inactiveThumbColor: AppColors.textMuted,
          ),
        ],
      ),
    );
  }
}