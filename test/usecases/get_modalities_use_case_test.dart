import 'package:flutter_test/flutter_test.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/usecases/get_modalities_use_case.dart';

void main() {
  test("Get modalities use case", () {
    final GetModalitiesUseCase _getModalitiesUseCase = GetModalitiesUseCase();
    final List<ModalityModel> modalities =  _getModalitiesUseCase.invoke();
    assert(modalities.length == 4);
  });
}