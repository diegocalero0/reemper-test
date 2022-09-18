import 'dart:math';

import 'package:flutter/material.dart';
import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/models/modality_model.dart';
import 'package:reemper/screens/configure/configure_presenter.dart';
import 'package:reemper/screens/coverage/coverage_screen.dart';
import 'package:reemper/screens/modalities/modalities_presenter.dart';
import 'package:reemper/servicelocator/locator.dart';
import 'package:reemper/widgets/custom_app_bar_widget.dart';
import 'package:reemper/widgets/custom_main_button.dart';
import 'package:reemper/widgets/modality_item.dart';

class ConfigureScreen extends StatefulWidget {

    const ConfigureScreen({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ConfigureScreenState();

}

class _ConfigureScreenState extends ConfigureScreenDelegate<ConfigureScreen>  with TickerProviderStateMixin {

  late final AnimationController _controller;
  final ConfigurePresenter presenter = ConfigurePresenter();
  final ModalitiesPresenter modalitiesPresenter = locator.get<ModalitiesPresenter>();

  bool isLeft = false;
  double initialX = 0;
  double initialY = 0;
  double distanceX = 0;
  double distanceY = 0;
  double multiplier = 1;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) {
        final List<ModalityModel> modalities = modalitiesPresenter.getOrderedModalities();
        if(multiplier < 0) {
          modalitiesPresenter.selectModality = modalities[1];
          refreshScreen();
        } else {
          modalitiesPresenter.selectModality = modalities[3];
          refreshScreen();
        }
        _controller.reset();
      }
    });
    
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
        onPressed: navigateToCoverageScreen,
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

  double endX = 0;
  double endY = 0;

  Widget _createItems() {
    final List<ModalityModel> modalities = modalitiesPresenter.getOrderedModalities();

    return Stack(
      children: <Widget>[
        Positioned(
          child:  _createItemSelected(false),
          bottom: 0,
          left: 0,
          right: 0,
        ),
        GestureDetector(
          onHorizontalDragStart: ((DragStartDetails details) {
            initialX = details.globalPosition.dx;
            initialY = details.globalPosition.dy;
          }),
          onHorizontalDragEnd: ((DragEndDetails details) {
            if(distanceX < 0) {
              if(initialY > 400) {
                multiplier = 1;
              } else {
                multiplier = -1;
              }
              
            } else {
              if(initialY > 400) {
                multiplier = -1;
              } else {
                multiplier = 1;
              }
             
            }
            _controller.forward();
          }),
          onHorizontalDragUpdate: (DragUpdateDetails details) {
            endX = details.globalPosition.dx;
            endY = details.globalPosition.dy;
            distanceX = details.globalPosition.dx - initialX;  
            distanceY = details.globalPosition.dy - initialY;  
          },
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AnimatedBuilder(
                  animation: _controller,
                  builder: (BuildContext context, child) {
                    return Transform.translate(
                      child: _createItem(modalities[0]),
                      offset: Offset(120 * _controller.value * multiplier, 80 * _controller.value),
                    );
                  }
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, child) {
                        return Transform.translate(
                          child: _createItem(modalities[1]),
                          offset: Offset(120 * _controller.value, (multiplier > 0 ? -80 : -60) * _controller.value * multiplier),
                        );
                      }
                    ),
                    const SizedBox(width: 16),
                    Stack(
                      children: <Widget>[
                        _createItemSelected(true),
                        Positioned(
                          left: 0,
                          right: 0,
                          top: 120/2,
                          child: AnimatedBuilder(
                            animation: _controller,
                            builder: (BuildContext context, child) {
                              return Transform.translate(
                                child: _createItem(modalities[2]),
                                offset: Offset(-120 * _controller.value * multiplier, -60 * _controller.value),
                              );
                            }
                          ),
                        )
                      ],
                    ),
                    const SizedBox(width: 16),
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, child) {
                        return Transform.translate(
                          child: _createItem(modalities[3]),
                          offset: Offset(-120 * _controller.value,  (multiplier < 0 ? 80 : 60) * _controller.value * multiplier),
                        );
                      }
                    ),
                  ],
                )
              ],
            ),
          )
        )
      ],
    );
  }

  Widget _createItem(ModalityModel modality) {
    return ModalityItem(modality: modality, onClick: () {
        modalitiesPresenter.selectModality = modality;
        refreshScreen();
      });
  }

  Widget _createItemSelected(bool invisible) {
    if(invisible) {
      return Container(
        width: 135,
        height: 135,
        margin: const EdgeInsets.only(top: 32),
      );
    }
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

  @override
  void navigateToCoverageScreen() {
    navigatePush(const CoverageScreen(key: Key("CoverageScreen")));
  }

}
