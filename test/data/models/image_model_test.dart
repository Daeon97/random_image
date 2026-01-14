import 'package:flutter_test/flutter_test.dart';
import 'package:random_image/data/models/image_model.dart';

void main() {
  group('ImageModel', () {
    const testUrl = 'https://example.com/image.jpg';

    test('creates instance with required url', () {
      const imageModel = ImageModel(url: testUrl);

      expect(imageModel.url, testUrl);
    });

    group('fromJson', () {
      test('parses valid JSON correctly', () {
        final json = {'url': testUrl};

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.url, testUrl);
      });

      test('throws when url is missing', () {
        final json = <String, dynamic>{};

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when url is null', () {
        final json = {'url': null};

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when url is not a String', () {
        final json = {'url': 123};

        expect(
          () => ImageModel.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('handles extra fields in JSON', () {
        final json = {
          'url': testUrl,
          'extra': 'field',
          'another': 123,
        };

        final imageModel = ImageModel.fromJson(json);

        expect(imageModel.url, testUrl);
      });
    });
  });
}

