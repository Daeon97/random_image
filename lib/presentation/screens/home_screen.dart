import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:random_image/presentation/cubits/random_image_cubit/random_image_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/repositories/color_generator_repository.dart';
import '../../data/repositories/random_image_repository.dart';
import '../cubits/dominant_color_cubit/dominant_color_cubit.dart';
import '../widgets/image_error.dart';
import '../widgets/loading_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => RandomImageRepository()),
      RepositoryProvider(create: (_) => ColorGeneratorRepository()),
    ],
    child: MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (bPCtx) =>
              RandomImageCubit(bPCtx.read<RandomImageRepository>()),
        ),
        BlocProvider(
          create: (bPCtx) =>
              DominantColorCubit(bPCtx.read<ColorGeneratorRepository>()),
        ),
      ],
      child: const HomeScreenView(),
    ),
  );
}

class HomeScreenView extends StatefulWidget {
  const HomeScreenView({super.key});

  @override
  State<HomeScreenView> createState() => _HomeScreenViewState();
}

class _HomeScreenViewState extends State<HomeScreenView> {
  @override
  void initState() {
    _getRandomImage();

    super.initState();
  }

  @override
  Widget build(
    BuildContext context,
  ) => BlocListener<RandomImageCubit, RandomImageState>(
    listener: (_, randomImageState) {
      randomImageState.whenOrNull(
        gotImage: (image) {
          final size = _computeDesiredImageSizeFrom(
            context,
            considerDevicePixelRatio: true,
          ).toInt();

          context.read<DominantColorCubit>().generateDominantColorUsing(
            context,
            image: CachedNetworkImageProvider(
              image.url,
              maxWidth: size,
              maxHeight: size,
            ),
          );
        },
      );
    },
    child: Scaffold(
      backgroundColor: context.watch<DominantColorCubit>().state.whenOrNull(
        generatedColor: (dominantColor) => dominantColor,
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: .min,
            mainAxisAlignment: .center,
            crossAxisAlignment: .center,
            children: [
              SizedBox(
                height: _computeDesiredImageSizeFrom(context),
                width: _computeDesiredImageSizeFrom(context),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(),
                  child: BlocBuilder<RandomImageCubit, RandomImageState>(
                    builder: (_, randomImageState) =>
                        randomImageState.maybeWhen(
                          gotImage: (image) => Center(
                            child: CachedNetworkImage(
                              width: _computeDesiredImageSizeFrom(context),
                              height: _computeDesiredImageSizeFrom(context),
                              fit: .cover,
                              imageUrl: image.url,
                              memCacheWidth: _computeDesiredImageSizeFrom(
                                context,
                                considerDevicePixelRatio: true,
                              ).toInt(),
                              memCacheHeight: _computeDesiredImageSizeFrom(
                                context,
                                considerDevicePixelRatio: true,
                              ).toInt(),
                              maxWidthDiskCache: _computeDesiredImageSizeFrom(
                                context,
                                considerDevicePixelRatio: true,
                              ).toInt(),
                              maxHeightDiskCache: _computeDesiredImageSizeFrom(
                                context,
                                considerDevicePixelRatio: true,
                              ).toInt(),
                              errorWidget: (_, _, error) =>
                                  ImageError(error: error),
                              progressIndicatorBuilder:
                                  (_, _, downloadProgress) => LoadingImage(
                                    progress: downloadProgress.progress,
                                  ),
                            ),
                          ),
                          failedToGetImage: (message) => ImageError(
                            error: 'Failed to get image. $message',
                          ),
                          orElse: () => const LoadingImage(),
                        ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _getRandomImage,
                child: const Text('Another'),
              ),
            ],
          ),
        ),
      ),
    ),
  );

  void _getRandomImage() => context.read<RandomImageCubit>().getRandomImage();

  double _computeDesiredImageSizeFrom(
    BuildContext context, {
    bool considerDevicePixelRatio = false,
  }) => switch (considerDevicePixelRatio) {
    true =>
      MediaQuery.sizeOf(context).width /
          1.2 *
          MediaQuery.devicePixelRatioOf(context),
    false => MediaQuery.sizeOf(context).width / 1.2,
  };
}
