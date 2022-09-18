import 'package:flutter/material.dart';
import 'package:reemper/constants/assets_constants.dart';
import 'package:reemper/models/modality_model.dart';

enum ModalityItemSelectedType {
  shadow,
  light
}

/// Widget that represent the modality item for configuration
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
                  child:  Container(
                    width: size,
                    height: size,
                    padding: const EdgeInsets.all(20),
                    child: Image.asset(modality.asset, color: Colors.white.withOpacity(0.7)),
                  ),
                ),
              ),
              if(!enabled)
              Positioned(
                bottom: 16,
                right: 16,
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: Image.asset(kIcWarning, color: const Color(0xffCCCCCC)),
                ),
              )
            ],
          ),
        )
      )
    );
  }

  /// Method that creates the shadow for the item
  List<BoxShadow> _createShadowNotSelected() {
    return [
      if(selected && modality.selectedType == ModalityItemSelectedType.shadow)
      const BoxShadow(
        color: Color(0xff5CBEF8),
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