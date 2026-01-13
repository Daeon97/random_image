part of 'random_image_cubit.dart';

@freezed
class RandomImageState with _$RandomImageState {
  const factory RandomImageState.initial() = _Initial;

  const factory RandomImageState.gettingImage() = _GettingImage;

  const factory RandomImageState.gotImage({required ImageModel image}) =
      _GotImage;

  const factory RandomImageState.failedToGetImage({required String message}) =
      _FailedToGetImage;
}
