import 'package:flutter/material.dart';
import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/screens/configure/configure_screen.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';

import 'package:reemper/widgets/custom_app_bar_widget.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ModalitiesScreen extends StatefulWidget {

    const ModalitiesScreen({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ModalitiesScreenState();

}

class _ModalitiesScreenState extends ModalitiesScreenDelegate<ModalitiesScreen> {

  final ModalitiesPresenter presenter = ModalitiesPresenter();

  int currentStep = 1;

  List<String> stepsAssets = [
    kIcDescription,
    kIcPerson,
    kIcMovie,
    kIcWork,
    kIcPayment
  ];

  @override
  void initState() {
    presenter.mView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Regresar", isDarkBody: false),
      body: SizedBox(
        child: _createBody(),
        height: double.infinity,
        width: double.infinity,
      ),
    );
  }

  Widget _createBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _createSteps(),
          const SizedBox(height: 24),
          _createIconPerson(),
          const SizedBox(height: 50),
          _createTitleAndSubtitle(),
          const SizedBox(height: 55),
          _createModalities()
        ],
      ),
    );
  }

  Widget _createIconPerson() {
    return Image.asset(
      kIcPerson,
      color: const Color(0xff28313A),
      width: 82,
      height: 82,
      fit: BoxFit.contain,
    );
  }

  Widget _createModalities() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _createModality(kIcCar, navigateToSkillsScreen),
        _createModality(kIcMeeting, navigateToSkillsScreen),
        _createModality(kIcResident, navigateToSkillsScreen),
        _createModality(kIcCameraMovie, navigateToSkillsScreen)
      ],
    );
  }

  Widget _createModality(String asset, VoidCallback action) {
    return GestureDetector(
      onTap: action,
      child: ClipOval(    
        child: Container(
          width: 70,
          height: 70,
          color: const Color(0x801a1E22),
          child: Image.asset(asset),
        ),
      ),
    );
  }

  Widget _createSteps() {
    return Column(
      children: <Widget>[
        StepProgressIndicator(
          totalSteps: stepsAssets.length,
          currentStep: currentStep,
          customStep: (int index, Color color, size) {
            return _createStep(stepsAssets[index], index);
          },
          size: 35,
          padding: 0, 
        ),
        const SizedBox(height: 32),
        Text(
          "${currentStep + 1}/${stepsAssets.length}",
          style: Theme.of(context).textTheme.bodyText1
        )
      ],
    );
  }

  Widget _createStep(String stepAsset, int index) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Opacity(
            child: Container(
              height: 6,
              color: index < currentStep ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
            ),
            opacity: index == 0 ? 0 : index <= currentStep ? 1 : 0.3,
          )
        ),
        Opacity(
          child: ClipOval(
            child: Container(
              color: index < currentStep ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
              child: Image.asset(stepAsset),
              height: 35,
              width: 35,
            ),
          ),
          opacity: index <= currentStep ? 1 : 0.3,
        ),
        Expanded(
          flex: 1,
          child: Opacity(
            child: Container(
              height: 6,
              color: index < currentStep ? Theme.of(context).primaryColor : Theme.of(context).primaryColor,
            ),
            opacity: index == stepsAssets.length - 1 ? 0 : index < currentStep ? 1 : 0.3,
          )
        )
      ],
    );
  }

  Widget _createTitleAndSubtitle() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Facilita y amplía\ntus encuentros",
          style: Theme.of(context).textTheme.headline2,
        ),
        const SizedBox(height: 6),
        Text(
          "Selecciona las modalidades en la que dispondrás este servicio.",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 16
          )
        )
      ],
    );
  }

  @override
  void navigateToSkillsScreen() {
    navigatePush(const ConfigureScreen(key: Key("ConfigureScreen")));
  }
}
