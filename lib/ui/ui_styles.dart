import 'package:flutter/material.dart';

Map<int, Color> color =
{
  50:Color.fromRGBO(15,70,135, .1),
  100:Color.fromRGBO(15,70,135, .2),
  200:Color.fromRGBO(15,70,135, .3),
  300:Color.fromRGBO(15,70,135, .4),
  400:Color.fromRGBO(15,70,135, .5),
  500:Color.fromRGBO(15,70,135, .6),
  600:Color.fromRGBO(15,70,135, .7),
  700:Color.fromRGBO(15,70,135, .8),
  800:Color.fromRGBO(15,70,135, .9),
  900:Color.fromRGBO(15,70,135, 1),
};

final MaterialColor colorDassu = MaterialColor(0xFF0D4789, color);

final biggerFont = TextStyle(fontSize: 18.0);
final bolderFont = TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold);