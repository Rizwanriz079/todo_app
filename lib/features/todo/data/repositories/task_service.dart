import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hre/features/todo/data/models/task_model.dart';


class TaskService {
  final String _databaseUrl = 'https://hreblr-default-rtdb.asia-southeast1.firebasedatabase.app';
  
  Future<List<TodoTask>> fetchTasks(String userId, String idToken) async {
    final response = await http.get(
      Uri.parse('$_databaseUrl/tasks/$userId.json?auth=$idToken'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data == null) return [];

      return data.entries.map((e) => TodoTask.fromJson(e.key, e.value)).toList();
    } else {
      throw Exception('Failed to fetch tasks: ${response.body}');
    }
  }

  Future<TodoTask> addTask(TodoTask task, String idToken) async {
    final response = await http.post(
      Uri.parse('$_databaseUrl/tasks/${task.userId}.json?auth=$idToken'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return task.copyWith(id: data['name']);
    } else {
      String errorMessage = 'Status ${response.statusCode}: ${response.body}';
      try {
        final errorData = json.decode(response.body);
        if (errorData['error'] != null) {
          errorMessage = errorData['error'];
        }
      } catch (_) {}
      throw Exception(errorMessage);
    }
  }

  Future<void> updateTask(TodoTask task, String idToken) async {
    final response = await http.patch(
      Uri.parse('$_databaseUrl/tasks/${task.userId}/${task.id}.json?auth=$idToken'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(task.toJson()),
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Status ${response.statusCode}: ${response.body}');
    }
  }

  Future<void> deleteTask(String userId, String taskId, String idToken) async {
    final response = await http.delete(
      Uri.parse('$_databaseUrl/tasks/$userId/$taskId.json?auth=$idToken'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Status ${response.statusCode}: ${response.body}');
    }
  }
}
