
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatelessWidget {
  final XFile? image;
  final VoidCallback onPickImage;

  const ProfileImagePicker({
    super.key,
    required this.image,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: onPickImage,
        child: CircleAvatar(
          radius: 40,
          backgroundColor: Colors.grey.shade200,
         backgroundImage: image != null
              ? (kIsWeb
                  ? NetworkImage(image!.path) // On web, path is a URL
                  : FileImage(File(image!.path))) as ImageProvider // On mobile, path is a file path
              : null,
          child: image == null
              ? Icon(
                  Icons.camera_alt,
                  size: 40,
                  color: Colors.grey.shade600,
                )
              : null,
        ),
      ),
    );
  }
}