import 'package:flutter/material.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/container/circle_cutsom_shape.dart';
import 'package:solution_challenge_app/common/widgets/custom_shapes/curved_edges/curved_edges-widget.dart';
import 'package:solution_challenge_app/utils/helpers/helper_function.dart';

class PrimaryHeaderContainer extends StatelessWidget {
  const PrimaryHeaderContainer({
    super.key,
    required this.circleBgColor,
    required this.child,
  });

  final Color circleBgColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgeWidget(
      circleBgColor: circleBgColor,
      child: Container(
        width: HelperFunctions.screenWidth(),
        height: 450,
        color: const Color(0xFF1E90FF),
        child: Stack(
          children: [
            Positioned(
              top: -140,
              right: -270,
              child: CircularShape(shapeColor: circleBgColor.withOpacity(0.2)),
            ),
            Positioned(
              top: 160,
              right: -170,
              child: CircularShape(shapeColor: circleBgColor.withOpacity(0.2)),
            ),
            child,
          ],
        ),
      ),
    );
  }
}
