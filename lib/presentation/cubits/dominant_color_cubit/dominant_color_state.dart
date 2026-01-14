part of 'dominant_color_cubit.dart';

@freezed
class DominantColorState with _$DominantColorState {
  const factory DominantColorState.initial() = _Initial;

  const factory DominantColorState.generatingColor() = _GeneratingColor;

  const factory DominantColorState.generatedColor({Color? dominantColor}) =
      _GeneratedColor;
}
