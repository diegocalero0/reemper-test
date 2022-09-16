import 'package:flutter/material.dart';
import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/screens/configure/configure_presenter.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';
import 'package:reemper/servicelocator/locator.dart';
import 'package:reemper/widgets/custom_app_bar_widget.dart';
import 'package:reemper/widgets/custom_main_button.dart';

class ConfigureScreen extends StatefulWidget {

    const ConfigureScreen({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ConfigureScreenState();

}

class _ConfigureScreenState extends ConfigureScreenDelegate<ConfigureScreen> {

  final ConfigurePresenter presenter = ConfigurePresenter();
  final ModalitiesPresenter modalitiesPresenter = locator.get<ModalitiesPresenter>();

  @override
  void initState() {
    presenter.mView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Ajustes", subTitle: "Cobertura de servicios"),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xff347aa3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.5, 1]
          )
        ),
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 24),
          child: _createBody(),
        ),
      ),
      floatingActionButton: _createMainButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _createBody() {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _createMainMessage(),
          const SizedBox(height: 8),
          _createSecondaryMessage(),
          const SizedBox(height: 48),
          _createItems(),
          const SizedBox(height: 48),
          _createSelectedItemText(),
          const SizedBox(height: 8),
          _createSelectedItemDescription(),  
        ]
      ),
    );
  }

  Widget _createMainButton() {
    return Padding(
      child: CustomMainButton(
        mainText: "Configurar",
        onPressed: () {},
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
    );
  }

  Widget _createMainMessage() {
    return RichText(
      text: TextSpan(
        text: 'Configura y habilita ',
        style: Theme.of(context).textTheme.headline1,
        children: <TextSpan>[
          TextSpan(text: 'tus\ncoberturas de servicio', style: Theme.of(context).textTheme.bodyText2?.copyWith(
            fontSize: 29,
            color: const Color(0xffCCCCCC)
          ))
        ],
      ),
    );
  }

  Widget _createSecondaryMessage() {
    return Text(
      "Te ofrecemos mayor alternativas para ofrecer tus servicios profesionales y expandir la cobertura de ellos.",
      style: Theme.of(context).textTheme.bodyText2?.copyWith(
        fontWeight: FontWeight.w200,
        color: Colors.white.withOpacity(0.7),
        fontSize: 14
      ),
    );
  }

  Widget _createItems() {

    final List<ModalityModel> modalities = modalitiesPresenter.getOrderedModalities();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        _createItem(modalities[0]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _createItem(modalities[1]),
            const SizedBox(width: 16),
            _createItemSelected(),
            const SizedBox(width: 16),
            _createItem(modalities[3]),
          ],
        )
      ],
    );
  }

  Widget _createItem(ModalityModel modality) {
    return GestureDetector(
      onTap: () {
        modalitiesPresenter.selectModality = modality;
        refreshScreen();
      },
      child: Container(
        width: 80,
        height: 80,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x605CBEF8)
            ),
            BoxShadow(
            color: Color(0xff1A1E22),
            spreadRadius: -2.0,
            blurRadius: 12.0,
          ),
          ]
        ),
        child: Image.asset(modality.asset, color: Colors.white.withOpacity(0.7)),
      ),
    );
  }

  Widget _createItemSelected() {
    return Container(
        margin: const EdgeInsets.only(top: 32),
        width: 135,
        height: 135,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0x605CBEF8),
            ),
            BoxShadow(
              color: Color(0xff1A1E22),
              spreadRadius: -2.0,
              blurRadius: 12.0,
            ),
            BoxShadow(
              color: Color(0x7A5CBEF8),
              blurRadius: 24.0,
               spreadRadius: -8.0,
            ),
          ]
        ),
        child: Image.asset(modalitiesPresenter.getSelectedModality?.asset ?? "", color: Colors.white.withOpacity(0.7)),
      );
  }

  Widget _createSelectedItemText() {
    return Center(
      child: Text(
        "${modalitiesPresenter.getSelectedModality?.name}",
        style: Theme.of(context).textTheme.headline1?.copyWith(
          color: Colors.white
        ),
      ),
    );
  }

  Widget _createSelectedItemDescription() {
    return Center(
      child: Text(
        "${modalitiesPresenter.getSelectedModality?.description}",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyText2?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w200,
          fontSize: 18
        ),
      ),
    );
  }

}
