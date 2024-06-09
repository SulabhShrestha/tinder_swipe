// simple riverpod code.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_card/models/card_model.dart';

class SwipeCardProvider extends StateNotifier<List<CardModel>> {
  SwipeCardProvider()
      : super([
          CardModel(title: "Hello 1"),
          CardModel(title: "Hello 2"),
          CardModel(title: "Hello 3"),
          CardModel(title: "Hello 4"),
          CardModel(title: "Hello 5"),
        ]);

  void removeCard(int index) {
    state.removeAt(index);
    state = List.from(state);
  }
}

final swipeCardProvider =
    StateNotifierProvider<SwipeCardProvider, List<CardModel>>((ref) {
  return SwipeCardProvider();
});
