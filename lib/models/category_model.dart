import 'package:flutter/material.dart';

enum CategoryType { 
  alphabet, 
  number, 
  shape, 
  color, 
  animal, 
  fruit, 
  bodyPart, 
  quiz, 
  math,
  flower,
  vegetable,
  vehicle,
  accessory,
  clothes,
}

class CategoryModel {
  final String id;
  final String title;
  final String icon;
  final Color color;
  final CategoryType type;
  final String description;
  final bool isPremium;

  const CategoryModel({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    required this.type,
    required this.description,
    this.isPremium = false,
  });
}
