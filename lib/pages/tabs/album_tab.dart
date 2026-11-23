import 'package:flutter/material.dart';
import 'package:json_placeholder/models/albums.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/album_widget.dart';
import 'package:json_placeholder/widget/async_data_view.dart';

class AlbumTab extends StatelessWidget {
  const AlbumTab({super.key});

  @override
  Widget build(BuildContext context) {
    return AsyncDataView<Albums>(
      onFetch: ApiServices.fetchAlbum,
      itemBuilder: (context, album, index) {
        return AlbumWidget(album: album);
      },
      title: "Albums",
    );
  }
}