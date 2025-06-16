// lib/modules/feed/views/fullscreen_image_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';

class FullscreenImageScreen extends StatelessWidget {
  final String imagePath;

  const FullscreenImageScreen({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final isNetwork = Uri.parse(imagePath).isAbsolute;

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Center(
        child: Hero(
          tag: imagePath,
          child: InteractiveViewer(
            child: isNetwork
                ? Image.network(imagePath)
                : Image.file(File(imagePath)),
          ),
        ),
      ),
    );
  }
}
