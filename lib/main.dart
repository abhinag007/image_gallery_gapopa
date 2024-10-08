import 'package:flutter/material.dart';
import 'package:image_gallery/screens/image_gallery_screen.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized.
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Gallery',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageGalleryScreen(),
    );
  }
}