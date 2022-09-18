import 'package:flutter/material.dart';
import 'package:reemper/models/modality_model.dart';

enum ModalityItemSelectedType {
  shadow,
  light
}

class ModalityItem extends StatelessWidget {
  final ModalityModel modality;
  final VoidCallback onClick;
  final double size;
  final bool selected;
  final bool enabled;

  const ModalityItem({
    required this.modality,
    required this.onClick,
    this.size = 80,
    this.selected = false,
    this.enabled = true,
    Key? key
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Opacity(
        opacity: enabled ? 1.0 : 0.35,
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: _createShadowNotSelected()
          ),
          child: Stack(
            children: <Widget>[
              if(selected && modality.selectedType == ModalityItemSelectedType.light)
              Positioned.fill(
                child: Align(
                  child:  Container(
                    width: 32,
                    height: 32,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xff5CBEF8),
                          blurRadius: 12,
                          spreadRadius: 6
                        )
                      ]
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  child:  Image.asset(modality.asset, color: Colors.white.withOpacity(0.7)),
                ),
              )
            ],
          ),
        )
      )
    );
  }

  List<BoxShadow> _createShadowNotSelected() {
    return [
      if(selected && modality.selectedType == ModalityItemSelectedType.shadow)
      const BoxShadow(
        color: Color(0x60ff5CBEF8),
        blurRadius: 12
      ),
      const BoxShadow(
        color: Color(0x605CBEF8)
      ),
      const BoxShadow(
        color: Color(0xff1A1E22),
        spreadRadius: -2.0,
        blurRadius: 12.0,
      ),
    ];
  }

}