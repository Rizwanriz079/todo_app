import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxWidth;

  const ResponsiveLayout({
    super.key, 
    required this.child, 
    this.maxWidth = 600.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxWidth) {
          return Container(
            color: const Color(0xFFF1F5F9), // Light blue-grey background for web
            child: Center(
              child: Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 20,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: child,
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
