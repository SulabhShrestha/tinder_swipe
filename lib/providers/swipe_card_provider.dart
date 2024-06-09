// simple riverpod code.
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:swipe_card/models/card_model.dart';
import 'package:swipe_card/utils/urls_contant.dart';

class SwipeCardProvider extends StateNotifier<List<CardModel>> {
  SwipeCardProvider()
      : super([
          CardModel(imageUrl: UrlsContant.pic1),
          CardModel(imageUrl: UrlsContant.pic2),
          CardModel(imageUrl: UrlsContant.pic3),
          CardModel(imageUrl: UrlsContant.pic4),
          CardModel(imageUrl: UrlsContant.pic5),
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
