import 'package:flutter/material.dart';
LinearGradient createGradient(Color startColor, Color endColor) {
  return LinearGradient(
    colors: [startColor, endColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}