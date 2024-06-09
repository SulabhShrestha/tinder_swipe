import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_card/home_screen/widgets/card_lists.dart';
import 'package:swipe_card/home_screen/widgets/swipable_card.dart';
import 'package:swipe_card/providers/swipe_card_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CardList(),
      ),
    );
  }
}
