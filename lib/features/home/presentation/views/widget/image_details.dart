import 'package:flutter/material.dart';

class ImageDetails extends StatelessWidget {
  const ImageDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      height: screenHeight / 2.5,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(12)),
        child: Image.network(
          'https://images.pexels.com/photos/3683079/pexels-photo-3683079.jpeg',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
