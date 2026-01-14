import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:random_image/data/repositories/random_image_repository.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late MockHttpClient mockClient;
  late RandomImageRepositoryImpl repository;

  setUp(() {
    mockClient = MockHttpClient();
    repository = RandomImageRepositoryImpl(mockClient);
  });

  setUpAll(() {
    registerFallbackValue(Uri.parse('https://example.com'));
  });

  group('RandomImageRepository', () {
    const testUrl = 'https://example.com/test-image.jpg';
    final successResponseBody = json.encode({'url': testUrl});

    group('getRandomImage', () {
      test('returns ImageModel on successful response', () async {
        // Arrange
        when(
          () => mockClient.get(any()),
        ).thenAnswer((_) async => http.Response(successResponseBody, 200));

        // Act
        final result = await repository.getRandomImage();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (failure) => fail('Expected Right but got Left: ${failure.message}'),
          (imageModel) {
            expect(imageModel.url, testUrl);
          },
        );
        verify(() => mockClient.get(any())).called(1);
      });

      test('returns ImageFailure on invalid JSON response', () async {
        // Arrange
        when(
          () => mockClient.get(any()),
        ).thenAnswer((_) async => http.Response('invalid json', 200));

        // Act
        final result = await repository.getRandomImage();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.message, contains('FormatException'));
        }, (_) => fail('Expected Left but got Right'));
      });

      test('returns ImageFailure on missing url field in JSON', () async {
        // Arrange
        when(() => mockClient.get(any())).thenAnswer(
          (_) async => http.Response(json.encode({'other': 'data'}), 200),
        );

        // Act
        final result = await repository.getRandomImage();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.message, contains('type'));
        }, (_) => fail('Expected Left but got Right'));
      });

      test('returns ImageFailure on network error', () async {
        // Arrange
        when(
          () => mockClient.get(any()),
        ).thenThrow(http.ClientException('Network error'));

        // Act
        final result = await repository.getRandomImage();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.message, contains('Network error'));
        }, (_) => fail('Expected Left but got Right'));
      });

      test(
        'returns ImageFailure on timeout',
        () async {
          // Arrange
          when(() => mockClient.get(any())).thenAnswer((_) async {
            await Future.delayed(const Duration(seconds: 25));
            return http.Response(successResponseBody, 200);
          });

          // Act
          final result = await repository.getRandomImage();

          // Assert
          expect(result.isLeft(), true);
          result.fold((failure) {
            expect(failure.message, contains('TimeoutException'));
          }, (_) => fail('Expected Left but got Right'));
        },
        timeout: const Timeout(Duration(seconds: 30)),
      );

      test('returns ImageFailure on SocketException', () async {
        // Arrange
        when(
          () => mockClient.get(any()),
        ).thenThrow(Exception('SocketException: Connection refused'));

        // Act
        final result = await repository.getRandomImage();

        // Assert
        expect(result.isLeft(), true);
        result.fold((failure) {
          expect(failure.message, contains('SocketException'));
        }, (_) => fail('Expected Left but got Right'));
      });

      test('calls correct URL', () async {
        // Arrange
        when(
          () => mockClient.get(any()),
        ).thenAnswer((_) async => http.Response(successResponseBody, 200));

        // Act
        await repository.getRandomImage();

        // Assert
        verify(
          () => mockClient.get(
            Uri.parse(
              'https://november7-730026606190.europe-west1.run.app/image',
            ),
          ),
        ).called(1);
      });
    });
  });

  group('ImageFailure', () {
    test('stores message correctly', () {
      const message = 'Test error message';
      const failure = ImageFailure(message);

      expect(failure.message, message);
    });
  });
}
