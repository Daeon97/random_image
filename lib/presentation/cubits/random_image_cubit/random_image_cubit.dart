import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/image_model.dart';
import '../../../data/repositories/random_image_repository.dart';

part 'random_image_state.dart';

part 'random_image_cubit.freezed.dart';

class RandomImageCubit extends Cubit<RandomImageState> {
  RandomImageCubit(RandomImageRepository randomImageRepository)
    : _randomImageRepository = randomImageRepository,
      super(const RandomImageState.initial());

  final RandomImageRepository _randomImageRepository;

  Future<void> getRandomImage() async {
    emit(const RandomImageState.gettingImage());

    final randomImageRequestResult = await _randomImageRepository
        .getRandomImage();

    randomImageRequestResult.fold(
      (imageFailure) => emit(
        RandomImageState.failedToGetImage(message: imageFailure.message),
      ),
      (image) => emit(RandomImageState.gotImage(image: image)),
    );
  }
}
