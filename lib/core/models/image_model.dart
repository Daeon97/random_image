final class ImageModel {
  const ImageModel({required this.url});

  final String url;

  factory ImageModel.fromJson(Map<String, dynamic> json) =>
      ImageModel(url: json['url'] as String);
}
