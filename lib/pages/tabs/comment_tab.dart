import 'package:flutter/material.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/async_data_view.dart';
import 'package:json_placeholder/widget/comment_widget.dart';

class CommentTab extends StatelessWidget {
  const CommentTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView(
      onFetch: ApiServices.fetchComment,
      itemBuilder: (context, comments, index) {
        return CommentWidget(comments: comments);
      },
      title: "comments",
    );
  }
}
