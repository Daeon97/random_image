import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/data_sources/remote_data_source.dart';
import '../../../data/models/image_model.dart';

part 'random_image_state.dart';

part 'random_image_cubit.freezed.dart';

class RandomImageCubit extends Cubit<RandomImageState> {
  RandomImageCubit(RemoteDataSource remoteDataSource)
    : _remoteDataSource = remoteDataSource,
      super(const RandomImageState.initial());

  final RemoteDataSource _remoteDataSource;

  Future<void> getRandomImage() async {
    emit(const RandomImageState.gettingImage());

    final randomImageRequestResult = await _remoteDataSource.getRandomImage();

    randomImageRequestResult.fold(
      (imageFailure) => emit(
        RandomImageState.failedToGetImage(message: imageFailure.message),
      ),
      (image) => emit(RandomImageState.gotImage(image: image)),
    );
  }
}
