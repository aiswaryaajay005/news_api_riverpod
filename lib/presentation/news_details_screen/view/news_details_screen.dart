import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:news_api_riverpod/global_constants/app_colors.dart';
import 'package:news_api_riverpod/repository/api/news_res_model.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsScreen extends ConsumerWidget {
  final Article article;
  NewsDetailsScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: const Text(
          "Article",
          style: TextStyle(color: AppColors.textPrimary),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.primary,
                    ),
                    child: Text(
                      article.source?.name ?? "The verge",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                article.title ?? "headings",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                ),
              ),
              SizedBox(height: 10),
              Text(
                article.description ?? "preview",
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Text(
                    article.publishedAt.toString() ?? "25-10-2023",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      article.author ?? "Maya",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Container(
                height: 250,
                width: double.infinity,

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      article.urlToImage ??
                          "https://images.pexels.com/photos/30007522/pexels-photo-30007522/free-photo-of-intricate-spiral-staircase-in-lighthouse.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load",
                    ),
                  ),
                ),
              ),

              SizedBox(height: 10),
              Text(
                article.content ?? "Secondary text",
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    final url = Uri.parse(
                      article.url ?? "https://www.theverge.com/",
                    );
                    if (!await launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    )) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Could not launch the article")),
                      );
                    }
                  } catch (e) {
                    debugPrint("Error launching URL: $e");
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Failed to launch URL")),
                    );
                  }
                },

                child: Text(
                  "Read more",
                  style: TextStyle(color: AppColors.primary),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
