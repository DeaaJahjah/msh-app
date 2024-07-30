import 'package:flutter/material.dart';

class StateProvider extends ChangeNotifier {
  bool isLoading = false;

  changeState(bool newState) {
    isLoading = newState;
    notifyListeners();
  }
}
