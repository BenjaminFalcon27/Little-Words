import 'package:flutter/material.dart';

const primaryColor = Color.fromRGBO(160, 108, 213, 1);
const primaryColorLight =  Color.fromRGBO(226, 207, 234, 1);
const primaryColorDark =  Color.fromRGBO(98, 71, 170, 1);

const secondaryColor = Color.fromRGBO(16, 43, 63, 1);
const secondaryColorDark = Color.fromRGBO(6, 39, 38, 1);



class MyTheme {
  static final ThemeData defaultTheme = _buildMyTheme();

  static ThemeData _buildMyTheme() {
    final ThemeData base = ThemeData.light();

    return base.copyWith(

      primaryColor: primaryColor,
      primaryColorDark: primaryColorDark,
      primaryColorLight: primaryColorLight,

      buttonTheme: base.buttonTheme.copyWith(
        buttonColor: secondaryColor,
        textTheme: ButtonTextTheme.primary,
      ),
    );
  }
}