import 'package:flutter/material.dart';

enum TransactionType { income, expense, transfer, bill }
enum TransactionStatus { completed, pending, paid }

class Transaction {
  final String id;
  final String title;
  final String subtitle;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String category;
  final TransactionStatus status;
  final IconData icon;
  final Color iconColor;

  const Transaction({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.amount,
    required this.date,
    required this.type,
    required this.category,
    required this.status,
    required this.icon,
    required this.iconColor,
  });

  bool get isIncome => type == TransactionType.income;
  bool get isExpense =>
      type == TransactionType.expense || type == TransactionType.bill;
}
