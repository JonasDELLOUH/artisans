import 'package:flutter/material.dart';

class Themes {
  var lightTheme = ThemeData(
    // Define the default brightness and colors.
    brightness: Brightness.light,
    primaryColor: Colors.red,
    buttonTheme: ButtonThemeData(
      buttonColor: Colors.blue, // Couleur du bouton
      shape: RoundedRectangleBorder( // Forme du bouton
        borderRadius: BorderRadius.circular(8.0),
      ),
      padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Espacement intérieur du bouton
      // Autres caractéristiques de style pour les boutons
      // Vous pouvez définir des styles spécifiques pour différents types de boutons, comme `textButtonTheme`, `outlinedButtonTheme`, etc.
    ),

    // Define the default font family.
    fontFamily: 'Georgia',

    // Define the default `TextTheme`. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: const TextTheme(
      displayLarge: TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
      titleLarge: TextStyle(fontSize: 36, fontStyle: FontStyle.italic),
      bodyMedium: TextStyle(fontSize: 14, fontFamily: 'Hind', color: Colors.red),
    ),
  );
  var darkTheme = ThemeData.dark().copyWith(
      primaryColor: Colors.blueGrey[800],
      brightness: Brightness.dark,
      textTheme: const TextTheme(
          // titleLarge: TextStyle(color: Colors.white)
          ),
      buttonTheme: const ButtonThemeData(buttonColor: Colors.green));
}
