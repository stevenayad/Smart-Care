import 'package:flutter/material.dart';

class ImageUser extends StatelessWidget {
  const ImageUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: 63,
          height: 63,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: const LinearGradient(
              colors: [Color(0xFFAADBCB), Color(0xFFB7E7D7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            border: Border.all(color: Colors.white70, width: 2),
            boxShadow: [
              BoxShadow(blurRadius: 4, spreadRadius: 1, color: Colors.black12),
            ],
          ),
          child: CircleAvatar(
            radius: 20,
            backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/32.jpg',
            ),
          ),
        ),

        Positioned(
          bottom: 2,
          right: 2,
          child: Container(
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              color: Colors.green,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
