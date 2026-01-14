import 'package:flutter/material.dart';

class ImageError extends StatelessWidget {
  const ImageError({required this.error, super.key});

  final dynamic error;

  @override
  Widget build(BuildContext context) => Semantics(
    label: 'Error loading image',
    hint: error.toString(),
    child: ExcludeSemantics(
      child: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        children: [
          const Icon(
            Icons.error,
            size: 50,
            color: Colors.redAccent,
            semanticLabel: 'Error icon',
          ),
          const SizedBox(height: 10),
          Text(
            error.toString(),
            textAlign: .center,
            maxLines: 10,
            overflow: .ellipsis,
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    ),
  );
}
