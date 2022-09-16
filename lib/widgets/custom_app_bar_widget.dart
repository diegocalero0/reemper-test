import 'dart:ffi';

import 'package:flutter/material.dart';

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
        child: GestureDetector(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              IconButton(
                padding: const EdgeInsets.all(0),
                iconSize: 16,
                onPressed: () {
                  
                },
                icon: Icon(Icons.arrow_back_ios, color: getColor())
              ),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: getColor()
                  )
                ),
              ),
              Text(
                subTitle ?? "",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                  color: getColor()
                )
              ),
            ],
          ),
          onTap: () {
            Navigator.of(context).pop();
          },
        )
      ),
    );
  }

  Color getColor() {
    return isDarkBody ? const Color(0xffF2F2F2).withOpacity(0.5) : const Color(0xff1A1E22);
  }

  @override
  Size get preferredSize => Size.fromHeight(64);

}