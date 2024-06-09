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

  final cardWidth = 300.0;
  final cardHeight = 400.0;

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

    return SizedBox(
      height: cardHeight,
      width: cardWidth,
      child: cards.isEmpty
          ? const Center(
              child: Text("No more cards to show."),
            )
          : Stack(
              children: List.generate(cards.length, (index) {
                return Positioned(
                  top: index != _topIndex ? 12 : 0,
                  left: index != _topIndex ? 12 : 0,
                  child: SwipableCard(
                    width: cardWidth,
                    height: cardHeight,
                    cardModel: cards[index],
                    onSwipe: (index) {
                      log("Swiped card at index $index");
                      _removeCard(index);
                    },
                    index: index,
                    topIndex: _topIndex,
                  ),
                );
              }),
            ),
    );
  }
}
