import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/presentation/bottom_nav_bar/view/bottom_nav_bar.dart';
import 'package:news_api_riverpod/repository/sqflite_helper/sqflite_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SqfliteHelper.initDb();
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BottomNavBar(),
    );
  }
}
