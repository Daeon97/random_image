import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:random_image/presentation/cubits/random_image_cubit/random_image_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../core/data_sources/remote_data_source.dart';

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

  void _getRandomImage() => context.read<RandomImageCubit>().getRandomImage();

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Column(
        mainAxisAlignment: .center,
        children: [
          BlocBuilder<RandomImageCubit, RandomImageState>(
            builder: (_, randomImageState) => randomImageState.maybeWhen(
              gotImage: (image) => Center(
                child: CachedNetworkImage(
                  imageUrl: image.url,
                  placeholder: (_, _) => const CircularProgressIndicator(),
                  errorWidget: (_, _, _) => const Icon(Icons.error),
                ),
              ),
              failedToGetImage: (message) => Text(
                'Failed to get image. $message',
                textAlign: .center,
                maxLines: 10,
                overflow: .ellipsis,
              ),
              orElse: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _getRandomImage,
            child: const Text('Get Random Image'),
          ),
        ],
      ),
    ),
  );
}
