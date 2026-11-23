import 'package:flutter/material.dart';
import 'package:json_placeholder/pages/tabs/album_tab.dart';
import 'package:json_placeholder/pages/tabs/comment_tab.dart';
import 'package:json_placeholder/pages/tabs/photo_tab.dart';
import 'package:json_placeholder/pages/tabs/post_tab.dart';
import 'package:json_placeholder/pages/tabs/todo_tab.dart';
import 'package:json_placeholder/pages/tabs/user_tab.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return DefaultTabController(
      length: 6,
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 20,
          title: Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.api_rounded,
                  color: theme.colorScheme.primary,
                  size: 21,
                ),
              ),
              const SizedBox(width: 12),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'JSONPlaceholder',
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1E2D3D),
                    ),
                  ),
                  Text(
                    'Data explorer',
                    style: TextStyle(fontSize: 11, color: Color(0xFF6B7C8F)),
                  ),
                ],
              ),
            ],
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(58),
            child: Container(
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(color: Color(0xFFF0F3F6)),
                  bottom: BorderSide(color: Color(0xFFE1E8EF)),
                ),
              ),
              child: TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.start,
                labelPadding: const EdgeInsets.symmetric(horizontal: 14),
                indicatorSize: TabBarIndicatorSize.label,
                indicatorColor: theme.colorScheme.primary,
                labelColor: theme.colorScheme.primary,
                unselectedLabelColor: const Color(0xFF6B7C8F),
                dividerColor: Colors.transparent,
                labelStyle: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                ),
                tabs: const [
                  Tab(text: 'Posts', icon: Icon(Icons.article_outlined)),
                  Tab(text: 'Comments', icon: Icon(Icons.chat_bubble_outline)),
                  Tab(text: 'Albums', icon: Icon(Icons.photo_library_outlined)),
                  Tab(text: 'Users', icon: Icon(Icons.people_outline)),
                  Tab(text: 'Photos', icon: Icon(Icons.photo_outlined)),
                  Tab(text: 'Todos', icon: Icon(Icons.task_alt_outlined)),
                ],
              ),
            ),
          ),
        ),
        body: const TabBarView(
          children: [
            PostTab(),
            CommentTab(),
            AlbumTab(),
            UserTab(),
            PhotoTab(),
            TodoTab(),
          ],
        ),
      ),
    );
  }
}
