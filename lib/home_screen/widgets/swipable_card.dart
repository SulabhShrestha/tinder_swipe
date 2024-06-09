import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_card/models/card_model.dart';

class SwipableCard extends StatefulWidget {
  final CardModel cardModel;
  final ValueChanged<int> onSwipe;
  final int index;

  /// Index of the card at the top of the stack
  /// For blurring the rest of the cards

  final int topIndex;

  const SwipableCard({
    super.key,
    required this.cardModel,
    required this.onSwipe,
    required this.index,
    required this.topIndex,
  });

  @override
  State<SwipableCard> createState() => _SwipableCardState();
}

class _SwipableCardState extends State<SwipableCard> {
  double _positionX = 0.0; // Position of the card
  double _startX = 0.0; // Initial position when swipe starts
  double minSwipeDistance = 100.0; // Minimum swipe distance to consider a swipe
  double rotationFactor = 0.0; // Rotation factor of the card

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragStart: (details) {
        _startX = MediaQuery.of(context).size.width / 2;

        log("Startx : $_startX");
      },
      onHorizontalDragUpdate: (details) {
        double distance = details.globalPosition.dx - _startX;

        distance = distance > 0
            ? -distance
            : distance; // for same rotation on both sides

        setState(() {
          _positionX +=
              details.delta.dx; // Update the card position during drag

          rotationFactor =
              distance / 500; // Rotate the card no matter the swipe distance

          log("Distance : $distance, $rotationFactor");
        });
      },
      onHorizontalDragEnd: (details) {
        double endX =
            details.globalPosition.dx; // Capture the end touch position

        log("EndX : $endX");
        double distance = endX - _startX; // Calculate the swipe distance

        // Check if the swipe distance and velocity are sufficient to be classified as a swipe
        if (distance.abs() > minSwipeDistance) {
          if (distance > 0) {
            print("Swiped right! Distance: $distance");
            widget.onSwipe(widget.index);
          } else {
            print("Swiped left! Distance: $distance");

            widget.onSwipe(widget.index);
          }
        } else {
          print("Swipe not detected or insufficient.");
          setState(() {
            _positionX = 0; // Reset the card position
            rotationFactor = 0; // Reset the card rotation
          });
        }
      },
      child: Transform(
        transform: Matrix4.translationValues(_positionX, 0, 0)
          ..setRotationZ(rotationFactor),
        child: Card(
          color: widget.topIndex == widget.index ? Colors.white : Colors.blue,
          child: SizedBox(
            width: 200,
            height: 300,
            child: Center(
              child: Text(widget.cardModel.title),
            ),
          ),
        ),
      ),
    );
  }
}
