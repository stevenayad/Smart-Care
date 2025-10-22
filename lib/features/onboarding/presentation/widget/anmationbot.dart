import 'package:flutter/material.dart';

class AnimationDots extends StatelessWidget {
  final int currentIndex;
  final int itemsLength;
  final bool isDark;

  const AnimationDots({
    super.key,
    required this.currentIndex,
    required this.itemsLength,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemsLength, (index) {
        return AnimatedContainer(
          duration: const Duration(milliseconds:700),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 8,
          width: currentIndex == index ? 24 : 8,
          decoration: BoxDecoration(
            color: currentIndex == index
                ? Theme.of(context).primaryColor
                : (isDark ? Colors.grey[700] : Colors.grey[300]),
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}
