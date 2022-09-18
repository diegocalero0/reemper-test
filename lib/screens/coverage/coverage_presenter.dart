import 'package:flutter/material.dart';
import 'package:reemper/base/base_state.dart';
import 'package:reemper/models/modality_model.dart';

abstract class CoverageScreenDelegate<T extends StatefulWidget> extends BaseState<T> {

}

class CoveragePresenter {
  CoverageScreenDelegate? mView;

  ModalityModel? _selectedModality;

  set selectModality(ModalityModel modality) {
    _selectedModality = modality;
  }

  ModalityModel? get getSelectedModality => _selectedModality;

}
