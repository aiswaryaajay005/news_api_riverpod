import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/global_constants/app_colors.dart';
import 'package:news_api_riverpod/presentation/bottom_nav_bar/controller/bottom_nav_bar_controller.dart';
import 'package:news_api_riverpod/presentation/home_screen/view/home_screen.dart';
import 'package:news_api_riverpod/presentation/categories_screen/view/categories_screen.dart';
import 'package:news_api_riverpod/presentation/saved_news_screen/view/saved_news_screen.dart';
import 'package:news_api_riverpod/presentation/breaking_news_screen/view/breaking_news_screen.dart';

class BottomNavBar extends ConsumerWidget {
  const BottomNavBar({super.key});

  static final List<Widget> _screens = [
    const HomeScreen(),
    CategoriesScreen(),

    BreakingNewsScreen(),
    SavedNewsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navState = ref.watch(BottomNavBarIndexProvider);
    final navController = ref.read(BottomNavBarIndexProvider.notifier);

    return Scaffold(
      body:
          navState.isLoading
              ? const Center(child: CircularProgressIndicator())
              : _screens[navState.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.background,
        currentIndex: navState.currentIndex,
        onTap: navController.changeIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),

          BottomNavigationBarItem(icon: Icon(Icons.bolt), label: 'Breaking'),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: 'Saved'),
        ],
      ),
    );
  }
}
