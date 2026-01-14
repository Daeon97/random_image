import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_image/data/models/image_model.dart';
import 'package:random_image/data/repositories/random_image_repository.dart';
import 'package:random_image/presentation/cubits/random_image_cubit/random_image_cubit.dart';

class MockRandomImageRepository extends Mock implements RandomImageRepository {}

void main() {
  late MockRandomImageRepository mockRandomImageRepository;
  late RandomImageCubit cubit;

  setUp(() {
    mockRandomImageRepository = MockRandomImageRepository();
    cubit = RandomImageCubit(mockRandomImageRepository);
  });

  tearDown(() {
    cubit.close();
  });

  group('RandomImageCubit', () {
    test('initial state is RandomImageState.initial()', () {
      expect(
        cubit.state,
        const RandomImageState.initial(),
      );
    });

    group('getRandomImage', () {
      const testImageUrl = 'https://example.com/image.jpg';
      const testImageModel = ImageModel(url: testImageUrl);

      test('emits [gettingImage, gotImage] when repository returns success', () async {
        // Arrange
        when(() => mockRandomImageRepository.getRandomImage())
            .thenAnswer((_) async => right(testImageModel));

        final states = <RandomImageState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.getRandomImage();

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 2);
        expect(states[0], const RandomImageState.gettingImage());
        expect(
          states[1],
          const RandomImageState.gotImage(image: testImageModel),
        );
      });

      test('emits [gettingImage, failedToGetImage] when repository returns failure', () async {
        // Arrange
        const errorMessage = 'Network error';
        when(() => mockRandomImageRepository.getRandomImage())
            .thenAnswer((_) async => left(const ImageFailure(errorMessage)));

        final states = <RandomImageState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.getRandomImage();

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 2);
        expect(states[0], const RandomImageState.gettingImage());
        expect(
          states[1],
          const RandomImageState.failedToGetImage(message: errorMessage),
        );
      });

      test('calls repository getRandomImage once', () async {
        // Arrange
        when(() => mockRandomImageRepository.getRandomImage())
            .thenAnswer((_) async => right(testImageModel));

        // Act
        await cubit.getRandomImage();

        // Assert
        verify(() => mockRandomImageRepository.getRandomImage()).called(1);
      });

      test('emits gettingImage before calling repository', () async {
        // Arrange
        RandomImageState? stateWhenRepositoryCalled;

        when(() => mockRandomImageRepository.getRandomImage()).thenAnswer((_) async {
          stateWhenRepositoryCalled = cubit.state;
          return right(testImageModel);
        });

        // Act
        await cubit.getRandomImage();

        // Assert
        expect(
          stateWhenRepositoryCalled,
          const RandomImageState.gettingImage(),
        );
      });

      test('final state is gotImage after successful completion', () async {
        // Arrange
        when(() => mockRandomImageRepository.getRandomImage())
            .thenAnswer((_) async => right(testImageModel));

        // Act
        await cubit.getRandomImage();

        // Assert
        expect(
          cubit.state,
          const RandomImageState.gotImage(image: testImageModel),
        );
      });

      test('final state is failedToGetImage after failure', () async {
        // Arrange
        const errorMessage = 'Server error';
        when(() => mockRandomImageRepository.getRandomImage())
            .thenAnswer((_) async => left(const ImageFailure(errorMessage)));

        // Act
        await cubit.getRandomImage();

        // Assert
        expect(
          cubit.state,
          const RandomImageState.failedToGetImage(message: errorMessage),
        );
      });

      test('handles multiple consecutive calls correctly', () async {
        // Arrange
        const firstImage = ImageModel(url: 'https://example.com/first.jpg');
        const secondImage = ImageModel(url: 'https://example.com/second.jpg');

        var callCount = 0;
        when(() => mockRandomImageRepository.getRandomImage()).thenAnswer((_) async {
          callCount++;
          return right(callCount == 1 ? firstImage : secondImage);
        });

        final states = <RandomImageState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.getRandomImage();
        await cubit.getRandomImage();

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 4);
        expect(states[0], const RandomImageState.gettingImage());
        expect(states[1], const RandomImageState.gotImage(image: firstImage));
        expect(states[2], const RandomImageState.gettingImage());
        expect(states[3], const RandomImageState.gotImage(image: secondImage));
      });

      test('can recover from failure on retry', () async {
        // Arrange
        var callCount = 0;
        when(() => mockRandomImageRepository.getRandomImage()).thenAnswer((_) async {
          callCount++;
          if (callCount == 1) {
            return left(const ImageFailure('First call failed'));
          }
          return right(testImageModel);
        });

        final states = <RandomImageState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.getRandomImage(); // First call - fails
        await cubit.getRandomImage(); // Second call - succeeds

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 4);
        expect(states[0], const RandomImageState.gettingImage());
        expect(
          states[1],
          const RandomImageState.failedToGetImage(message: 'First call failed'),
        );
        expect(states[2], const RandomImageState.gettingImage());
        expect(states[3], const RandomImageState.gotImage(image: testImageModel));
      });
    });
  });

  group('RandomImageState', () {
    test('initial state equality', () {
      expect(
        const RandomImageState.initial(),
        const RandomImageState.initial(),
      );
    });

    test('gettingImage state equality', () {
      expect(
        const RandomImageState.gettingImage(),
        const RandomImageState.gettingImage(),
      );
    });

    test('gotImage state equality with same image', () {
      const image = ImageModel(url: 'https://example.com/test.jpg');
      expect(
        const RandomImageState.gotImage(image: image),
        const RandomImageState.gotImage(image: image),
      );
    });

    test('gotImage state inequality with different images', () {
      expect(
        const RandomImageState.gotImage(
          image: ImageModel(url: 'https://example.com/a.jpg'),
        ),
        isNot(
          const RandomImageState.gotImage(
            image: ImageModel(url: 'https://example.com/b.jpg'),
          ),
        ),
      );
    });

    test('failedToGetImage state equality with same message', () {
      expect(
        const RandomImageState.failedToGetImage(message: 'Error'),
        const RandomImageState.failedToGetImage(message: 'Error'),
      );
    });

    test('failedToGetImage state inequality with different messages', () {
      expect(
        const RandomImageState.failedToGetImage(message: 'Error 1'),
        isNot(const RandomImageState.failedToGetImage(message: 'Error 2')),
      );
    });

    test('different states are not equal', () {
      expect(
        const RandomImageState.initial(),
        isNot(const RandomImageState.gettingImage()),
      );
      expect(
        const RandomImageState.gettingImage(),
        isNot(
          const RandomImageState.gotImage(
            image: ImageModel(url: 'https://example.com/test.jpg'),
          ),
        ),
      );
      expect(
        const RandomImageState.gotImage(
          image: ImageModel(url: 'https://example.com/test.jpg'),
        ),
        isNot(const RandomImageState.failedToGetImage(message: 'Error')),
      );
    });
  });
}

