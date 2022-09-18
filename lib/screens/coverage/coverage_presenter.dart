import 'package:reemper/base/base_state.dart';
import 'package:reemper/models/modality_model.dart';

/// Presenter that defines the behaviour of CoverageScreen
class CoveragePresenter {
  
  BaseState? mView;

  ModalityModel? _selectedModality;

  bool isConferenceEnabled = false;

  set changeConferenceStatus(bool status) {
    isConferenceEnabled = status;
    mView?.refreshScreen();
  }

  set selectModality(ModalityModel modality) {
    _selectedModality = modality;
  }

  ModalityModel? get getSelectedModality => _selectedModality;
}
