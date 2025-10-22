import 'package:flutter/material.dart';

class Rowbutton extends StatelessWidget {
  final bool isDark;
  final int currentIndex;
  final int itemsLength;
  final PageController pageController;
  final VoidCallback? onGetStarted;

  const Rowbutton({
    super.key,
    required this.isDark,
    required this.currentIndex,
    required this.itemsLength,
    required this.pageController,
    this.onGetStarted,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
            onPressed: onGetStarted,
            child: Text(
              'Skip',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black54,
                letterSpacing: 0.5,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (currentIndex < itemsLength - 1) {
                pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeIn,
                );
              } else {
                if (onGetStarted != null) {
                  onGetStarted!();
                }
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              padding:
                  const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              currentIndex < itemsLength - 1 ? 'Next' : 'Get Started',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.8,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
