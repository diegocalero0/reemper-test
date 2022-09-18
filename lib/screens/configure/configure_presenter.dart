import 'package:flutter/material.dart';
import 'package:reemper/base/base_state.dart';

abstract class ConfigureScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToCoverageScreen();
}

class ConfigurePresenter {
  ConfigureScreenDelegate? mView;
}
