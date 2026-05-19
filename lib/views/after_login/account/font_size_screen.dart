import 'package:flutter/material.dart';
import '../../../res/app_colors.dart';
import '../../../utils/text_style.dart';


class FontSizeScreen extends StatefulWidget {
  const FontSizeScreen({super.key});

  @override
  State<FontSizeScreen> createState() => _FontSizeScreenState();
}

class _FontSizeScreenState extends State<FontSizeScreen> {
  double _fontSize = 16;
  String _fontFamily = 'DMSans';
  bool _boldText = false;
  double _lineSpacing = 1.5;

  final List<Map<String, String>> _fonts = [
    {'name': 'DMSans', 'label': 'DM Sans'},
    {'name': 'PlayfairDisplay', 'label': 'Playfair'},
    {'name': 'Georgia', 'label': 'Georgia'},
    {'name': 'Courier', 'label': 'Courier'},
  ];

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
                  const Text('Font Size', style: AppTextStyles.displaySmall),
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
                    // Preview Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.navyMid,
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(
                            color: AppColors.coverTeal.withOpacity(0.3), width: 1.5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'PREVIEW',
                            style: AppTextStyles.labelMedium,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'The quick brown fox jumps over the lazy dog.',
                            style: TextStyle(
                              fontFamily: _fontFamily,
                              fontSize: _fontSize,
                              fontWeight: _boldText ? FontWeight.w700 : FontWeight.w400,
                              color: AppColors.textPrimary,
                              height: _lineSpacing,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Sample audiobook text preview at ${_fontSize.round()}px.',
                            style: TextStyle(
                              fontFamily: _fontFamily,
                              fontSize: _fontSize * 0.75,
                              color: AppColors.textMuted,
                              height: _lineSpacing,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Font Size
                    _sectionLabel('Text Size'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      decoration: BoxDecoration(
                        color: AppColors.navyMid,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.navyLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.text_fields_rounded,
                              color: AppColors.coverTeal, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColors.coverTeal,
                                inactiveTrackColor: AppColors.navyLight,
                                thumbColor: AppColors.coverTeal,
                                overlayColor: AppColors.coverTeal.withOpacity(0.1),
                                trackHeight: 3,
                              ),
                              child: Slider(
                                value: _fontSize,
                                min: 12,
                                max: 28,
                                divisions: 16,
                                onChanged: (v) =>
                                    setState(() => _fontSize = v.roundToDouble()),
                              ),
                            ),
                          ),
                          Text('${_fontSize.round()}',
                              style: const TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.coverTeal,
                              )),
                        ],
                      ),
                    ),

                    const SizedBox(height: 14),

                    // Line Spacing
                    _sectionLabel('Line Spacing'),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.fromLTRB(14, 14, 14, 10),
                      decoration: BoxDecoration(
                        color: AppColors.navyMid,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: AppColors.navyLight),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.format_line_spacing_rounded,
                              color: AppColors.coverBlue, size: 18),
                          const SizedBox(width: 8),
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: AppColors.coverBlue,
                                inactiveTrackColor: AppColors.navyLight,
                                thumbColor: AppColors.coverBlue,
                                overlayColor: AppColors.coverBlue.withOpacity(0.1),
                                trackHeight: 3,
                              ),
                              child: Slider(
                                value: _lineSpacing,
                                min: 1.0,
                                max: 2.5,
                                divisions: 15,
                                onChanged: (v) => setState(() =>
                                _lineSpacing = double.parse(v.toStringAsFixed(1))),
                              ),
                            ),
                          ),
                          Text(_lineSpacing.toStringAsFixed(1),
                              style: const TextStyle(
                                fontFamily: 'DMSans',
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                                color: AppColors.coverBlue,
                              )),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Font Family
                    _sectionLabel('Font Style'),
                    const SizedBox(height: 8),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 2.8,
                      ),
                      itemCount: _fonts.length,
                      itemBuilder: (_, i) {
                        final font = _fonts[i];
                        final isSelected = _fontFamily == font['name'];
                        return GestureDetector(
                          onTap: () =>
                              setState(() => _fontFamily = font['name']!),
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.coverTeal.withOpacity(0.1)
                                  : AppColors.navyMid,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.coverTeal
                                    : AppColors.navyLight,
                                width: isSelected ? 1.5 : 1,
                              ),
                            ),
                            child: Center(
                              child: Text(
                                font['label']!,
                                style: TextStyle(
                                  fontFamily: font['name'],
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: isSelected
                                      ? AppColors.coverTeal
                                      : AppColors.textPrimary,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 14),

                    // Bold Toggle
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 12),
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
                              color: AppColors.warning.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.format_bold_rounded,
                                color: AppColors.warning, size: 20),
                          ),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text('Bold Text',
                                style: TextStyle(
                                  fontFamily: 'DMSans',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                )),
                          ),
                          Switch(
                            value: _boldText,
                            onChanged: (v) => setState(() => _boldText = v),
                            activeColor: AppColors.warning,
                            activeTrackColor: AppColors.warning.withOpacity(0.3),
                            inactiveTrackColor: AppColors.navyLight,
                            inactiveThumbColor: AppColors.textMuted,
                          ),
                        ],
                      ),
                    ),

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
}