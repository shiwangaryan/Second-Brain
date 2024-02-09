import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/curved_edges/curved_edges_clipper.dart';

class CurvedEdgeWidget extends StatelessWidget {
  const CurvedEdgeWidget({
    super.key,
    required this.circleBgColor,
    this.child,
  });

  final Color circleBgColor;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: RoundedBorderShapeClipper(),
      child: child,
    );
  }
}
