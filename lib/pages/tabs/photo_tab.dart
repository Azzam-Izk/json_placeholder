import 'package:flutter/material.dart';
import 'package:json_placeholder/models/photos.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/async_data_view.dart';
import 'package:json_placeholder/widget/photo_widget.dart';

class PhotoTab extends StatelessWidget {
  const PhotoTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Photos>(
      onFetch: ApiServices.fetchPhoto,
      itemBuilder: (context, photo, index) {
        return PhotoWidget(photo: photo);
      },
      title: "Photos",
    );
  }
}