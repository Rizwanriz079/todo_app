import 'package:get/get.dart';
import 'package:hre/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hre/features/todo/data/models/task_model.dart';
import 'package:hre/features/todo/data/repositories/task_service.dart';
import 'package:hre/core/utils/snackbar_utils.dart';

class TaskController extends GetxController {
  final TaskService _service = TaskService();
  final AuthController _authController = Get.find<AuthController>();

  final RxList<TodoTask> tasks = <TodoTask>[].obs;
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    ever(_authController.userRx, (user) {
      if (user != null) {
        fetchTasks();
      } else {
        tasks.clear();
      }
    });

    if (_authController.user != null) {
      fetchTasks();
    }
  }

  Future<void> fetchTasks() async {
    final user = _authController.user;
    if (user == null) return;

    try {
      isLoading.value = true;
      final idToken = await user.getIdToken();
      final fetchedTasks = await _service.fetchTasks(user.uid, idToken ?? '');
      tasks.assignAll(fetchedTasks);
    } catch (e) {
      SnackbarUtils.showError('Failed to fetch tasks: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> addTask(String title, String description) async {
    final user = _authController.user;
    if (user == null) return;

    try {
      final idToken = await user.getIdToken();
      final newTask = TodoTask(
        title: title,
        description: description,
        createdAt: DateTime.now(),
        userId: user.uid,
      );

      final addedTask = await _service.addTask(newTask, idToken ?? '');
      tasks.add(addedTask);
    } catch (e) {
      SnackbarUtils.showError('Failed to add task: $e');
    }
  }

  Future<void> updateTask(TodoTask task, String title, String description) async {
    final user = _authController.user;
    if (user == null) return;

    try {
      final idToken = await user.getIdToken();
      final updatedTask = task.copyWith(
        title: title,
        description: description,
      );
      
      await _service.updateTask(updatedTask, idToken ?? '');
      
      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
    } catch (e) {
      SnackbarUtils.showError('Failed to update task: $e');
    }
  }

  Future<void> toggleTaskStatus(TodoTask task) async {
    final user = _authController.user;
    if (user == null) return;

    try {
      final idToken = await user.getIdToken();
      final updatedTask = task.copyWith(isCompleted: !task.isCompleted);
      
      await _service.updateTask(updatedTask, idToken ?? '');

      final index = tasks.indexWhere((t) => t.id == task.id);
      if (index != -1) {
        tasks[index] = updatedTask;
      }
    } catch (e) {
      SnackbarUtils.showError('Failed to toggle status: $e');
    }
  }

  Future<void> deleteTask(String taskId) async {
    final user = _authController.user;
    if (user == null) return;

    try {
      final idToken = await user.getIdToken();
      await _service.deleteTask(user.uid, taskId, idToken ?? '');
      tasks.removeWhere((t) => t.id == taskId);
    } catch (e) {
      SnackbarUtils.showError('Failed to delete task: $e');
    }
  }
}
