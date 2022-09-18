import 'package:flutter/material.dart';

/// Widget that represents the reusable app bar for app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

  final String title;
  final bool isDarkBody;
  final String? subTitle;

  const CustomAppBar({required this.title, this.isDarkBody = true, this.subTitle ,Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: <Widget>[
            GestureDetector(
              onTap: Navigator.of(context).pop,
              child: Row(
                children: <Widget>[
                  IconButton(
                    padding: const EdgeInsets.all(0),
                    iconSize: 16,
                    onPressed: () {
                      
                    },
                    icon: Icon(Icons.arrow_back_ios, color: getColor())
                  ),
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      color: getColor()
                    )
                  ),
                ],
              ),
            ),
            Expanded(
              child: Text(
                subTitle ?? "",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: getColor()
                ),
                textAlign: TextAlign.end,
              ),
            )
          ],
        ),
      )
    );
   
  }

  /// Method that returns the color
  /// for the app bar, based in its mode (Dark or Light)
  Color getColor() {
    return isDarkBody ? const Color(0xffF2F2F2).withOpacity(0.5) : const Color(0xff1A1E22);
  }

  @override
  Size get preferredSize => Size.fromHeight(64);

}