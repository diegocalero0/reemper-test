import 'package:reemper/widgets/modality_item.dart';

class ModalityModel {
  final String name;
  final String description;
  final String asset;
  final bool enabled;
  final ModalityItemSelectedType selectedType;

  ModalityModel({
    required this.name,
    required this.description,
    required this.asset,
    required this.selectedType,
    this.enabled = true
  });
}