import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoriesScreen extends ConsumerWidget {
  final List<Map<String, dynamic>> categories = [
    {'title': 'Technology', 'color': Colors.blue},
    {'title': 'Sports', 'color': Colors.green},
    {'title': 'Health', 'color': Color(0xFFB71C1C)},
    {'title': 'Business', 'color': Colors.orange},
    {'title': 'Entertainment', 'color': Colors.purple},
    {'title': 'General', 'color': Colors.teal},
    {'title': 'Editorials', 'color': Colors.green},
    {'title': 'World', 'color': Colors.red},
    {'title': 'Politics', 'color': Colors.blue},
    {'title': 'Science', 'color': Colors.yellow},
    {'title': 'Lifestyle', 'color': Colors.pink},
    {'title': 'Travel', 'color': Colors.brown},
  ];

  CategoriesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Color(0xff1c2230),
      appBar: AppBar(
        title: Row(
          children: [
            Text(
              "UP",
              style: GoogleFonts.sourceSerif4(
                textStyle: TextStyle(color: Colors.blue, fontSize: 30),
              ),
            ),
            Text(
              "NOW",
              style: GoogleFonts.sourceSerif4(
                textStyle: TextStyle(color: Colors.red, fontSize: 30),
              ),
            ),
          ],
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Container(
            height: 80,
            width: 400,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Hi,Good Morning",
                    style: GoogleFonts.sourceSerif4(
                      textStyle: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
              ),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories[index];
                return InkWell(
                  onTap: () {},
                  child: Card(
                    color: category['color'],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Center(
                      child: Text(
                        category['title'],
                        style: TextStyle(
                          color: Colors.white,
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
