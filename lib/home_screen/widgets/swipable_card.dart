import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:swipe_card/home_screen/widgets/like_dislike_icon.dart';
import 'package:swipe_card/models/card_model.dart';
import 'dart:ui' as ui;

import 'package:swipe_card/utils/swipe_direction_enum.dart';

class SwipableCard extends StatefulWidget {
  final CardModel cardModel;
  final ValueChanged<int> onSwipe;
  final int index;
  final double width;
  final double height;

  /// Index of the card at the top of the stack
  /// For blurring the rest of the cards

  final int topIndex;

  const SwipableCard({
    super.key,
    required this.cardModel,
    required this.onSwipe,
    required this.index,
    required this.topIndex,
    required this.height,
    required this.width,
  });

  @override
  State<SwipableCard> createState() => _SwipableCardState();
}

class _SwipableCardState extends State<SwipableCard> {
  double _positionX = 0.0; // Position of the card
  double _startX = 0.0; // Initial position when swipe starts
  double minSwipeDistance = 100.0; // Minimum swipe distance to consider a swipe
  double rotationFactor = 0.0; // Rotation factor of the card
  SwipeDirection swipeDirection = SwipeDirection.none;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // actual content
        GestureDetector(
          onHorizontalDragStart: (details) {
            _startX = MediaQuery.of(context).size.width / 2;

            log("Startx : $_startX");
          },
          onHorizontalDragUpdate: (details) {
            double distance = details.globalPosition.dx - _startX;

            log("Distance : $distance, $rotationFactor, swipe direction: $swipeDirection");

            // like and dislike
            if (distance.abs() > minSwipeDistance) {
              // right
              if (distance > 0) {
                swipeDirection = SwipeDirection.right;
              }
              // left
              else {
                swipeDirection = SwipeDirection.left;
              }
            }
            // resetting
            else {
              swipeDirection = SwipeDirection.none;
            }

            distance = distance > 0
                ? -distance
                : distance; // for same rotation on both sides

            setState(() {
              _positionX +=
                  details.delta.dx; // Update the card position during drag

              rotationFactor = distance /
                  500; // Rotate the card no matter the swipe distance
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
            child: Container(
              width: widget.topIndex != widget.index
                  ? widget.width - 20
                  : widget.width,
              height: widget.topIndex != widget.index
                  ? widget.height - 50
                  : widget.height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                image: DecorationImage(
                  image: NetworkImage(widget.cardModel.imageUrl),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  swipeDirection == SwipeDirection.right
                      ? LikeDislikeIcon.like()
                      : swipeDirection == SwipeDirection.left
                          ? LikeDislikeIcon.dislike()
                          : const SizedBox(),
                ],
              ),
            ),
          ),
        ),

        // blurring the other card if it is not at the top
        if (widget.topIndex != widget.index)
          Positioned.fill(
            child: BackdropFilter(
              filter: ui.ImageFilter.blur(sigmaX: 4.0, sigmaY: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
