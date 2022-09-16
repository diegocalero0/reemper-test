import 'package:flutter/material.dart';

class CustomMainButton extends StatelessWidget {

  final String mainText;
  final VoidCallback onPressed;

  const CustomMainButton({required this.mainText, required this.onPressed, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 54,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith((states) {
            return RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0)
            );
          }),
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed)) {
              return const Color(0x4D5CBEF8).withOpacity(0.7);
            }
            return const Color(0x4D5CBEF8);
          }),
          shadowColor: MaterialStateProperty.resolveWith((states) {
            return Colors.transparent;
          })
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              mainText,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                color: const Color(0xff5CBEF8),
                shadows: const [
                  Shadow(
                    color: const Color(0xff5CBEF8),
                    blurRadius: 12
                  )
                ],
                fontSize: 18
              ),
            )
          ],
        )
      ),
    );
  }

}