import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme/app_theme.dart';
import 'providers/theme_provider.dart';
import 'widgets/responsive_scaffold.dart';
import 'screens/dashboard/dashboard_screen.dart';
import 'screens/movements/movements_screen.dart';
import 'screens/savings/savings_screen.dart';
import 'screens/statistics/statistics_screen.dart';

class FinancyApp extends StatelessWidget {
  const FinancyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();

    return MaterialApp(
      title: 'Financy - Finanzas Personales',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: themeProvider.themeMode,
      home: ResponsiveScaffold(
        screens: const [
          DashboardScreen(),
          MovementsScreen(),
          SavingsScreen(),
          StatisticsScreen(),
        ],
      ),
    );
  }
}
