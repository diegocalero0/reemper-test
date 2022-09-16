import 'package:flutter/material.dart';
import 'package:reemper/base/base_state.dart';

abstract class ModalitiesScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToSkillsScreen();
}

class ModalitiesPresenter {
  ModalitiesScreenDelegate? mView;
}
