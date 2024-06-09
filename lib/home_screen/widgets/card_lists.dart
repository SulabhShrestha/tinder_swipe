import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_card/home_screen/widgets/swipable_card.dart';
import 'package:swipe_card/providers/swipe_card_provider.dart';

class CardList extends ConsumerStatefulWidget {
  const CardList({super.key});

  @override
  ConsumerState<CardList> createState() => _CardListState();
}

class _CardListState extends ConsumerState<CardList> {
  int _topIndex = 0;

  @override
  void initState() {
    super.initState();

    _topIndex = ref.read(swipeCardProvider).length - 1;
  }

  void _removeCard(int index) {
    final swipeCardProv = ref.read(swipeCardProvider.notifier);

    swipeCardProv.removeCard(index);

    _topIndex = ref.read(swipeCardProvider).length - 1;
    log("Top index: $_topIndex");
  }

  @override
  Widget build(BuildContext context) {
    final cards = ref.watch(swipeCardProvider);

    return Stack(children: [
      for (int i = 0; i < cards.length; i++)
        SwipableCard(
          cardModel: cards[i],
          onSwipe: (index) {
            log("Swiped card at index $index");
            _removeCard(index);
          },
          index: i,
          topIndex: _topIndex,
        ),
    ]);
  }
}
