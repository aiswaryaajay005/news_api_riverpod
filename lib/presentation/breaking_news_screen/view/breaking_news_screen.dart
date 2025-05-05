import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/breaking_news_screen/controller/breaking_news_screen_controller.dart';
import 'package:news_api_riverpod/presentation/breaking_news_screen/state/breaking_news_screen_state.dart';
import 'package:news_api_riverpod/presentation/news_details_screen/view/news_details_screen.dart';

class BreakingNewsScreen extends ConsumerStatefulWidget {
  const BreakingNewsScreen({super.key});

  @override
  ConsumerState<BreakingNewsScreen> createState() => _BreakingNewsScreenState();
}

class _BreakingNewsScreenState extends ConsumerState<BreakingNewsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final screenState =
          ref.read(BreakingNewsProvider) as BreakingNewsScreenState;
      if (screenState.artList.isEmpty) {
        ref
            .read(BreakingNewsProvider.notifier)
            .fetchBreakingNews(category: "general");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState =
        ref.watch(BreakingNewsProvider) as BreakingNewsScreenState;

    return Scaffold(
      body: PageView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: screenState.artList.length,
        scrollDirection: Axis.vertical,
        itemBuilder:
            (context, index) =>
                screenState.isLoading
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(
                            screenState.artList[index].urlToImage ??
                                "https://images.pexels.com/photos/30007522/pexels-photo-30007522/free-photo-of-intricate-spiral-staircase-in-lighthouse.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load" ??
                                "https://images.pexels.com/photos/30007522/pexels-photo-30007522/free-photo-of-intricate-spiral-staircase-in-lighthouse.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Breaking News",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  screenState.artList[index].title ??
                                      "This is a sample description of the breaking news.",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (context) => NewsDetailsScreen(
                                              article:
                                                  screenState.artList[index],
                                            ),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    margin: const EdgeInsets.only(top: 10),
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      "Read More",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
      ),
    );
  }
}
