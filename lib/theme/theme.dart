import 'package:flutter/material.dart';

ThemeData lightmode = ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.light(
        surface: Colors.white,
        primary: const Color.fromRGBO(177, 255, 199, 1),
        secondary: const Color.fromRGBO(102, 180, 124, 1),
        tertiary: Colors.black,
        primaryFixed: Colors.grey.shade700,
        primaryContainer: const Color.fromRGBO(142, 231, 167, 1),
        tertiaryFixedDim: const Color.fromARGB(20, 255, 255, 255),
        primaryFixedDim: const Color.fromRGBO(102, 180, 124, 1),
        secondaryFixed: const Color.fromRGBO(177, 255, 199, 1)));

ThemeData darkmode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        surface: Colors.black,
        primary: const Color.fromARGB(20, 255, 255, 255),
        secondary: const Color.fromARGB(30, 255, 255, 255),
        tertiary: Colors.white,
        primaryFixed: Colors.grey.shade400,
        primaryContainer: const Color.fromARGB(30, 255, 255, 255),
        tertiaryFixedDim: const Color.fromARGB(50, 255, 255, 255),
        primaryFixedDim: const Color.fromARGB(200, 255, 255, 255),
        secondaryFixed: Colors.black));
