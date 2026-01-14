import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:random_image/data/repositories/color_generator_repository.dart';
import 'package:random_image/presentation/cubits/dominant_color_cubit/dominant_color_cubit.dart';

class MockColorGeneratorRepository extends Mock
    implements ColorGeneratorRepository {}

class FakeImageProvider extends Fake implements ImageProvider<Object> {}

class FakeBuildContext extends Fake implements BuildContext {}

void main() {
  late MockColorGeneratorRepository mockColorGeneratorRepository;
  late DominantColorCubit cubit;
  late FakeBuildContext fakeBuildContext;
  late FakeImageProvider fakeImageProvider;

  setUp(() {
    mockColorGeneratorRepository = MockColorGeneratorRepository();
    cubit = DominantColorCubit(mockColorGeneratorRepository);
    fakeBuildContext = FakeBuildContext();
    fakeImageProvider = FakeImageProvider();
  });

  setUpAll(() {
    registerFallbackValue(FakeBuildContext());
    registerFallbackValue(FakeImageProvider());
  });

  tearDown(() {
    cubit.close();
  });

  group('DominantColorCubit', () {
    test('initial state is DominantColorState.initial()', () {
      expect(
        cubit.state,
        const DominantColorState.initial(),
      );
    });

    group('generateDominantColorUsing', () {
      test('emits [generatingColor, generatedColor] when color is generated successfully', () async {
        // Arrange
        const expectedColor = Color(0xFF123456);
        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async => expectedColor);

        final states = <DominantColorState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        await Future.delayed(Duration.zero); // Allow stream to emit
        await subscription.cancel();

        expect(states.length, 2);
        expect(states[0], const DominantColorState.generatingColor());
        expect(
          states[1],
          const DominantColorState.generatedColor(dominantColor: expectedColor),
        );
      });

      test('emits [generatingColor, generatedColor] with null when no dominant color found', () async {
        // Arrange
        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async => null);

        final states = <DominantColorState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 2);
        expect(states[0], const DominantColorState.generatingColor());
        expect(
          states[1],
          const DominantColorState.generatedColor(dominantColor: null),
        );
      });

      test('calls repository with correct parameters', () async {
        // Arrange
        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async => null);

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        verify(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            fakeBuildContext,
            image: fakeImageProvider,
          ),
        ).called(1);
      });

      test('emits generatingColor before calling repository', () async {
        // Arrange
        DominantColorState? stateWhenRepositoryCalled;

        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async {
          stateWhenRepositoryCalled = cubit.state;
          return const Color(0xFF000000);
        });

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        expect(
          stateWhenRepositoryCalled,
          const DominantColorState.generatingColor(),
        );
      });

      test('final state is generatedColor after completion', () async {
        // Arrange
        const expectedColor = Color(0xFFABCDEF);
        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async => expectedColor);

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        expect(
          cubit.state,
          const DominantColorState.generatedColor(dominantColor: expectedColor),
        );
      });

      test('handles multiple consecutive calls correctly', () async {
        // Arrange
        const firstColor = Color(0xFF111111);
        const secondColor = Color(0xFF222222);

        var callCount = 0;
        when(
          () => mockColorGeneratorRepository.generateDominantColorFrom(
            any(),
            image: any(named: 'image'),
          ),
        ).thenAnswer((_) async {
          callCount++;
          return callCount == 1 ? firstColor : secondColor;
        });

        final states = <DominantColorState>[];
        final subscription = cubit.stream.listen(states.add);

        // Act
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );
        await cubit.generateDominantColorUsing(
          fakeBuildContext,
          image: fakeImageProvider,
        );

        // Assert
        await Future.delayed(Duration.zero);
        await subscription.cancel();

        expect(states.length, 4);
        expect(states[0], const DominantColorState.generatingColor());
        expect(
          states[1],
          const DominantColorState.generatedColor(dominantColor: firstColor),
        );
        expect(states[2], const DominantColorState.generatingColor());
        expect(
          states[3],
          const DominantColorState.generatedColor(dominantColor: secondColor),
        );
      });
    });
  });

  group('DominantColorState', () {
    test('initial state equality', () {
      expect(
        const DominantColorState.initial(),
        const DominantColorState.initial(),
      );
    });

    test('generatingColor state equality', () {
      expect(
        const DominantColorState.generatingColor(),
        const DominantColorState.generatingColor(),
      );
    });

    test('generatedColor state equality with same color', () {
      const color = Color(0xFF123456);
      expect(
        const DominantColorState.generatedColor(dominantColor: color),
        const DominantColorState.generatedColor(dominantColor: color),
      );
    });

    test('generatedColor state inequality with different colors', () {
      expect(
        const DominantColorState.generatedColor(dominantColor: Color(0xFF123456)),
        isNot(const DominantColorState.generatedColor(dominantColor: Color(0xFF654321))),
      );
    });

    test('generatedColor state with null dominantColor', () {
      expect(
        const DominantColorState.generatedColor(dominantColor: null),
        const DominantColorState.generatedColor(),
      );
    });

    test('different states are not equal', () {
      expect(
        const DominantColorState.initial(),
        isNot(const DominantColorState.generatingColor()),
      );
      expect(
        const DominantColorState.generatingColor(),
        isNot(const DominantColorState.generatedColor()),
      );
    });
  });
}

