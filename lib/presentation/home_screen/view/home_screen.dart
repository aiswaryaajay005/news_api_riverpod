import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/global_constants/app_colors.dart';
import 'package:news_api_riverpod/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:news_api_riverpod/presentation/home_screen/state/home_screen_state.dart';
import 'package:news_api_riverpod/presentation/news_details_screen/view/news_details_screen.dart';
import 'package:news_api_riverpod/presentation/saved_news_screen/controller/saved_news_screen_controller.dart';
import 'package:news_api_riverpod/presentation/search_screen/view/search_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? category;
  const HomeScreen({super.key, this.category});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final category = widget.category ?? 'everything';
      await ref.read(homeProvider.notifier).fetchNews(category: category);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(homeProvider) as HomeScreenState;
    final formattedDate = DateFormat(
      'EEEE, dd MMMM yyyy',
    ).format(screenState.todayDate);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: AppColors.background,
        title: Column(
          children: [
            Text(
              widget.category ?? "EchoNow",
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                formattedDate,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SearchScreen()),
              );
            },
            icon: const Icon(Icons.search),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child:
            screenState.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.separated(
                  shrinkWrap: true,
                  itemCount: screenState.artList.length,
                  itemBuilder: (context, index) {
                    final article = screenState.artList[index];
                    final isSaved = screenState.savedTitles.contains(
                      article.title,
                    );

                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailsScreen(article: article),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackground,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: AppColors.darkText,
                            width: 0.9,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.darkText.withOpacity(0.1),
                              blurRadius: 5,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 100,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        article.urlToImage ??
                                            "https://images.pexels.com/photos/2893525/pexels-photo-2893525.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        article.source?.name ?? "",
                                        style: const TextStyle(
                                          color: AppColors.textSecondary,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        article.title ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: AppColors.textPrimary,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Expanded(
                                            child: Text(
                                              article.author ?? "",
                                              style: const TextStyle(
                                                color: AppColors.textSecondary,
                                                fontSize: 12,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              isSaved
                                                  ? Icons.bookmark
                                                  : Icons.bookmark_border,
                                              color: AppColors.textSecondary,
                                            ),
                                            onPressed: () async {
                                              final controller = ref.read(
                                                savedNewsScreenProvider
                                                    .notifier,
                                              );
                                              if (article.title != null &&
                                                  article.source?.name !=
                                                      null) {
                                                if (isSaved) {
                                                  final saved =
                                                      ref
                                                          .read(
                                                            savedNewsScreenProvider,
                                                          )
                                                          .savedNews;
                                                  final matching = saved
                                                      .firstWhere(
                                                        (e) =>
                                                            e['title'] ==
                                                            article.title,
                                                        orElse: () => {},
                                                      );
                                                  if (matching.isNotEmpty &&
                                                      matching['id'] != null) {
                                                    await controller.deleteNews(
                                                      matching['id'],
                                                    );
                                                  }
                                                } else {
                                                  await controller.addNews(
                                                    article.title!,
                                                    article.source!.name!,
                                                    article.urlToImage ?? '',
                                                  );
                                                }

                                                await ref
                                                    .read(homeProvider.notifier)
                                                    .fetchNews(
                                                      category:
                                                          widget.category ??
                                                          'everything',
                                                    );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder:
                      (context, index) => const Divider(
                        color: AppColors.darkText,
                        thickness: 3,
                      ),
                ),
      ),
    );
  }
}
