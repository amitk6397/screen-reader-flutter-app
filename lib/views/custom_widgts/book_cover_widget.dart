import 'package:flutter/material.dart';
import '../../model/book_model.dart';
import '../../res/app_colors.dart';
import '../../utils/text_style.dart';


// ─────────────────────────────────────────────
// BOOK COVER WIDGET (Grid card)
// ─────────────────────────────────────────────
class BookCoverWidget extends StatelessWidget {
  final BookModel book;
  const BookCoverWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navyLight, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Cover art
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
              child: Container(
                color: book.coverColor,
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: Icon(
                        Icons.menu_book_rounded,
                        color: Colors.white.withOpacity(0.25),
                        size: 52,
                      ),
                    ),
                    if (book.progress > 0)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: LinearProgressIndicator(
                          value: book.progress,
                          minHeight: 3,
                          backgroundColor: Colors.black26,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.accent),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
          // Info
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  book.title,
                  style: AppTextStyles.headingSmall,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 2),
                Text(book.author,
                    style: AppTextStyles.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.accentDim,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        book.genre,
                        style: const TextStyle(
                          fontSize: 9,
                          color: AppColors.accent,
                          fontFamily: 'DMSans',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.star_rounded,
                        color: AppColors.accent2, size: 12),
                    const SizedBox(width: 2),
                    const Text('4.8',
                        style: TextStyle(
                            fontSize: 10,
                            color: AppColors.textMuted,
                            fontFamily: 'DMSans',
                            fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// FEATURED CARD WIDGET (Continue listening)
// ─────────────────────────────────────────────
class FeaturedCardWidget extends StatelessWidget {
  final BookModel book;
  const FeaturedCardWidget({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.navyLight,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
            color: AppColors.accent.withOpacity(0.18), width: 1),
      ),
      child: Row(
        children: [
          // Cover
          Container(
            width: 60,
            height: 80,
            decoration: BoxDecoration(
              color: book.coverColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(Icons.menu_book_rounded,
                color: Colors.white60, size: 30),
          ),

          const SizedBox(width: 14),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.genre.toUpperCase(),
                    style: AppTextStyles.labelMedium.copyWith(
                        color: AppColors.accent, fontSize: 10)),
                const SizedBox(height: 4),
                Text(book.title, style: AppTextStyles.headingMedium),
                const SizedBox(height: 2),
                Text('${book.author} · ${book.currentChapter}',
                    style: AppTextStyles.bodySmall),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: book.progress,
                    minHeight: 4,
                    backgroundColor: AppColors.navyMid,
                    valueColor:
                    const AlwaysStoppedAnimation<Color>(AppColors.accent),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(book.progress * 100).toInt()}% complete',
                  style: const TextStyle(
                      fontSize: 10,
                      color: AppColors.accent,
                      fontFamily: 'DMSans',
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Play
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Icon(Icons.play_arrow_rounded,
                color: AppColors.navy, size: 26),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// SECTION HEADER WIDGET
// ─────────────────────────────────────────────
class SectionHeaderWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeaderWidget({
    super.key,
    required this.title,
    this.onSeeAll,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(title, style: AppTextStyles.headingMedium),
        const Spacer(),
        if (onSeeAll != null)
          GestureDetector(
            onTap: onSeeAll,
            child: const Text(
              'See all',
              style: TextStyle(
                fontFamily: 'DMSans',
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.accent,
              ),
            ),
          ),
      ],
    );
  }
}