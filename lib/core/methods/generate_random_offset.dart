import 'dart:math';

import 'package:flutter/material.dart';

int findButtoncount(int levelNumber) {
  switch (levelNumber) {
    case 1:
      return 10;

    case 2:
      return 12;
    case 3:
      return 15;
    default:
      return 10;
  }
}

List<Offset> generateRandomButtonOffset(
  MediaQueryData mediaQuery,
  int buttonCount,
  double buttonWidth,
  double buttonHeight,
) {
  List<Offset> positions = [];

  // Ekran boyutlarını bul.
  double width = mediaQuery.size.width * 0.88;
  double height = mediaQuery.size.height * 0.8;

  // Butonların en yakın mesafesini hesapla.
  double spacing = buttonWidth + 15;

  // Butonların yerleştirileceği bir alanı tanımla.
  // Rect area = Rect.fromLTWH(0, 0, width, height);

  // Butonları rastgele yerleştir.
  while (positions.length < buttonCount) {
    // Butonun x koordinatını rastgele seç.

    double x = Random().nextDouble() * width;

    // Butonun y koordinatını rastgele seç.
    double y = Random().nextDouble() * height;

    // Butonun pozisyonunu kontrol et.
    bool collision = false;
    for (Offset otherPosition in positions) {
      // Butonların birbirine temas edip etmediğini kontrol et.
      if (x >= otherPosition.dx - spacing &&
          x <= otherPosition.dx + spacing &&
          y >= otherPosition.dy - spacing &&
          y <= otherPosition.dy + spacing) {
        collision = true;
        break;
      }
    }

    // Butonun konumu geçerliyse ekle.
    if (!collision) {
      positions.add(Offset(x, y));
    }
  }

  return positions;
}
