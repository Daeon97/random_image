import 'dart:async';
import 'dart:isolate';
import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

final class ColorGeneratorRepository {
  Future<Color?> generateDominantColorFrom(
    BuildContext context, {
    required ImageProvider<Object> image,
  }) async {
    final imageProperties = await _computeImagePropertiesFrom(
      context,
      imageProvider: image,
    );

    if (imageProperties.bytes == null) return null;

    final color = await Isolate.run(() async {
      final paletteGenerator = await PaletteGenerator.fromByteData(
        EncodedImage(
          imageProperties.bytes!.buffer.asByteData(
            imageProperties.bytes!.offsetInBytes,
            imageProperties.bytes!.lengthInBytes,
          ),
          width: imageProperties.width,
          height: imageProperties.height,
        ),
      );

      final dominantColor = paletteGenerator.dominantColor?.color;

      if (dominantColor == null) return null;

      return (
        alpha: dominantColor.a,
        red: dominantColor.r,
        green: dominantColor.g,
        blue: dominantColor.b,
        colorSpace: dominantColor.colorSpace,
      );
    });

    if (color == null) return null;

    return Color.from(
      alpha: color.alpha,
      red: color.red,
      green: color.green,
      blue: color.blue,
      colorSpace: color.colorSpace,
    );
  }

  Future<({Uint8List? bytes, int width, int height})>
  _computeImagePropertiesFrom(
    BuildContext context, {
    required ImageProvider<Object> imageProvider,
  }) async {
    final imageStream = imageProvider.resolve(
      createLocalImageConfiguration(context),
    );

    final completer = Completer<({Uint8List? bytes, int width, int height})>();

    final imageStreamListener = ImageStreamListener((
      imageInfo,
      synchronousCall,
    ) async {
      final image = imageInfo.image;
      final byteData = await image.toByteData();
      final bytes = byteData?.buffer.asUint8List();

      if (!completer.isCompleted) {
        completer.complete((
          bytes: bytes,
          width: image.width,
          height: image.height,
        ));
      }
    });

    imageStream.addListener(imageStreamListener);
    final imageBytes = await completer.future;
    imageStream.removeListener(imageStreamListener);

    return imageBytes;
  }
}
