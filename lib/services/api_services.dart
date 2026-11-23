import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:json_placeholder/models/albums.dart';
import 'package:json_placeholder/models/comments.dart';
import 'package:json_placeholder/models/photos.dart';
import 'package:json_placeholder/models/post.dart';
import 'package:json_placeholder/models/todos.dart';
import 'package:json_placeholder/models/users.dart';

class ApiServices {
  static const String baseURL = "https://jsonplaceholder.typicode.com";

  static Future<List<Posts>> fetchPost() async {
    final response = await http.get(Uri.parse("$baseURL/posts"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Posts.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat posts (HTTP ${response.statusCode})");
    }
  }

  static Future<List<Photos>> fetchPhoto() async {
    final response = await http.get(Uri.parse("$baseURL/photos"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Photos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat photos (HTTP ${response.statusCode})");
    }
  }

  static Future<List<Albums>> fetchAlbum() async {
    final response = await http.get(Uri.parse("$baseURL/albums"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Albums.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat albums (HTTP ${response.statusCode})");
    }
  }

  static Future<List<Comments>> fetchComment() async {
    final response = await http.get(Uri.parse("$baseURL/comments"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Comments.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat comments (HTTP ${response.statusCode})");
    }
  }

  static Future<List<Todos>> fetchTodo() async {
    final response = await http.get(Uri.parse("$baseURL/todos"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Todos.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat todos (HTTP ${response.statusCode})");
    }
  }

  static Future<List<Users>> fetchUser() async {
    final response = await http.get(Uri.parse("$baseURL/users"));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data
          .map((json) => Users.fromJson(json as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception("gagal memuat users (HTTP ${response.statusCode})");
    }
  }
}
