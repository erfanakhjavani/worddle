import 'package:flutter/material.dart';
import 'dart:math';

enum PopDirection { forwardX, backwardX }

//! Custom curve for motion effects
class FunctionCurve extends Curve {
  const FunctionCurve({required this.func});

  final double Function(double) func;

  @override
  double transform(double t) {
    return func(t); //* Apply the custom curve function
  }
}

//! Party Popper widget for animated confetti effects
class PartyPopperGenerator extends StatefulWidget {
  const PartyPopperGenerator({
    super.key,
    this.numbers = 100,
    required this.posX,
    required this.posY,
    required this.direction,
    required this.motionCurveX,
    required this.motionCurveY,
    required this.controller,
    this.pieceWidth = 15.0,
    this.pieceHeight = 5.0,
  })  : assert(numbers > 0 && numbers < 500), //* Ensure valid number of pieces
        assert(pieceWidth > 0), //* Ensure width is positive
        assert(pieceHeight > 0); //* Ensure height is positive

  //! Controls the popping parameters
  final double posX;
  final double posY;
  final PopDirection direction;
  final Curve motionCurveX;
  final Curve motionCurveY;
  final AnimationController controller;

  //! Controls the number of pieces
  final int numbers;
  final double pieceWidth;
  final double pieceHeight;

  @override
  State<PartyPopperGenerator> createState() => _PartyPopperGeneratorState();
}

class _PartyPopperGeneratorState extends State<PartyPopperGenerator> with SingleTickerProviderStateMixin {
  final randoms = <List<dynamic>>[]; //* Store random values for each confetti piece
  final colors = [
    Colors.orange[800],
    Colors.green[800],
    Colors.red[800],
    Colors.orange[900],
    Colors.yellow[800],
    Colors.green[400],
    Colors.blue[800],
    Colors.blue[700],
    Colors.teal[800],
    Colors.purple,
    Colors.brown,
    Colors.yellow,
    Colors.red[400],
    Colors.pink
  ]; //* Color options for confetti pieces

  @override
  void initState() {
    var rng = Random();
    for (int i = 0; i < widget.numbers; i++) {
      var randHorizontalStartShift = (rng.nextDouble() - 0.5) * 50;
      var randVerticalStartShift = (rng.nextDouble() - 0.5) * 150;
      var randHorizontalEndShift = (rng.nextDouble() - 0.5) * 900;
      var randVerticalEndShift = rng.nextDouble() * 1000;
      var randRotateCirclesX = rng.nextInt(7) + 1;
      var randRotateCirclesY = rng.nextInt(7) + 1;
      var randRotateCirclesZ = rng.nextInt(5) + 1;
      randoms.add([randHorizontalStartShift, randVerticalStartShift, randHorizontalEndShift, randVerticalEndShift, randRotateCirclesX, randRotateCirclesY, randRotateCirclesZ]);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        //! Generate confetti pieces and animations
        return Stack(
          children: [
            for (int i = 0; i < widget.numbers; i++)
              AnimatedBuilder(
                animation: widget.controller,
                builder: (context, child) {
                  //! Horizontal motion animation
                  var horizontalAnimation = Tween<double>(
                    begin: (widget.direction == PopDirection.forwardX ? widget.posX + randoms[i][0] : constraints.maxWidth - widget.posX - randoms[i][0]),
                    end: (widget.direction == PopDirection.forwardX ? constraints.maxWidth + randoms[i][2] : 0.0 - randoms[i][2]),
                  ).animate(
                    CurvedAnimation(
                      parent: widget.controller,
                      curve: widget.motionCurveX,
                    ),
                  );
                  //! Vertical motion animation
                  var verticalAnimation = Tween<double>(begin: widget.posY + randoms[i][1], end: constraints.maxHeight + randoms[i][3]).animate(
                    CurvedAnimation(
                      parent: widget.controller,
                      curve: widget.motionCurveY,
                    ),
                  );
                  //! Rotation animations along X, Y, Z axes
                  var rotationXAnimation = Tween<double>(begin: 0, end: pi * randoms[i][4]).animate(widget.controller);
                  var rotationYAnimation = Tween<double>(begin: 0, end: pi * randoms[i][5]).animate(widget.controller);
                  var rotationZAnimation = Tween<double>(begin: 0, end: pi * randoms[i][6]).animate(widget.controller);
                  //! Positioning and transforming each confetti piece
                  return Positioned(
                    left: horizontalAnimation.value,
                    width: widget.pieceWidth,
                    top: verticalAnimation.value,
                    height: widget.pieceHeight,
                    child: Transform(
                      transform: Matrix4.rotationX(rotationXAnimation.value)..rotateY(rotationYAnimation.value)..rotateZ(rotationZAnimation.value),
                      alignment: Alignment.center,
                      child: child,
                    ),
                  );
                },
                //! Define the appearance of each confetti piece
                child: Container(
                  width: widget.pieceWidth,
                  height: widget.pieceHeight,
                  color: colors[Random().nextInt(colors.length)]!.withAlpha(Random().nextInt(55) + 200), //* Random color and transparency
                ),
              ),
          ],
        );
      },
    );
  }
}
