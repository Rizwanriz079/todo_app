import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtils {
  static void showError(String message) {
    // Clean Firebase error if present
    String displayMessage = message;
    if (message.contains(']')) {
      displayMessage = message.split(']').last.trim();
    }

    Get.rawSnackbar(
      messageText: Text(
        displayMessage,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: const Color(0xFFF43F5E), // Professional rose/red
      snackPosition: SnackPosition.BOTTOM,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      duration: const Duration(seconds: 3),
      icon: const Icon(Icons.error_outline_rounded, color: Colors.white),
    );
  }
}
