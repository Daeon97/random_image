import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({required this.error, super.key});

  final dynamic error;

  @override
  Widget build(BuildContext context) => Column(
    mainAxisAlignment: .center,
    crossAxisAlignment: .center,
    children: [
      const Icon(Icons.error, size: 50, color: Colors.redAccent),
      const SizedBox(height: 10),
      Text(
        error.toString(),
        textAlign: .center,
        maxLines: 10,
        overflow: .ellipsis,
        style: TextStyle(fontSize: 16),
      ),
    ],
  );
}
