import 'dart:io';
import 'package:sizer/sizer.dart';
import 'package:flutter/material.dart';

const int totalColumns = 15;
const int totalRows = 15;
const double mockupWidth = 360.0;
const double mockupHeight = 640.0;

///Classe de responsividade da aplicação
extension ThemeDataExtension on ThemeData {
  double orientedSize(double size) => Device.orientation == Orientation.portrait ? size.h : size.w;
  double get columnSize => Device.orientation == Orientation.portrait ? (100 / totalColumns).w : (100 / totalColumns).h;
  double get rowSize => Device.orientation == Orientation.portrait ? (100 / totalRows).h : (100 / totalRows).w;
  double get maxWidth => Device.orientation == Orientation.portrait ? 100.0.w : 100.0.h;
  double get maxHeight => Device.orientation == Orientation.portrait ? 100.0.h : 100.0.w;
}

extension SizerExt on num {
  ///s = scale (aumentar/diminuir proporcionalmente a largura da tela aplicando o fator de proporcao quando o dispositivo for tablet)
  double get s => this * fator(0);

  double get s1 => this * fator(1);

  double get s2 => this * fator(2);

  double get s3 => this * fator(3);
  
  double get s4 => this * fator(4);

  double get s5 => this * fator(5);

  ///r = resize (aumentar/diminuir proporcionalmente a largura da tela)
  double get r => this * (Device.width / mockupWidth);
}

///retorna o dispositivo usado pelo usuario
ScreenType get device {
  if (Platform.isAndroid || Platform.isIOS) {
    if ((Device.width < 720)) {
      return ScreenType.mobile;
    } else {
      return ScreenType.tablet;
    }
  } else {
    return Device.screenType;
  }
}

double fator(int multiplicador) {
  var limite = 500 + (500 * 0.1 * multiplicador);

  if (device == ScreenType.tablet) {
    return ((Device.width <= limite ? Device.width : limite) / mockupWidth);
  } else {
    return (Device.width / mockupWidth);
  }
}

double get appBarSizeLandscape => isMobile ? 2.5 : 2;

///Como estamos em modo paisagem (landscape), a largura se torna a altura, então a validação é baseada
///na altura quando o dispositivo está deitado. Geralmente, tablets têm uma altura maior que 400.
bool get isMobile => device == ScreenType.mobile && Device.width <= 430; 