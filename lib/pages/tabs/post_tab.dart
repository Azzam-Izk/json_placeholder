import 'package:flutter/material.dart';
import 'package:json_placeholder/models/post.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/async_data_view.dart';
import 'package:json_placeholder/widget/post_widget.dart';

class PostTab extends StatelessWidget {
  const PostTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Posts>(
      onFetch: ApiServices.fetchPost,
      itemBuilder: (context, posts, index) {
        return PostWidget(post: posts);
      },
      title: "Posts",
    );
  }
}
