import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hre/core/services/auth_service.dart';
import 'package:hre/features/auth/presentation/controllers/auth_controller.dart';
import 'package:hre/features/todo/presentation/controllers/task_controller.dart';
import 'package:hre/core/auth_wrapper.dart';
import 'package:hre/core/theme.dart';
import 'firebase_options.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase Initialization Error: $e');
  }

  Get.put(AuthService());
  Get.put(AuthController());
  Get.lazyPut(() => TaskController()); 

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HRE Todo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: const AuthWrapper(),
    );
  }
}
