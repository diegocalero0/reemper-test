import 'package:flutter/material.dart';
import 'package:reemper/base/base_state.dart';

/// Delegate that represents a contract between ConfigureScreen
/// and ConfigurePresenter
abstract class ConfigureScreenDelegate<T extends StatefulWidget> extends BaseState<T> {

  /// Method that navigates to the coverage screen
  void navigateToCoverageScreen();
}

/// Presenter for the configuration screen
class ConfigurePresenter {
  ConfigureScreenDelegate? mView;
}
