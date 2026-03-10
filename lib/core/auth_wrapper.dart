import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hre/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hre/features/auth/presentation/screens/login_screen.dart';
import 'package:hre/features/todo/presentation/screens/todo_dashboard.dart';

class AuthWrapper extends GetView<AuthController> {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.user != null) {
        return const TodoDashboard();
      }
      return const LoginScreen();
    });
  }
}
