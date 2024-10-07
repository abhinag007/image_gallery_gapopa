/// Represents an image fetched from the Pixabay API.
class ImageModel {
  final String webformatURL;
  final int likes;
  final int views;

  ImageModel({required this.webformatURL, required this.likes, required this.views});

  /// Creates an `ImageModel` from a JSON object.
  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      webformatURL: json['webformatURL'],
      likes: json['likes'],
      views: json['views'],
    );
  }
}