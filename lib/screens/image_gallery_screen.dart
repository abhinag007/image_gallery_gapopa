import 'package:flutter/material.dart';
import '../models/image_model.dart';
import '../services/pixabay_service.dart';
import '../widgets/image_card.dart';

class ImageGalleryScreen extends StatefulWidget {
  const ImageGalleryScreen({Key? key}) : super(key: key);

  @override
  _ImageGalleryScreenState createState() => _ImageGalleryScreenState();
}

class _ImageGalleryScreenState extends State<ImageGalleryScreen> {
  List<ImageModel> _images = [];
  int _page = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Calculate how many images to load based on initial screen height
      _fetchImages(_calculateImagesToLoad());
    });
  }

  Future<void> _fetchImages(int imageCount) async {
    if (_isLoading || !_hasMore) return;
    setState(() {
      _isLoading = true;
    });

    try {
      List<ImageModel> fetchedImages = await PixabayService.fetchImages(_page, imageCount: imageCount);
      setState(() {
        _images.addAll(fetchedImages);
        _page++;
        if (fetchedImages.isEmpty) {
          _hasMore = false; // No more images to load
        }
      });
    } catch (error) {
      debugPrint('Error: $error');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _onScrollNotification(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent && !_isLoading) {
      _fetchImages(_calculateImagesToLoad());
    }
    return true;
  }

  int _calculateImagesToLoad() {
    final double screenHeight = MediaQuery.of(context).size.height;
    final int columns = (MediaQuery.of(context).size.width / 150).floor();
    final double rowHeight = 150; // Approximate height for an image with padding and info
    final int rows = (screenHeight / rowHeight).ceil();

    return rows * columns; // Calculate total images needed
  }

  @override
  Widget build(BuildContext context) {
    final int columns = (MediaQuery.of(context).size.width / 150).floor();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Gallery'),
      ),
      body: NotificationListener<ScrollNotification>(
        onNotification: _onScrollNotification,
        child: _images.isEmpty && !_isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: columns,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
          ),
          itemCount: _images.length + (_isLoading ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == _images.length) {
              return const Center(child: CircularProgressIndicator());
            }
            final image = _images[index];
            return ImageCard(image: image);
          },
        ),
      ),
    );
  }
}