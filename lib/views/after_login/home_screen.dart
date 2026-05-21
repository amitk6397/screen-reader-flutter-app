import 'package:flutter/material.dart';

import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../custom_widgts/book_cover_widget.dart';
import 'package:screen_reader/utils/textstyle.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedCategory = 0;

  final List<String> _categories = [
    'All',
    'Non-Fiction',
    'Fiction',
    'Productivity',
    'Philosophy',
    'Science',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy(context),
      body: CustomScrollView(
        slivers: [
          // App Bar / Header
          SliverToBoxAdapter(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Good evening 👋',
                              style: text14(
                                color: AppColors.textMuted(context),
                                context: context,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Rohan',
                              style: text26(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary(context),
                                context: context,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Stack(
                          children: [
                            Container(
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                color: AppColors.navyMid(context),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.navyLight(context),
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.notifications_outlined,
                                color: AppColors.textPrimary(context),
                                size: 22,
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: Container(
                                width: 9,
                                height: 9,
                                decoration: BoxDecoration(
                                  color: AppColors.accent,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.navy(context),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // Search Bar
                    Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.navyMid(context),
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: AppColors.navyLight(context),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 16),
                          Icon(
                            Icons.search_rounded,
                            color: AppColors.textMuted(context),
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Search books, articles…',
                              style: text15(
                                color: AppColors.textMuted(context),
                                context: context,
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(6),
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: AppColors.accentDim,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.tune_rounded,
                              color: AppColors.accent,
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Daily Streak Banner
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: AppColors.accent.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.local_fire_department_rounded,
                        color: AppColors.accent,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '12-day streak! Keep it up 🔥',
                            style: text16(
                              fontWeight: FontWeight.w600,
                              color: AppColors.accent,
                              context: context,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Listen for 20 more min to keep your streak',
                            style: text13(
                              color: AppColors.textMuted(context),
                              context: context,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.accent,
                      size: 22,
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Continue Listening
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: SectionHeaderWidget(
                title: 'Continue Listening',
                onSeeAll: () {},
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
              child: FeaturedCardWidget(book: sampleBooks[0]),
            ),
          ),

          // Quick Actions
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
              child: Row(
                children: [
                  _quickAction(
                    context,
                    icon: Icons.nightlight_round,
                    label: 'Sleep\nTimer',
                    color: AppColors.coverPurple,
                  ),
                  const SizedBox(width: 10),
                  _quickAction(
                    context,
                    icon: Icons.speed_rounded,
                    label: 'Speed\nControl',
                    color: AppColors.coverBlue,
                  ),
                  const SizedBox(width: 10),
                  _quickAction(
                    context,
                    icon: Icons.bookmark_rounded,
                    label: 'Book\nmarks',
                    color: AppColors.coverGreen,
                  ),
                  const SizedBox(width: 10),
                  _quickAction(
                    context,
                    icon: Icons.equalizer_rounded,
                    label: 'Voice\nSettings',
                    color: AppColors.coverOrange,
                  ),
                ],
              ),
            ),
          ),

          // Categories
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                  child: SectionHeaderWidget(title: 'Explore', onSeeAll: () {}),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _categories.length,
                    itemBuilder: (_, i) {
                      final selected = i == _selectedCategory;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 250),
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: selected
                                ? AppColors.accent
                                : AppColors.navyMid(context),
                            borderRadius: BorderRadius.circular(30),
                            border: Border.all(
                              color: selected
                                  ? AppColors.accent
                                  : AppColors.navyLight(context),
                              width: 1.5,
                            ),
                          ),
                          child: Text(
                            _categories[i],
                            style: text14(
                              fontWeight: FontWeight.w600,
                              color: selected
                                  ? AppColors.navy(context)
                                  : AppColors.textMuted(context),
                              context: context,
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

          // Book Grid
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.72,
              ),
              delegate: SliverChildBuilderDelegate(
                (_, i) =>
                    BookCoverWidget(book: sampleBooks[i % sampleBooks.length]),
                childCount: 4,
              ),
            ),
          ),

          // Trending This Week
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 28, 20, 0),
              child: SectionHeaderWidget(
                title: 'Trending This Week',
                onSeeAll: () {},
              ),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
            sliver: SliverToBoxAdapter(
              child: SizedBox(
                height: 205,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: sampleBooks.length,
                  itemBuilder: (_, i) => _trendingCard(context, sampleBooks[i]),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Quick Action Widget
  Widget _quickAction(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.navyMid(context),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.navyLight(context), width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 22),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              textAlign: TextAlign.center,
              style: text12(
                fontWeight: FontWeight.w600,
                color: AppColors.textMuted(context),
                context: context,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Trending Card
  Widget _trendingCard(BuildContext context, BookModel book) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 145,
            decoration: BoxDecoration(
              color: book.coverColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Stack(
              children: [
                const Center(
                  child: Icon(
                    Icons.menu_book_rounded,
                    color: Colors.white30,
                    size: 52,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 7,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star_rounded,
                          color: AppColors.accent,
                          size: 12,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          '4.8',
                          style: text12(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            context: context,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Text(
            book.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: text16(
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary(context),
              context: context,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            book.author,
            style: text13(
              color: AppColors.textMuted(context),
              context: context,
            ),
          ),
        ],
      ),
    );
  }
}
