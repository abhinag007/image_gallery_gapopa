import 'package:flutter/material.dart';

class ImageShow extends StatelessWidget {
  const ImageShow({super.key, this.image});

  final image;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Viewer'),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Center(child: Icon(Icons.arrow_back))),
      ),
      body: Center(
        child: Image.network(
          image.webformatURL,
          fit: BoxFit.contain,
          // Ensure the image maintains its aspect ratio
        ),
      ),
    );
  }
}
