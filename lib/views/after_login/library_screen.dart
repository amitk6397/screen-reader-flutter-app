import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../res/app_colors.dart';
import '../../utils/text_style.dart';
import '../../view_model/after_login_ctr/book_reader_controller.dart';
import 'book_reader_screen.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _filter = 0;
  final List<String> _filters = ['All', 'In Progress', 'Finished', 'Saved'];

  List<BookModel> get _filteredBooks {
    switch (_filter) {
      case 1: return sampleBooks.where((b) => b.status == 'in_progress').toList();
      case 2: return sampleBooks.where((b) => b.status == 'finished').toList();
      case 3: return sampleBooks.where((b) => b.status == 'saved').toList();
      default: return sampleBooks;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ────────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 16, 12, 0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('My Library', style: AppTextStyles.displaySmall),
                      const SizedBox(height: 2),
                      Text('${sampleBooks.length} books · 3 in progress',
                          style: AppTextStyles.bodySmall),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: AppColors.navyMid,
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: AppColors.navyLight),
                    ),
                    child: const Icon(Icons.add_rounded,
                        color: AppColors.accent, size: 20),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // ── Filter chips ──────────────────────────────────────────────────
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _filters.length,
                itemBuilder: (_, i) {
                  final sel = i == _filter;
                  return GestureDetector(
                    onTap: () => setState(() => _filter = i),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 250),
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: sel ? AppColors.accent : AppColors.navyMid,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: sel ? AppColors.accent : AppColors.navyLight,
                          width: 1.5,
                        ),
                      ),
                      child: Text(
                        _filters[i],
                        style: TextStyle(
                          fontFamily: 'DMSans',
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: sel ? AppColors.navy : AppColors.textMuted,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // ── Book List ─────────────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: _filteredBooks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (_, i) =>
                    _LibraryItem(book: _filteredBooks[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Library Item ──────────────────────────────────────────────────────────────

class _LibraryItem extends StatelessWidget {
  final BookModel book;
  const _LibraryItem({required this.book});

  @override
  Widget build(BuildContext context) {
    // Get controller without re-registering
    final reader = Get.put(ScreenReaderController());

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.navyMid,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.navyLight, width: 1),
      ),
      child: Row(
        children: [
          // ── Cover ──────────────────────────────────────────────────────────
          Container(
            width: 44,
            height: 58,
            decoration: BoxDecoration(
              color: book.coverColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.menu_book_rounded,
                color: Colors.white60, size: 24),
          ),

          const SizedBox(width: 14),

          // ── Info ───────────────────────────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(book.title,
                    style: AppTextStyles.headingSmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis),
                const SizedBox(height: 2),
                Text(book.author, style: AppTextStyles.bodySmall),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: LinearProgressIndicator(
                    value: book.progress,
                    minHeight: 3,
                    backgroundColor: AppColors.navyLight,
                    valueColor:
                    AlwaysStoppedAnimation<Color>(book.coverColor),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${(book.progress * 100).toInt()}% complete',
                  style: TextStyle(
                    fontSize: 10,
                    color: book.coverColor,
                    fontFamily: 'DMSans',
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // ── Play button → open BookReaderScreen ────────────────────────────
          GestureDetector(
            onTap: () {
              // Stop any current speech before opening new book
              reader.stop();
              Get.to(
                    () => BookReaderScreen(book: book),
                transition: Transition.cupertino,
              );
            },
            child: Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: book.coverColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: book.coverColor.withOpacity(0.4), width: 1),
              ),
              child: Icon(Icons.play_arrow_rounded,
                  color: book.coverColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}