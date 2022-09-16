import 'package:flutter/material.dart';
import 'package:reemper/screens/configure/configure_presenter.dart';
import 'package:reemper/widgets/custom_app_bar_widget.dart';

class ConfigureScreen extends StatefulWidget {

    const ConfigureScreen({Key? key}) : super(key: key);

    @override
    State<StatefulWidget> createState() => _ConfigureScreenState();

}

class _ConfigureScreenState extends ConfigureScreenDelegate<ConfigureScreen> {

  final ConfigurePresenter presenter = ConfigurePresenter();

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
            colors: [Colors.black, Color(0xff5CBEF8)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.3, 1]
          )
        ),
        child: SingleChildScrollView(
          child: _createBody(),
        ),
      ),
    );
  }

  Widget _createBody() {
    return Column(
      children: <Widget>[
        Text("hola")
      ]
    );
  }

}
