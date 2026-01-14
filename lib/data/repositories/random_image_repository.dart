import 'dart:async';
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../models/image_model.dart';

final class ImageFailure {
  const ImageFailure(this.message);

  final String message;
}

final class RandomImageRepository {
  Future<Either<ImageFailure, ImageModel>> getRandomImage() async {
    final client = http.Client();

    try {
      final url = Uri.parse(
        'https://november7-730026606190.europe-west1.run.app/image',
      );

      final response = await client.get(url).timeout(Duration(seconds: 20));

      final responseBody = response.body;
      final decodedResponseBody = json.decode(responseBody);

      final imageModel = ImageModel.fromJson(decodedResponseBody);

      return right(imageModel);
    } catch (e, s) {
      final errorMessage = e.toString();
      final stackTrace = s.toString();

      return left(ImageFailure('$errorMessage\n$stackTrace'));
    } finally {
      client.close();
    }
  }
}
