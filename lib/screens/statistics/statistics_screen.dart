import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/category_model.dart';
import '../../providers/theme_provider.dart';

class StatisticsScreen extends StatefulWidget {
  const StatisticsScreen({super.key});

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  int _selectedTab = 0; // 0=Gastos, 1=Ingresos

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          // ─── Header ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: const Icon(
                          Icons.account_balance_wallet_rounded,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Financy',
                            style: AppTypography.titleLarge(
                              color: AppColors.textPrimary(isDark),
                            ),
                          ),
                          Text(
                            'Estadísticas',
                            style: AppTypography.bodySmall(
                              color: AppColors.textTertiary(isDark),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.settings_rounded,
                          color: AppColors.textSecondary(isDark), size: 22),
                      const SizedBox(width: AppSpacing.md),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.secondary,
                        child: Text(
                          'AM',
                          style: AppTypography.labelMedium(
                              color: AppColors.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ─── Toggle Gastos / Ingresos ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: _selectedTab == 0
                                ? AppColors.secondary
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_upward_rounded,
                                size: 16,
                                color: _selectedTab == 0
                                    ? AppColors.primary
                                    : Colors.white54,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Gastos',
                                style: AppTypography.titleSmall(
                                  color: _selectedTab == 0
                                      ? AppColors.primary
                                      : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _selectedTab = 1),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.sm),
                          decoration: BoxDecoration(
                            color: _selectedTab == 1
                                ? AppColors.secondary
                                : Colors.transparent,
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.arrow_downward_rounded,
                                size: 16,
                                color: _selectedTab == 1
                                    ? AppColors.primary
                                    : Colors.white54,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'Ingresos',
                                style: AppTypography.titleSmall(
                                  color: _selectedTab == 1
                                      ? AppColors.primary
                                      : Colors.white54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Month Selector ───
          SliverToBoxAdapter(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chevron_left_rounded,
                      color: AppColors.textSecondary(isDark)),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant(isDark),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    'Marzo 2024',
                    style: AppTypography.titleMedium(
                      color: AppColors.textPrimary(isDark),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.chevron_right_rounded,
                      color: AppColors.textSecondary(isDark)),
                ),
              ],
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Total Expense Card ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.primary,
                      AppColors.primary.withOpacity(0.85),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusXl),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'GASTO TOTAL DEL MES',
                          style: AppTypography.labelSmall(
                              color: Colors.white54),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs),
                          decoration: BoxDecoration(
                            color: AppColors.error.withOpacity(0.25),
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusFull),
                          ),
                          child: Text(
                            '+8% vs feb',
                            style: AppTypography.labelSmall(
                                color: AppColors.errorLight),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      CurrencyFormatter.format(MockData.monthlyExpense),
                      style:
                          AppTypography.displayMedium(color: Colors.white),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _StatMini(
                          label: 'Media diaria',
                          value: CurrencyFormatter.format(
                              MockData.dailyAverage),
                          icon: Icons.today_rounded,
                        ),
                        const SizedBox(width: AppSpacing.xxl),
                        _StatMini(
                          label: 'Ingresos Mes',
                          value: CurrencyFormatter.format(
                              MockData.monthlyIncome),
                          icon: Icons.arrow_downward_rounded,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Monthly Evolution Chart ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface(isDark),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLg),
                  border:
                      Border.all(color: AppColors.cardBorder(isDark)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.show_chart_rounded,
                            color: AppColors.secondary, size: 20),
                        const SizedBox(width: AppSpacing.sm),
                        Text(
                          'Evolución mensual',
                          style: AppTypography.titleSmall(
                            color: AppColors.textPrimary(isDark),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Flujo diario de gastos vs ingresos',
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Legend
                    Row(
                      children: [
                        _ChartLegend(
                          color: AppColors.error,
                          label: 'Gastos',
                          isDark: isDark,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _ChartLegend(
                          color: AppColors.secondary,
                          label: 'Ingresos',
                          isDark: isDark,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    // Chart
                    SizedBox(
                      height: 180,
                      child: _MonthlyLineChart(isDark: isDark),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Budget Bar ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface(isDark),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLg),
                  border:
                      Border.all(color: AppColors.cardBorder(isDark)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.pie_chart_rounded,
                                color: AppColors.accent, size: 20),
                            const SizedBox(width: AppSpacing.sm),
                            Text(
                              'Presupuesto mensual',
                              style: AppTypography.titleSmall(
                                color: AppColors.textPrimary(isDark),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: AppSpacing.xxs),
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusFull),
                          ),
                          child: Text(
                            '68%',
                            style: AppTypography.labelMedium(
                                color: AppColors.accent),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Límite asignado: ${CurrencyFormatter.format(MockData.budgetTotal)}',
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    ClipRRect(
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                      child: LinearProgressIndicator(
                        value: MockData.budgetUsedPercent,
                        backgroundColor: AppColors.surfaceVariant(isDark),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.accent),
                        minHeight: 10,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Has consumido el 68% del presupuesto previsto',
                          style: AppTypography.bodySmall(
                            color: AppColors.textSecondary(isDark),
                          ),
                        ),
                        Text(
                          CurrencyFormatter.format(
                              MockData.budgetRemaining),
                          style: AppTypography.amountTiny(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'restantes',
                      textAlign: TextAlign.right,
                      style: AppTypography.labelSmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Category Breakdown ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.surface(isDark),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLg),
                  border:
                      Border.all(color: AppColors.cardBorder(isDark)),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Gasto por categoría',
                          style: AppTypography.titleSmall(
                            color: AppColors.textPrimary(isDark),
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              'Ver todo',
                              style: AppTypography.labelMedium(
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Icon(Icons.arrow_forward_rounded,
                                color: AppColors.secondary, size: 16),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      'Top distribución de Marzo',
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),

                    // Top 3 categories with percentages
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: MockData.categoryBreakdown
                          .take(3)
                          .map((cat) => _CategoryCircle(
                              category: cat, isDark: isDark))
                          .toList(),
                    ),

                    const SizedBox(height: AppSpacing.lg),

                    // Full list
                    ...MockData.categoryBreakdown.map((cat) =>
                        _CategoryRow(category: cat, isDark: isDark)),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Smart Tip ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(
                    color: AppColors.secondary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.secondary.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.lightbulb_rounded,
                        color: AppColors.secondary,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Consejo inteligente',
                            style: AppTypography.titleSmall(
                              color: AppColors.textPrimary(isDark),
                            ),
                          ),
                          Text(
                            'Has gastado 54 € menos en compras que el mes pasado a estas alturas. ¡Excelente ritmo!',
                            style: AppTypography.bodySmall(
                              color: AppColors.textSecondary(isDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.xxl)),
        ],
      ),
    );
  }
}

// ─── Small stat inside the total card ───
class _StatMini extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatMini({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Icon(icon, color: Colors.white54, size: 14),
            const SizedBox(width: AppSpacing.xs),
            Text(label,
                style: AppTypography.labelSmall(color: Colors.white54)),
          ],
        ),
        const SizedBox(height: AppSpacing.xxs),
        Text(value,
            style: AppTypography.amountTiny(color: Colors.white)),
      ],
    );
  }
}

// ─── Chart Legend Dot ───
class _ChartLegend extends StatelessWidget {
  final Color color;
  final String label;
  final bool isDark;

  const _ChartLegend({
    required this.color,
    required this.label,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text(
          label,
          style:
              AppTypography.bodySmall(color: AppColors.textSecondary(isDark)),
        ),
      ],
    );
  }
}

// ─── Monthly Line Chart ───
class _MonthlyLineChart extends StatelessWidget {
  final bool isDark;
  const _MonthlyLineChart({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final data = MockData.monthlyEvolution;

    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 500,
          getDrawingHorizontalLine: (value) => FlLine(
            color: AppColors.cardBorder(isDark),
            strokeWidth: 1,
          ),
        ),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 5,
              getTitlesWidget: (value, meta) {
                final day = value.toInt();
                if (day == 1 || day == 8 || day == 15 ||
                    day == 20 || day == 25 || day == 31) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 6),
                    child: Text(
                      '${day} Mar',
                      style: AppTypography.labelSmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        lineBarsData: [
          // Expenses line
          LineChartBarData(
            spots: data
                .map((d) => FlSpot(d['day']!, d['expense']!))
                .toList(),
            isCurved: true,
            curveSmoothness: 0.3,
            color: AppColors.error,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.error.withOpacity(0.08),
            ),
          ),
          // Income line
          LineChartBarData(
            spots: data
                .map((d) => FlSpot(d['day']!, d['income']!))
                .toList(),
            isCurved: true,
            curveSmoothness: 0.3,
            color: AppColors.secondary,
            barWidth: 2.5,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.secondary.withOpacity(0.08),
            ),
          ),
        ],
        lineTouchData: LineTouchData(
          touchTooltipData: LineTouchTooltipData(
            getTooltipColor: (spot) => AppColors.surface(isDark),
            tooltipRoundedRadius: 8,
            getTooltipItems: (spots) => spots
                .map((spot) => LineTooltipItem(
                      CurrencyFormatter.format(spot.y),
                      AppTypography.labelSmall(color: spot.bar.color),
                    ))
                .toList(),
          ),
        ),
        minX: 1,
        maxX: 31,
        minY: 0,
        maxY: 2500,
      ),
    );
  }
}

// ─── Category Circle (top 3) ───
class _CategoryCircle extends StatelessWidget {
  final CategoryData category;
  final bool isDark;

  const _CategoryCircle({required this.category, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: category.color.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(category.icon, color: category.color, size: 26),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${category.percentage.toInt()}%',
          style: AppTypography.titleMedium(
            color: AppColors.textPrimary(isDark),
          ),
        ),
        Text(
          category.name.split(' ').first,
          style: AppTypography.labelSmall(
            color: AppColors.textTertiary(isDark),
          ),
        ),
      ],
    );
  }
}

// ─── Category Row (full list) ───
class _CategoryRow extends StatelessWidget {
  final CategoryData category;
  final bool isDark;

  const _CategoryRow({required this.category, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: category.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Icon(category.icon, color: category.color, size: 18),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.name,
                  style: AppTypography.titleSmall(
                    color: AppColors.textPrimary(isDark),
                  ),
                ),
                Text(
                  '${category.percentage.toInt()}% del gasto',
                  style: AppTypography.bodySmall(
                    color: AppColors.textTertiary(isDark),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                CurrencyFormatter.format(category.amount),
                style: AppTypography.amountTiny(
                  color: AppColors.textPrimary(isDark),
                ),
              ),
              Text(
                category.countLabel,
                style: AppTypography.labelSmall(
                  color: AppColors.textTertiary(isDark),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
