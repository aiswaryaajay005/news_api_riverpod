import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/global_constants/app_colors.dart';
import 'package:news_api_riverpod/presentation/news_details_screen/view/news_details_screen.dart';
import 'package:news_api_riverpod/presentation/saved_news_screen/controller/saved_news_screen_controller.dart';
import 'package:news_api_riverpod/presentation/search_screen/controller/search_Screen_controller.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState = ref.watch(searchScreenProvider);
    final searchController = ref.watch(searchQueryControllerProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        toolbarHeight: 100,
        title: TextFormField(
          maxLines: 1,
          controller: searchController,
          decoration: InputDecoration(
            hintText: 'Search news...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppColors.textSecondary),
            ),
            suffix: IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                ref
                    .read(searchScreenProvider.notifier)
                    .fetchSearchedNews(searchQuery: searchController.text);
              },
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
      body:
          screenState.isLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                itemCount: screenState.searchResults.length,
                itemBuilder: (context, index) {
                  final article = screenState.searchResults[index];
                  return InkWell(
                    onTap:
                        () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => NewsDetailsScreen(
                                  article: screenState.searchResults[index],
                                ),
                          ),
                        ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),

                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.textSecondary,
                          width: 1,
                        ),
                        color: AppColors.cardBackground,
                        borderRadius: BorderRadius.circular(10),
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
                                      screenState
                                              .searchResults[index]
                                              .urlToImage ??
                                          "https://images.pexels.com/photos/27910927/pexels-photo-27910927/free-photo-of-my-friends.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Flexible(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      screenState
                                              .searchResults[index]
                                              .source
                                              ?.name ??
                                          "",
                                      style: const TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      screenState.searchResults[index].title ??
                                          "",
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
                                      children: [
                                        Expanded(
                                          child: Text(
                                            screenState
                                                    .searchResults[index]
                                                    .author ??
                                                "",
                                            style: const TextStyle(
                                              color: AppColors.textSecondary,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            final article =
                                                screenState
                                                    .searchResults[index];
                                            if (article.title != null &&
                                                article.source?.name != null) {
                                              print("Saving article:");
                                              print("Title: ${article.title}");
                                              print(
                                                "Source: ${article.source?.name}",
                                              );
                                              print(
                                                "Image URL: ${article.urlToImage}",
                                              );
                                              ref
                                                  .read(
                                                    savedNewsScreenProvider
                                                        .notifier,
                                                  )
                                                  .addNews(
                                                    article.title!,
                                                    article.source!.name!,
                                                    article.urlToImage ?? '',
                                                  );
                                            } else {
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Missing title or source. Cannot save this article.',
                                                  ),
                                                ),
                                              );
                                            }
                                          },
                                          icon: Icon(
                                            Icons.bookmark_border,
                                            color: AppColors.textSecondary,
                                          ),
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
              ),
    );
  }
}
