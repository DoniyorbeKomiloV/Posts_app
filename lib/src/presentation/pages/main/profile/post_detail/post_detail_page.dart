import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:posts_app/src/data/models/home/posts_response.dart';
import 'package:posts_app/src/core/utils/app_utils.dart';

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({
    super.key,
    required this.postsResponse,
  });

  final PostsResponse postsResponse;

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(title: const Text('Post Detail')),
      body: SingleChildScrollView(
        child: Padding(
          padding: AppUtils.kPaddingAll24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: 'https://picsum.photos/300/300',
                fit: BoxFit.cover,
                width: double.infinity,
                height: 300,
              ),
              AppUtils.kGap16,
              Text(
                postsResponse.title,
                style: const TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w600,
                ),
              ),
              AppUtils.kGap8,
              Text(
                postsResponse.body,
                style: const TextStyle(
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 80),
              Text(
                'creator: ${postsResponse.name}',
                style: const TextStyle(
                  fontStyle: FontStyle.italic,
                  fontSize: 17,
                  height: 22 / 17,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ),
      ));
}
