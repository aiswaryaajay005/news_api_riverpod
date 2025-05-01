import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/home_screen/controller/home_screen_controller.dart';
import 'package:news_api_riverpod/presentation/home_screen/state/home_screen_state.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      ref.read(homeProvider.notifier).fetchNews(category: 'everything');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenState = ref.watch(homeProvider) as HomeScreenState;
    return Scaffold(
      appBar: AppBar(title: const Text("EchoNow")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: screenState.artList.length,
          itemBuilder:
              (context, index) => Column(
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
                              screenState.artList[index].urlToImage ??
                                  "https://images.pexels.com/photos/27910927/pexels-photo-27910927/free-photo-of-my-friends.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Flexible(
                        // <-- Add this to constrain width
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              screenState.artList[index].source?.name ?? "",
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              screenState.artList[index].title ?? "",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    screenState.artList[index].author ?? "",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                const Icon(Icons.bookmark),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
          separatorBuilder:
              (context, index) =>
                  const Divider(color: Colors.grey, thickness: 3),
        ),
      ),
    );
  }
}
