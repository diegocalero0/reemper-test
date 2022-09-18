import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';
import 'package:reemper/usecases/get_modalities_use_case.dart';
import 'package:mockito/annotations.dart';
import 'modalities_presenter_test.mocks.dart';

@GenerateMocks([GetModalitiesUseCase])
main() {

  final MockGetModalitiesUseCase mockGetModalitiesUseCase = MockGetModalitiesUseCase();

  final ModalitiesPresenter _modalitiesPresenter = ModalitiesPresenter(getModalitiesUseCase: mockGetModalitiesUseCase);

  group("Test getOrderedModalities", () {
    test("Selected is null", () {
      when(mockGetModalitiesUseCase.invoke()).thenReturn(modalities);
      _modalitiesPresenter.initModalities();
      final List<ModalityModel> orderedModalities = _modalitiesPresenter.getOrderedModalities();
      assert(orderedModalities == _modalitiesPresenter.modalities);
    });

    test("Selected is not null", () {
      when(mockGetModalitiesUseCase.invoke()).thenReturn(modalities);
      _modalitiesPresenter.initModalities();
      final int index = 2;
      _modalitiesPresenter.selectModality = modalities[index];
      final List<ModalityModel> orderedModalities = _modalitiesPresenter.getOrderedModalities();



      assert(orderedModalities[0] == modalities[(index + modalities.length - 2) % modalities.length]);
      assert(orderedModalities[1] == modalities[(index + modalities.length - 1) % modalities.length]);
      assert(orderedModalities[2] == modalities[index]);
      assert(orderedModalities[3] == modalities[(index + 1) % modalities.length]);

    });

  });

}