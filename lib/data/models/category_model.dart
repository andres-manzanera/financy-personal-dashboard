import 'package:flutter/material.dart';

class CategoryData {
  final String name;
  final double amount;
  final double percentage;
  final Color color;
  final IconData icon;
  final int count;
  final String countLabel;

  const CategoryData({
    required this.name,
    required this.amount,
    required this.percentage,
    required this.color,
    required this.icon,
    required this.count,
    required this.countLabel,
  });
}
