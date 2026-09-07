import 'package:flutter/material.dart';
import '../models/transaction_model.dart';
import '../models/savings_goal_model.dart';
import '../models/category_model.dart';
import '../../core/theme/app_colors.dart';

class MockData {
  MockData._();

  // ─── User ───
  static const String userName = 'Andrés';
  static const String cardNumber = '•••• 5873';
  static const String cardHolder = 'ANDRÉS MANZANERA';
  static const double totalBalance = 1023.00;
  static const double monthlyIncome = 2123.00;
  static const double monthlyExpense = 1402.00;
  static const double totalSaved = 4120.00;
  static const double savedPercentChange = 8.2;
  static const double savedThisMonth = 340.00;

  // ─── Statistics ───
  static const double dailyAverage = 45.22;
  static const double budgetTotal = 2060.00;
  static const double budgetUsedPercent = 0.68;
  static const double budgetRemaining = 658.00;

  // ─── Monthly evolution chart data (day, expense, income) ───
  static final List<Map<String, double>> monthlyEvolution = [
    {'day': 1, 'expense': 120, 'income': 0},
    {'day': 5, 'expense': 280, 'income': 850},
    {'day': 8, 'expense': 450, 'income': 850},
    {'day': 10, 'expense': 520, 'income': 850},
    {'day': 13, 'expense': 680, 'income': 850},
    {'day': 15, 'expense': 810, 'income': 1850},
    {'day': 18, 'expense': 950, 'income': 1850},
    {'day': 20, 'expense': 1050, 'income': 1850},
    {'day': 23, 'expense': 1180, 'income': 2123},
    {'day': 25, 'expense': 1280, 'income': 2123},
    {'day': 28, 'expense': 1350, 'income': 2123},
    {'day': 31, 'expense': 1402, 'income': 2123},
  ];

  // ─── Transactions ───
  static final List<Transaction> transactions = [
    Transaction(
      id: '1',
      title: 'Lindsey Sudiro',
      subtitle: 'Transferencia recibida · Hoy',
      amount: 120.00,
      date: DateTime.now(),
      type: TransactionType.income,
      category: 'Transferencias',
      status: TransactionStatus.completed,
      icon: Icons.swap_horiz_rounded,
      iconColor: AppColors.secondary,
    ),
    Transaction(
      id: '2',
      title: 'Supermercado Mercadona',
      subtitle: 'Alimentación · 14:32',
      amount: -64.30,
      date: DateTime.now(),
      type: TransactionType.expense,
      category: 'Alimentación',
      status: TransactionStatus.completed,
      icon: Icons.shopping_cart_rounded,
      iconColor: AppColors.categoryFood,
    ),
    Transaction(
      id: '3',
      title: 'Bizum recibido (Laura M.)',
      subtitle: 'Transferencias · 11:15',
      amount: 30.00,
      date: DateTime.now(),
      type: TransactionType.income,
      category: 'Transferencias',
      status: TransactionStatus.completed,
      icon: Icons.phone_android_rounded,
      iconColor: AppColors.secondary,
    ),
    Transaction(
      id: '4',
      title: 'Kopi Kenangan',
      subtitle: 'Café & Restaurantes · Ayer',
      amount: -3.12,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.expense,
      category: 'Café & Restaurantes',
      status: TransactionStatus.completed,
      icon: Icons.coffee_rounded,
      iconColor: AppColors.categoryShopping,
    ),
    Transaction(
      id: '5',
      title: 'Netflix Suscripción',
      subtitle: 'Ocio · 08:00',
      amount: -12.99,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.expense,
      category: 'Ocio',
      status: TransactionStatus.completed,
      icon: Icons.play_circle_filled_rounded,
      iconColor: AppColors.categoryLeisure,
    ),
    Transaction(
      id: '6',
      title: 'Transferencia a Carlos',
      subtitle: 'Cena compartida · 21:40',
      amount: -45.00,
      date: DateTime.now().subtract(const Duration(days: 1)),
      type: TransactionType.transfer,
      category: 'Transferencias',
      status: TransactionStatus.pending,
      icon: Icons.send_rounded,
      iconColor: AppColors.warning,
    ),
    Transaction(
      id: '7',
      title: 'Pecel Madiun Cak Ilham',
      subtitle: 'Almuerzo diario · 18 Mar',
      amount: -5.00,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.expense,
      category: 'Café & Restaurantes',
      status: TransactionStatus.completed,
      icon: Icons.restaurant_rounded,
      iconColor: AppColors.categoryShopping,
    ),
    Transaction(
      id: '8',
      title: 'Nómina Tech Corp',
      subtitle: 'Ingreso mensual · 15 Mar',
      amount: 1850.00,
      date: DateTime.now().subtract(const Duration(days: 5)),
      type: TransactionType.income,
      category: 'Nómina',
      status: TransactionStatus.completed,
      icon: Icons.business_rounded,
      iconColor: AppColors.success,
    ),
    Transaction(
      id: '9',
      title: 'Factura Luz Endesa',
      subtitle: 'Servicios del hogar · 10:04',
      amount: -78.20,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.bill,
      category: 'Servicios & Facturas',
      status: TransactionStatus.paid,
      icon: Icons.bolt_rounded,
      iconColor: AppColors.categoryServices,
    ),
    Transaction(
      id: '10',
      title: 'Farmacia Central',
      subtitle: 'Salud · 17:18',
      amount: -16.40,
      date: DateTime.now().subtract(const Duration(days: 3)),
      type: TransactionType.expense,
      category: 'Salud',
      status: TransactionStatus.completed,
      icon: Icons.local_pharmacy_rounded,
      iconColor: AppColors.categoryHealth,
    ),
  ];

  // ─── Savings Goals ───
  static final List<SavingsGoal> savingsGoals = [
    SavingsGoal(
      id: '1',
      title: 'Mi Ordenador de Trabajo',
      subtitle: 'Meta para Diciembre 2024',
      currentAmount: 520.00,
      targetAmount: 1100.00,
      isCompleted: false,
      deadline: DateTime(2024, 12, 31),
      icon: Icons.laptop_mac_rounded,
    ),
    SavingsGoal(
      id: '2',
      title: 'Viaje a Japón',
      subtitle: 'Vacaciones primavera 2025',
      currentAmount: 2100.00,
      targetAmount: 3500.00,
      isCompleted: false,
      deadline: DateTime(2025, 4, 1),
      icon: Icons.flight_rounded,
    ),
    SavingsGoal(
      id: '3',
      title: 'Fondo de Emergencia',
      subtitle: '3 meses de gastos fijos',
      currentAmount: 1500.00,
      targetAmount: 2000.00,
      isCompleted: false,
      icon: Icons.shield_rounded,
    ),
    SavingsGoal(
      id: '4',
      title: 'Anillo de Compromiso',
      subtitle: '¡Meta alcanzada!',
      currentAmount: 620.00,
      targetAmount: 620.00,
      isCompleted: true,
      icon: Icons.diamond_rounded,
    ),
  ];

  // ─── Category Breakdown ───
  static final List<CategoryData> categoryBreakdown = [
    CategoryData(
      name: 'Compras & Hogar',
      amount: 500.00,
      percentage: 36,
      color: AppColors.categoryShopping,
      icon: Icons.shopping_bag_rounded,
      count: 14,
      countLabel: '14 compras',
    ),
    CategoryData(
      name: 'Café & Restaurantes',
      amount: 280.00,
      percentage: 20,
      color: AppColors.categoryFood,
      icon: Icons.restaurant_rounded,
      count: 19,
      countLabel: '19 visitas',
    ),
    CategoryData(
      name: 'Servicios & Facturas',
      amount: 230.12,
      percentage: 16,
      color: AppColors.categoryServices,
      icon: Icons.receipt_long_rounded,
      count: 4,
      countLabel: '4 recibos',
    ),
    CategoryData(
      name: 'Ocio & Entretenimiento',
      amount: 160.00,
      percentage: 11,
      color: AppColors.categoryLeisure,
      icon: Icons.sports_esports_rounded,
      count: 5,
      countLabel: '5 eventos',
    ),
    CategoryData(
      name: 'Transporte',
      amount: 120.00,
      percentage: 9,
      color: AppColors.categoryTransport,
      icon: Icons.directions_bus_rounded,
      count: 0,
      countLabel: 'Abono & Viajes',
    ),
    CategoryData(
      name: 'Otros',
      amount: 111.88,
      percentage: 8,
      color: AppColors.lightTextTertiary,
      icon: Icons.more_horiz_rounded,
      count: 0,
      countLabel: 'Varios',
    ),
  ];
}
