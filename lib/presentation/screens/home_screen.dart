import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:random_image/presentation/cubits/random_image_cubit/random_image_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../data/data_sources/remote_data_source.dart';
import '../widgets/image_error.dart';
import '../widgets/loading_image.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => RepositoryProvider(
    create: (_) => RemoteDataSource(),
    child: BlocProvider(
      create: (bPCtx) => RandomImageCubit(bPCtx.read<RemoteDataSource>()),
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
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: Column(
          mainAxisSize: .min,
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).width / 1.2,
              width: MediaQuery.sizeOf(context).width / 1.2,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(),
                child: BlocBuilder<RandomImageCubit, RandomImageState>(
                  builder: (_, randomImageState) => randomImageState.maybeWhen(
                    gotImage: (image) => Center(
                      child: CachedNetworkImage(
                        height: MediaQuery.sizeOf(context).width / 1.2,
                        width: MediaQuery.sizeOf(context).width / 1.2,
                        fit: .cover,
                        imageUrl: image.url,
                        errorWidget: (_, _, error) => ImageError(error: error),
                        progressIndicatorBuilder: (_, _, downloadProgress) =>
                            LoadingImage(progress: downloadProgress.progress),
                      ),
                    ),
                    failedToGetImage: (message) =>
                        ImageError(error: 'Failed to get image. $message'),
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
  );

  void _getRandomImage() => context.read<RandomImageCubit>().getRandomImage();
}
