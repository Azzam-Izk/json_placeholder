import 'package:flutter/material.dart';
import 'package:json_placeholder/models/users.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/async_data_view.dart';
import 'package:json_placeholder/widget/user_widget.dart';

class UserTab extends StatelessWidget {
  const UserTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Users>(
      onFetch: ApiServices.fetchUser,
      itemBuilder: (context, user, index) {
        return UserWidget(user: user);
      },
      title: "Users",
    );
  }
}