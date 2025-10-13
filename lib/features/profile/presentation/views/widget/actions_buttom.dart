import 'package:flutter/material.dart';

Widget buildActionButtons(List<String> actions, BuildContext context) {
  return Wrap(
    children: actions.map((action) {
      return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: buildActionButton(action, context),
      );
    }).toList(),
  );
}

Widget buildActionButton(String action, BuildContext context) {
  return ElevatedButton(
    onPressed: () {},
    //onPressed: () => _handleAction(action),
    style: Theme.of(context).elevatedButtonTheme.style,
    child: Text(
      action,
      style: TextStyle(
        color: getActionColor(action),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}

Color getActionColor(String action) {
  switch (action) {
    case 'Delete':
      return Colors.red;
    case 'Set as Default':
      return Colors.blue;
    case 'Edit':
      return Colors.green;
    default:
      return Colors.grey;
  }
}
