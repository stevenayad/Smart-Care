import 'package:flutter/material.dart';
import 'package:smartcare/features/products/presentation/view/widgets/custom/custom_badge_icon.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final IconData? actionIcon;
  final String? actionAsset;
  final int? badgeCount;
  final VoidCallback? onAction;
  final Color? bgColor;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.onBack,
    this.actionIcon,
    this.actionAsset,
    this.badgeCount,
    this.onAction,
    this.bgColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget? actionWidget;
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;

    if (badgeCount != null && badgeCount! > 0 && actionIcon != null) {
      actionWidget = CustomBadgeIcon(
        icon: actionIcon!,
        count: badgeCount!,
        onTap: onAction,
      );
    } else if (actionIcon != null) {
      actionWidget = IconButton(
        icon: Icon(actionIcon),
        onPressed: onAction ?? () {},
      );
    } else if (actionAsset != null) {
      actionWidget = IconButton(
        icon: ImageIcon(AssetImage(actionAsset!)),
        onPressed: onAction ?? () {},
      );
    }

    return AppBar(
      backgroundColor: bgColor ?? colorScheme.primary,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: textTheme.headlineLarge),
          if (actionWidget != null)
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: actionWidget,
            ),
        ],
      ),
      leading: IconButton(
        onPressed: onBack ?? () => Navigator.of(context).pop(),
        icon: const Icon(Icons.arrow_back),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
