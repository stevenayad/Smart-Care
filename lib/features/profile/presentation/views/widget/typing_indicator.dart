import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:smartcare/core/app_color.dart';
import 'package:smartcare/features/profile/presentation/views/widget/typing_dot.dart';

class TypingIndicator extends StatelessWidget {
  const TypingIndicator();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CircleAvatar(
            radius: 16,
            backgroundColor: AppColors.primaryblue,
            child: Icon(
              Icons.smart_toy_outlined,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.lightGrey,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
              ),
            ),
            child: const Row(
              children: [
                TypingDot(delay: 0),
                TypingDot(delay: 200),
                TypingDot(delay: 400),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
