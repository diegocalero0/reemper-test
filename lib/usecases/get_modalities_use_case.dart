import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/constants/string_constants.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/widgets/modality_item.dart';

final List<ModalityModel> modalities = [
    ModalityModel(name: kModalityNameTogo, description: kModalityDescriptionTogo, asset: kIcCar, selectedType: ModalityItemSelectedType.light),
    ModalityModel(name: kModalityNameMeeting, description: kModalityDescriptionMeeting, asset: kIcMeeting, selectedType: ModalityItemSelectedType.shadow, enabled: false),
    ModalityModel(name: kModalityNameResident, description: kModalityDescriptionResident, selectedType: ModalityItemSelectedType.light, asset: kIcResident),
    ModalityModel(name: kModalityNameVideoconsulta, description: kModalityDescriptionVideoconsulta, selectedType: ModalityItemSelectedType.shadow, asset: kIcVideocam),
  ];

/// Use case that returns the modalities enables for the app
class GetModalitiesUseCase {

  List<ModalityModel> invoke() {
    return modalities;
  }
}