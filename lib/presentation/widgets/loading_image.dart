import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({this.progress, super.key});

  final double? progress;

  @override
  Widget build(BuildContext context) {
    final progressPercentage = switch (progress) {
      != null => '${(progress! * 100).toStringAsFixed(0)}%',
      _ => null,
    };

    final semanticLabel = switch (progress) {
      != null => 'Loading image, $progressPercentage complete',
      _ => 'Loading image',
    };

    return Semantics(
      label: semanticLabel,
      value: progressPercentage,
      child: ExcludeSemantics(
        child: Stack(
          alignment: .center,
          children: [
            SizedBox(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(value: progress),
            ),
            if (progress != null)
              Text(
                progressPercentage!,
                textAlign: .center,
                maxLines: 10,
                overflow: .ellipsis,
                style: TextStyle(fontSize: 20),
              ),
          ],
        ),
      ),
    );
  }
}
