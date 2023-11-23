
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const Color kScaffoldColor = Color(0xFF1C2833);
const Color kPrimaryColor = Color(0xFF17202A);
const Color kSecondaryColor = Color(0xFF32B3DF);
const Color kTextColor = Color(0xFFFFFFFF);

Color setupColor(double percentage) {
  if (percentage >= 0.50) {
    return kScaffoldColor;
  } else if (percentage >= 0.25) {
    return Colors.orange;
  }
  return Colors.red;
}