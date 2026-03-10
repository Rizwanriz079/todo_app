import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:hre/features/todo/data/models/task_model.dart';
import 'package:hre/features/todo/presentation/controllers/task_controller.dart';
import 'package:hre/features/todo/presentation/screens/todo_dashboard.dart';

class TaskItem extends StatelessWidget {
  final TodoTask task;

  const TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<TaskController>();
    
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Container(
                width: 6,
                color: task.isCompleted ? const Color(0xFF10B981) : Colors.indigo.shade400,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => controller.toggleTaskStatus(task),
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: task.isCompleted 
                                ? const Color(0xFF10B981).withOpacity(0.1) 
                                : const Color(0xFF64748B).withOpacity(0.05),
                            border: Border.all(
                              color: task.isCompleted 
                                  ? const Color(0xFF10B981) 
                                  : const Color(0xFFE2E8F0),
                              width: 2,
                            ),
                          ),
                          child: Icon(
                            task.isCompleted ? Icons.check_rounded : null,
                            size: 16,
                            color: const Color(0xFF059669),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title,
                              style: GoogleFonts.outfit(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                color: task.isCompleted ? const Color(0xFF94A3B8) : const Color(0xFF1E293B),
                              ),
                            ),
                            if (task.description != null && task.description!.isNotEmpty) ...[
                              const SizedBox(height: 4),
                              Text(
                                task.description!,
                                style: GoogleFonts.outfit(
                                  fontSize: 14,
                                  color: const Color(0xFF64748B),
                                  decoration: task.isCompleted ? TextDecoration.lineThrough : null,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today_rounded, size: 12, color: const Color(0xFF94A3B8)),
                                const SizedBox(width: 4),
                                Text(
                                  DateFormat('MMM d, yyyy').format(task.createdAt),
                                  style: GoogleFonts.outfit(
                                    fontSize: 12,
                                    color: const Color(0xFF94A3B8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_note_rounded, color: Colors.indigo),
                            onPressed: () => TodoDashboard.showEditTaskDialog(context, task),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                          const SizedBox(width: 12),
                          IconButton(
                            icon: const Icon(Icons.delete_outline_rounded, color: Color(0xFFF43F5E)),
                            onPressed: () => controller.deleteTask(task.id!),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
