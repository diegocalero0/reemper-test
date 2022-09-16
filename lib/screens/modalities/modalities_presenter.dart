import 'package:flutter/material.dart';
import 'package:reemper/base/base_state.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/servicelocator/locator.dart';
import 'package:reemper/usecases/get_modalities_use_case.dart';

abstract class ModalitiesScreenDelegate<T extends StatefulWidget> extends BaseState<T> {
  void navigateToSkillsScreen();
}

class ModalitiesPresenter {

  final GetModalitiesUseCase _getModalitiesUseCase;


  ModalitiesPresenter({
    GetModalitiesUseCase? getModalitiesUseCase
  }):
    _getModalitiesUseCase = getModalitiesUseCase ?? locator.get();

  List<ModalityModel> modalities = [];
  ModalityModel? _selectedModality;
  ModalitiesScreenDelegate? mView;

  void initModalities() {
    modalities = _getModalitiesUseCase.invoke();
    mView?.refreshScreen();
  }

  set selectModality(ModalityModel modality) {
    _selectedModality = modality;
    mView?.navigateToSkillsScreen();
  }

  ModalityModel? get getSelectedModality => _selectedModality;

  List<ModalityModel> getOrderedModalities() {
    if(_selectedModality != null) {
        final int selectedModalityIndex = modalities.indexOf(_selectedModality!);

        return [
          modalities[(selectedModalityIndex + modalities.length - 2) % modalities.length],
          modalities[(selectedModalityIndex + modalities.length - 1) % modalities.length],
          modalities[selectedModalityIndex],
          modalities[(selectedModalityIndex + 1) % modalities.length],
        ];

    } else {
      return modalities;
    }
  }

}
