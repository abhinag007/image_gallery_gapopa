import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/image_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PixabayService {
  static String get _apiKey => dotenv.env['PIXABAY_API_KEY'] ?? '';

  /// Fetch images from the Pixabay API with a specified number of images.
  static Future<List<ImageModel>> fetchImages(int page, {int imageCount = 20}) async {
    final String url = 'https://pixabay.com/api/?key=$_apiKey&image_type=photo&per_page=$imageCount&page=$page';
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return (data['hits'] as List).map((json) => ImageModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load images');
    }
  }
}