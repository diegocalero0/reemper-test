import 'package:get_it/get_it.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';
import 'package:reemper/usecases/get_modalities_use_case.dart';

final locator = GetIt.instance;

void setupLocator() {

  /// Use cases
  locator.registerLazySingleton<GetModalitiesUseCase>(() => GetModalitiesUseCase());

  /// Presenters
  locator.registerLazySingleton<ModalitiesPresenter>(() => ModalitiesPresenter());
}