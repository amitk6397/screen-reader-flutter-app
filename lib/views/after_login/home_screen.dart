import 'package:flutter/material.dart';
import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';
import '../custom_widgts/book_cover_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  final List<String> _categories = [
    'All', 'Non-Fiction', 'Fiction', 'Productivity', 'Philosophy', 'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: CustomScrollView(
        slivers: [
          // ── App bar ────────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Good evening 👋',
                                style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textMuted(context))),
                            const SizedBox(height: 2),
                            Text('Rohan',
                                style: AppTextStyles.displaySmall.copyWith(
                                    color: AppColors.textPrimary(context))),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              width: 42, height: 42,
                              decoration: BoxDecoration(
                                color: AppColors.navyMid(context),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: AppColors.navyLight(context),
                                    width: 1),
                              ),
                              child: Icon(Icons.notifications_outlined,
                                  color: AppColors.textPrimary(context),
                                  size: 20),
                            ),
                            Positioned(
                              right: 8, top: 8,
                              child: Container(
                                width: 8, height: 8,
                                decoration: BoxDecoration(
                                  color: AppColors.accent2,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: AppColors.navy(context),
                                      width: 1.5),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Search bar
                    Container(
                      height: 46,
                      decoration: BoxDecoration(
                        color: AppColors.navyMid(context),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                            color: AppColors.navyLight(context), width: 1.5),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 14),
                          Icon(Icons.search_rounded,
                              color: AppColors.textMuted(context), size: 20),
                          const SizedBox(width: 10),
                          Text('Search books, articles…',
                              style: AppTextStyles.bodyMedium.copyWith(
                                  color: AppColors.textMuted(context))),
                          const Spacer(),
                          Container(
                            margin: const EdgeInsets.all(6),
                            width: 34, height: 34,
                            decoration: BoxDecoration(
                              color: AppColors.accentDim,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(Icons.tune_rounded,
                                color: AppColors.accent, size: 16),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Daily streak banner ────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 18, 12, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.accent2Dim,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                      color: AppColors.accent2.withOpacity(0.3), width: 1),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40, height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.accent2.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.local_fire_department_rounded,
                          color: AppColors.accent2, size: 22),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('12-day streak! Keep it up 🔥',
                              style: AppTextStyles.headingSmall.copyWith(
                                  color: AppColors.accent2)),
                          const SizedBox(height: 2),
                          Text(
                            'Listen for 20 more min to keep your streak',
                            style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textMuted(context)),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.accent2, size: 20),
                  ],
                ),
              ),
            ),
          ),

          // ── Continue listening ─────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 22, 12, 0),
              child: SectionHeaderWidget(title: 'Continue Listening',
                  onSeeAll: () {}),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: FeaturedCardWidget(book: sampleBooks[0]),
            ),
          ),

          // ── Quick actions ──────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 22, 12, 0),
              child: Row(
                children: [
                  _quickAction(context,
                      icon: Icons.nightlight_round,
                      label: 'Sleep\nTimer',
                      color: AppColors.coverPurple),
                  const SizedBox(width: 10),
                  _quickAction(context,
                      icon: Icons.speed_rounded,
                      label: 'Speed\nControl',
                      color: AppColors.coverBlue),
                  const SizedBox(width: 10),
                  _quickAction(context,
                      icon: Icons.bookmark_rounded,
                      label: 'Book\nmarks',
                      color: AppColors.coverGreen),
                  const SizedBox(width: 10),
                  _quickAction(context,
                      icon: Icons.equalizer_rounded,
                      label: 'Voice\nSettings',
                      color: AppColors.coverOrange),
                ],
              ),
            ),
          ),

          // ── Categories ────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 22, 12, 0),
                  child: SectionHeaderWidget(title: 'Explore', onSeeAll: () {}),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    itemCount: _categories.length,
                    itemBuilder: (_, i) {
                      final selected = i == _selectedCategory;
                      return GestureDetector(
                        onTap: () =>
                            setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.accent
                                : AppColors.navyMid(context),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.navyLight(context),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            _categories[i],
                            style: TextStyle(
                              fontFamily: 'DMSans',
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? AppColors.navy(context)
                                  : AppColors.textMuted(context),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),

          // ── Book grid ─────────────────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                    (_, i) => BookCoverWidget(
                    book: sampleBooks[i % sampleBooks.length]),
                childCount: 4,
              ),
            ),
          ),

          // ── Trending ──────────────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(12, 24, 12, 0),
              child: SectionHeaderWidget(
                  title: 'Trending This Week', onSeeAll: () {}),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(12, 12, 0, 0),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleBooks.length,
                  itemBuilder: (_, i) =>
                      _trendingCard(context, sampleBooks[i]),
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 24)),
        ],
      ),
    );
  }

  Widget _quickAction(BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.navyMid(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.navyLight(context), width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 38, height: 38,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted(context),
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trendingCard(BuildContext context, BookModel book) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 140,
            decoration: BoxDecoration(
              color: book.coverColor,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(Icons.menu_book_rounded,
                      color: Colors.white.withOpacity(0.3), size: 50),
                ),
                Positioned(
                  top: 8, right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 3),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.35),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: const [
                        Icon(Icons.star_rounded,
                            color: AppColors.accent2, size: 11),
                        SizedBox(width: 2),
                        Text('4.8',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 10,
                                fontFamily: 'DMSans',
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: AppTextStyles.headingSmall.copyWith(
                  color: AppColors.textPrimary(context))),
          const SizedBox(height: 2),
          Text(book.author,
              style: AppTextStyles.bodySmall.copyWith(
                  color: AppColors.textMuted(context))),
        ],
      ),
    );
  }
}