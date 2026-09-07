import 'package:flutter/material.dart';

class SavingsGoal {
  final String id;
  final String title;
  final String subtitle;
  final double currentAmount;
  final double targetAmount;
  final bool isCompleted;
  final DateTime? deadline;
  final IconData icon;

  const SavingsGoal({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.currentAmount,
    required this.targetAmount,
    required this.isCompleted,
    this.deadline,
    required this.icon,
  });

  double get progressPercent =>
      targetAmount > 0 ? (currentAmount / targetAmount).clamp(0.0, 1.0) : 0.0;

  int get progressPercentInt => (progressPercent * 100).round();

  double get remainingAmount => (targetAmount - currentAmount).clamp(0.0, targetAmount);
}
