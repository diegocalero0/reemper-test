import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/constants/string_constants.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/screens/coverage/coverage_presenter.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';
import 'package:reemper/servicelocator/locator.dart';
import 'package:reemper/widgets/custom_app_bar_widget.dart';
import 'package:reemper/widgets/custom_main_button.dart';
import 'package:reemper/widgets/modality_item.dart';

class CoverageScreen extends StatefulWidget {

    const CoverageScreen({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _CoverageScreenState();

}

class _CoverageScreenState extends CoverageScreenDelegate<CoverageScreen> with TickerProviderStateMixin {

  late final AnimationController _controller;
  late final AnimationController _controllerStart;

  final CoveragePresenter presenter = CoveragePresenter();
  final ModalitiesPresenter modalitiesPresenter = locator.get<ModalitiesPresenter>();

  @override
  void initState() {

    _controllerStart = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _controllerStart.forward();

    Future.delayed(const Duration(seconds: 2), () {
      _controller.forward();
    });

    presenter.mView = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(title: "Ajustes", subTitle: "Cobertura de servicios"),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 24),
            AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, child) {
                return Transform.translate(
                  offset: Offset(0, (1 - _controller.value) * 120),
                  child: AnimatedOpacity(
                    opacity: _controller.value,
                    duration: const Duration(milliseconds: 500),
                    child: _createItems(),
                  ),
                );
              }
            ),
            Expanded(
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: _createContent(),
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                  ),
                  AnimatedBuilder(
                    animation: _controllerStart,
                    builder: (BuildContext context, child) {
                      return Transform.translate(
                        offset: Offset(0, 50 - (_controllerStart.value * 50)),
                        child: _createLogo(),
                      );
                    }
                  )
                ],
              ),
            )
          ],
        )
      )
    );
  }

  Widget _createShadow() {
    return Container(
      width: 40,
      height: 150,
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x7A5CBEF8),
            spreadRadius: 6,
            blurRadius: 24
          )
        ]
      ),
    );
  }

  Widget _createLogo() {
    return SizedBox(
      width: double.infinity,
        child: Stack(
        children: [
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, child) {
                return AnimatedOpacity(
                  opacity: _controller.value < 0.5 ? _controller.value + (0.5 * _controller.value) : 1 - _controller.value,
                  duration: const Duration(milliseconds: 500),
                  child:  _createShadow(),
                );
              },
            ),
          ),
          Center(
            child: AnimatedBuilder(
              animation: _controller,
              builder: (BuildContext context, child) {
                return AnimatedOpacity(
                  child: Container(
                    margin: const EdgeInsets.only(top: 48),
                    child: Transform(
                      child: Image.asset(kIcLogo),
                      transform: Matrix4.rotationX(_controller.value),
                    )
                  ),
                  duration: const Duration(milliseconds: 500),
                  opacity: 1 - _controller.value,
                );
              },
            )
          )
        ],
      ),
    );
  }
  
  Widget _createItems() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff5CBEF8), width: 0.5),
        borderRadius: const BorderRadius.all(Radius.circular(100)),
        boxShadow: const [
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
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: modalitiesPresenter.modalities.map((ModalityModel modality) {
          return ModalityItem(
            enabled: modality.enabled,
            selected: modality == presenter.getSelectedModality,
            modality: modality,
            onClick: () {
              presenter.selectModality = modality;
              refreshScreen();
            },
            size: 74,
          );
        }).toList()
      ),
    );
  }

  Widget _createContent() {

    Widget child;

    if(presenter.getSelectedModality == null) {
      child =  AnimatedBuilder(
        animation: _controller,
        builder: (BuildContext context, child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.rotationX(1 - _controller.value),
            child: Opacity(
              opacity: _controller.value,
              child: _createContentNotSelectedItem()
            )
          );
        }
      );
    } else if(presenter.getSelectedModality?.name == kModalityNameTogo) {
      child = _createContentTogo();
    } else if(presenter.getSelectedModality?.name == kModalityNameMeeting) {
      child = Text("Goa");
    } else if(presenter.getSelectedModality?.name == kModalityNameResident) {
      child = Text("Goa");
    } else if(presenter.getSelectedModality?.name == kModalityNameVideoconsulta) {
      child = Text("Goa");
    } else {
      child = const SizedBox();
    }

    return AnimatedSwitcher(
        transitionBuilder: (Widget child, Animation<double> animation) {
          return ScaleTransition(scale: animation, child: child);
        },
        child: Padding(
          key: Key("${presenter.getSelectedModality?.name}"),
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              if(presenter.getSelectedModality != null)
                _createModalityInformation(),
              Expanded(child: child)
            ],
          )
        ),
        duration: const Duration(milliseconds: 500),
      );
  }

  Widget _createContentTogo() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _createTogoIconAndStateText(),
        CustomMainButton(
          mainText: "Agregar consultorios/oficinas",
          onPressed: () {},
          height: 44,
          borderRadius: 22,
          leftIconAsset: Icon(Icons.add_circle_rounded, color: Theme.of(context).primaryColor),
        )
      ],
    );
  }

  Widget _createTogoIconAndStateText() {
    return Column(
      children: <Widget>[
        Icon(Icons.settings, color: Colors.white.withOpacity(0.4), size: 52),
        const SizedBox(height: 30),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'Aún no agregas las ',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              fontSize: 16,
              color: Colors.white.withOpacity(0.6),
              fontWeight: FontWeight.w200
            ),
            children: <TextSpan>[
              TextSpan(text: "zonas a ", style: Theme.of(context).textTheme.bodyText1?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white.withOpacity(0.6),
                fontSize: 16,
              )),
              const TextSpan(text: 'donde dispondrás tus servicios en esta modalidad.')
            ],
          ),
        )
      ],
    );
  }

  Widget _createModalityInformation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        const SizedBox(height: 70),
        Row(
          children: <Widget>[
            Text(
              "Modalidad | ",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.white.withOpacity(0.6),
                fontWeight: FontWeight.w200,
                fontSize: 18
              )
            ),
            Text(
              presenter.getSelectedModality?.name ?? "",
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                color: Colors.white.withOpacity(0.6),
                fontSize: 20
              )
            )
          ],
        ),
        const SizedBox(height: 14),
        Text(
          "${presenter.getSelectedModality?.description}",
          style: Theme.of(context).textTheme.bodyText2?.copyWith(
            color: Colors.white.withOpacity(0.6),
            fontSize: 16,
          )
        )
      ],
    );
  }

  Widget _createContentNotSelectedItem() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        const SizedBox(height: 150),
        Image.asset(kIcInformation),
        const SizedBox(height: 32),
        Text(
          "Aún no configuras tus coberturas de servicios",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 16,
            color: Colors.white
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          "Elige y configura las modalidades con las que te gustaría disponer de tus servicios y generar encuentros con tus usuarios.",
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
            fontSize: 16,
            color: const Color(0x80FFFFFF),
            fontWeight: FontWeight.w200
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }

}
