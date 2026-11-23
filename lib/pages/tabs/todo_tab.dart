import 'package:flutter/material.dart';
import 'package:json_placeholder/models/todos.dart';
import 'package:json_placeholder/services/api_services.dart';
import 'package:json_placeholder/widget/todo_widget.dart';

enum _TodoFilter { all, active, completed }

class TodoTab extends StatefulWidget {
  const TodoTab({super.key});

  @override
  State<TodoTab> createState() => _TodoTabState();
}

class _TodoTabState extends State<TodoTab> {
  List<Todos> _todos = [];
  final Map<int, bool> _completionOverrides = {};
  _TodoFilter _filter = _TodoFilter.all;
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos({bool refreshing = false}) async {
    if (!refreshing) {
      setState(() {
        _isLoading = true;
      });
    }

    try {
      final fetchedTodos = await ApiServices.fetchTodo();
      if (!mounted) return;

      setState(() {
        _todos = fetchedTodos
            .map(
              (todo) => todo.copyWith(
                completed: _completionOverrides[todo.id] ?? todo.completed,
              ),
            )
            .toList();
        _error = null;
        _isLoading = false;
      });
    } catch (error) {
      if (!mounted) return;

      setState(() {
        _error = error.toString();
        _isLoading = false;
      });
    }
  }

  void _updateTodo(Todos todo, bool completed) {
    setState(() {
      _completionOverrides[todo.id] = completed;
      _todos = _todos
          .map(
            (item) =>
                item.id == todo.id ? item.copyWith(completed: completed) : item,
          )
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final completedCount = _todos.where((todo) => todo.completed).length;
    final activeCount = _todos.length - completedCount;
    final visibleTodos = _todos.where((todo) {
      switch (_filter) {
        case _TodoFilter.active:
          return !todo.completed;
        case _TodoFilter.completed:
          return todo.completed;
        case _TodoFilter.all:
          return true;
      }
    }).toList();

    if (_isLoading && _todos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null && _todos.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.cloud_off_outlined,
                size: 42,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 12),
              Text(
                "Todo tidak dapat dimuat",
                style: theme.textTheme.titleMedium,
              ),
              const SizedBox(height: 6),
              Text(
                _error!,
                textAlign: TextAlign.center,
                style: theme.textTheme.bodySmall,
              ),
              const SizedBox(height: 16),
              FilledButton.icon(
                onPressed: _loadTodos,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text("Coba lagi"),
              ),
            ],
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => _loadTodos(refreshing: true),
      child: ListView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 12),
        children: [
          if (_error != null)
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
              child: Material(
                color: theme.colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Text(
                    "Refresh gagal: $_error",
                    style: TextStyle(color: theme.colorScheme.onErrorContainer),
                  ),
                ),
              ),
            ),
          Card(
            margin: const EdgeInsets.fromLTRB(12, 12, 12, 6),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Progres tugas",
                          style: theme.textTheme.titleMedium,
                        ),
                      ),
                      Text(
                        "$completedCount/${_todos.length}",
                        style: theme.textTheme.labelLarge?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: LinearProgressIndicator(
                      value: _todos.isEmpty
                          ? 0
                          : completedCount / _todos.length,
                      minHeight: 8,
                      backgroundColor:
                          theme.colorScheme.surfaceContainerHighest,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "$activeCount belum selesai  ·  $completedCount selesai",
                    style: theme.textTheme.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: [
                      _filterChip("Semua", _TodoFilter.all, _todos.length),
                      _filterChip("Aktif", _TodoFilter.active, activeCount),
                      _filterChip(
                        "Selesai",
                        _TodoFilter.completed,
                        completedCount,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          if (_todos.isEmpty)
            const Padding(
              padding: EdgeInsets.all(32),
              child: Center(child: Text("Belum ada todo untuk ditampilkan.")),
            )
          else if (visibleTodos.isEmpty)
            Padding(
              padding: const EdgeInsets.all(32),
              child: Center(
                child: Text(
                  "Tidak ada todo dalam kategori ini.",
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            )
          else
            ...visibleTodos.map(
              (todo) => TodoWidget(
                todo: todo,
                onChanged: (completed) => _updateTodo(todo, completed),
              ),
            ),
          const Padding(
            padding: EdgeInsets.fromLTRB(20, 8, 20, 12),
            child: Text(
              "Perubahan status tersimpan sementara di sesi ini.",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Color(0xFF6B7C8F)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _filterChip(String label, _TodoFilter filter, int count) {
    return ChoiceChip(
      label: Text("$label ($count)"),
      selected: _filter == filter,
      onSelected: (_) => setState(() => _filter = filter),
    );
  }
}
