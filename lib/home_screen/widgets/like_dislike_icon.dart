import 'package:flutter/material.dart';

class LikeDislikeIcon extends StatelessWidget {
  final bool isLike;

  const LikeDislikeIcon._({required this.isLike});

  /// Factory method to create a like widget
  factory LikeDislikeIcon.like() {
    return const LikeDislikeIcon._(isLike: true);
  }

  /// Factory method to create a dislike widget
  factory LikeDislikeIcon.dislike() {
    return const LikeDislikeIcon._(isLike: false);
  }

  @override
  Widget build(BuildContext context) {
    return isLike ? _buildLikeWidget() : _buildDislikeWidget();
  }

  Widget _buildLikeWidget() {
    return Positioned(
      top: 0,
      left: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.favorite, color: Colors.green, size: 32),
      ),
    );
  }

  Widget _buildDislikeWidget() {
    return Positioned(
      top: 0,
      right: 0,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.close, color: Colors.red, size: 32),
      ),
    );
  }
}
