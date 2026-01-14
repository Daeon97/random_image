import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/repositories/color_generator_repository.dart';

part 'dominant_color_state.dart';

part 'dominant_color_cubit.freezed.dart';

class DominantColorCubit extends Cubit<DominantColorState> {
  DominantColorCubit(ColorGeneratorRepository colorGeneratorRepository)
    : _colorGeneratorRepository = colorGeneratorRepository,
      super(const DominantColorState.initial());

  final ColorGeneratorRepository _colorGeneratorRepository;

  Future<void> generateDominantColorUsing(
    BuildContext context, {
    required ImageProvider<Object> image,
  }) async {
    emit(const DominantColorState.generatingColor());

    final dominantColor = await _colorGeneratorRepository
        .generateDominantColorFrom(context, image: image);

    emit(DominantColorState.generatedColor(dominantColor: dominantColor));
  }
}
