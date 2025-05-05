import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/global_constants/app_colors.dart';
import 'package:news_api_riverpod/presentation/categories_screen/controller/categories_screen_controller.dart';
import 'package:news_api_riverpod/presentation/categories_screen/state/categories_screen_state.dart';
import 'package:news_api_riverpod/presentation/home_screen/view/home_screen.dart';

class CategoriesScreen extends ConsumerWidget {
  CategoriesScreen({super.key});

  final List<Color> pastelColors = [
    Color(0xFFB3CDE0), // Technology - soft blue
    Color(0xFFB2DFDB), // Sports - pastel teal
    Color(0xFFF8BBD0), // Health - pastel pink
    Color(0xFFFFE0B2), // Business - light orange
    Color(0xFFE1BEE7), // Entertainment - lavender
    Color(0xFFB2EBF2), // General - pale cyan
    Color(0xFFC8E6C9), // Editorials - pastel green
    Color(0xFFFFCDD2), // World - light red
    Color(0xFFBBDEFB), // Politics - light blue
    Color(0xFFFFFFB3), // Science - soft yellow
    Color(0xFFF8BBD0), // Lifestyle - pastel pink
    Color(0xFFD7CCC8), // Travel - soft brown
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenState =
        ref.watch(CategoriesScreenProvider) as CategoriesScreenState;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text(
          "EchoNow",
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.background,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: screenState.categories.length,
              itemBuilder: (context, index) {
                final category = screenState.categories[index].trim();
                final color = pastelColors[index % pastelColors.length];

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => HomeScreen(
                              category: screenState.categories[index],
                            ),
                      ),
                    );
                  },
                  child: Card(
                    color: color,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        category,
                        style: const TextStyle(
                          color: Colors.black87,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
