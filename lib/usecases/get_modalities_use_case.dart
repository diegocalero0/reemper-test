import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/models/modality_model.dart';

class GetModalitiesUseCase {

  final List<ModalityModel> modalities = [
    ModalityModel(name: "To go", description: "Lleva tu servicio hasta donde tu usuario.", asset: kIcCar),
    ModalityModel(name: "Meeting", description: "Genera encuentros en tus cafés o coworkings favoritos.", asset: kIcMeeting),
    ModalityModel(name: "Resident", description: "Dispón de tu consultorio u oficina para ofrecer tus servicios.", asset: kIcResident),
    ModalityModel(name: "Videoconsulta", description: "Realiza tus encuentros a través de video llamadas.", asset: kIcCar),
  ];

  List<ModalityModel> invoke() {
    return modalities;
  }
}