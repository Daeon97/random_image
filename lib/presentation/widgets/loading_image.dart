import 'package:flutter/material.dart';

class LoadingImage extends StatelessWidget {
  const LoadingImage({this.progress, super.key});

  final double? progress;

  @override
  Widget build(BuildContext context) => Stack(
    alignment: .center,
    children: [
      SizedBox(
        width: 100,
        height: 100,
        child: CircularProgressIndicator(value: progress),
      ),
      if (progress != null)
        Text(
          '${(progress! * 100).toStringAsFixed(0)}%',
          textAlign: .center,
          maxLines: 10,
          overflow: .ellipsis,
          style: TextStyle(fontSize: 20),
        ),
    ],
  );
}
