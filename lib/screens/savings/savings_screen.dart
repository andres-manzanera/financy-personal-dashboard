import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/savings_goal_model.dart';
import '../../providers/theme_provider.dart';

class SavingsScreen extends StatefulWidget {
  const SavingsScreen({super.key});

  @override
  State<SavingsScreen> createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  int _selectedFilter = 0; // 0=Todas, 1=En progreso, 2=Completadas

  List<SavingsGoal> get _filteredGoals {
    switch (_selectedFilter) {
      case 1:
        return MockData.savingsGoals.where((g) => !g.isCompleted).toList();
      case 2:
        return MockData.savingsGoals.where((g) => g.isCompleted).toList();
      default:
        return MockData.savingsGoals;
    }
  }

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
                        'Financy ✦',
                        style: AppTypography.titleLarge(
                          color: AppColors.textPrimary(isDark),
                        ),
                      ),
                      Text(
                        'Metas de Ahorro',
                        style: AppTypography.bodySmall(
                          color: AppColors.textTertiary(isDark),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ─── Total Saved Card ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFF2D6A4F)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusXl),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.xs),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.15),
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.trending_up_rounded,
                                  color: AppColors.secondary, size: 16),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                'TOTAL AHORRADO',
                                style: AppTypography.labelSmall(
                                    color: Colors.white70),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: AppSpacing.sm,
                                    vertical: AppSpacing.xxs),
                                decoration: BoxDecoration(
                                  color: AppColors.secondary
                                      .withOpacity(0.25),
                                  borderRadius: BorderRadius.circular(
                                      AppSpacing.radiusFull),
                                ),
                                child: Text(
                                  '+${MockData.savedPercentChange}%',
                                  style: AppTypography.labelSmall(
                                      color: AppColors.secondary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      CurrencyFormatter.format(MockData.totalSaved),
                      style:
                          AppTypography.displayMedium(color: Colors.white),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      '+ ${CurrencyFormatter.format(MockData.savedThisMonth)} acumulados este mes',
                      style:
                          AppTypography.bodySmall(color: AppColors.secondary),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.add_rounded, size: 20),
                        label: const Text('Nueva Meta de Ahorro'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.secondary,
                          foregroundColor: AppColors.primary,
                          padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                                AppSpacing.radiusMd),
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

          // ─── Filter Tabs ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.xs),
                decoration: BoxDecoration(
                  color: AppColors.surfaceVariant(isDark),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Row(
                  children: [
                    _FilterTab(
                      label: 'Todas (${MockData.savingsGoals.length})',
                      isSelected: _selectedFilter == 0,
                      onTap: () => setState(() => _selectedFilter = 0),
                      isDark: isDark,
                    ),
                    _FilterTab(
                      label:
                          'En progreso (${MockData.savingsGoals.where((g) => !g.isCompleted).length})',
                      isSelected: _selectedFilter == 1,
                      onTap: () => setState(() => _selectedFilter = 1),
                      isDark: isDark,
                    ),
                    _FilterTab(
                      label:
                          'Completadas (${MockData.savingsGoals.where((g) => g.isCompleted).length})',
                      isSelected: _selectedFilter == 2,
                      onTap: () => setState(() => _selectedFilter = 2),
                      isDark: isDark,
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // ─── Section Title ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'TUS OBJETIVOS ACTIVOS',
                    style: AppTypography.labelMedium(
                      color: AppColors.textTertiary(isDark),
                    ),
                  ),
                  Text(
                    'Ver análisis',
                    style: AppTypography.labelMedium(
                      color: AppColors.secondary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.md)),

          // ─── Goals List ───
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final goal = _filteredGoals[index];
                  return Padding(
                    padding:
                        const EdgeInsets.only(bottom: AppSpacing.md),
                    child: _GoalCard(goal: goal, isDark: isDark),
                  );
                },
                childCount: _filteredGoals.length,
              ),
            ),
          ),

          // ─── Smart Savings Rule ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.accent.withOpacity(0.1),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusLg),
                  border: Border.all(
                    color: AppColors.accent.withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.accent.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.auto_awesome_rounded,
                            color: AppColors.accent,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          'REGLA DE AHORRO INTELIGENTE',
                          style: AppTypography.labelMedium(
                            color: AppColors.textPrimary(isDark),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Redondeo inteligente activo: redondea tus compras diarias al euro más cercano y transfiere la diferencia a tus metas.',
                      style: AppTypography.bodySmall(
                        color: AppColors.textSecondary(isDark),
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

// ─── Filter Tab ───
class _FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _FilterTab({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? AppColors.surface(isDark)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.06),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTypography.labelSmall(
              color: isSelected
                  ? AppColors.textPrimary(isDark)
                  : AppColors.textTertiary(isDark),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Goal Card ───
class _GoalCard extends StatelessWidget {
  final SavingsGoal goal;
  final bool isDark;

  const _GoalCard({required this.goal, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final progressColor =
        goal.isCompleted ? AppColors.success : AppColors.secondary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: goal.isCompleted
              ? AppColors.success.withOpacity(0.4)
              : AppColors.cardBorder(isDark),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: progressColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: Icon(goal.icon, color: progressColor, size: 20),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      goal.title,
                      style: AppTypography.titleSmall(
                        color: AppColors.textPrimary(isDark),
                      ),
                    ),
                    Text(
                      goal.subtitle,
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                decoration: BoxDecoration(
                  color: progressColor.withOpacity(0.15),
                  borderRadius:
                      BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  '${goal.progressPercentInt}%',
                  style: AppTypography.labelMedium(color: progressColor),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: goal.progressPercent,
              backgroundColor: AppColors.surfaceVariant(isDark),
              valueColor: AlwaysStoppedAnimation<Color>(progressColor),
              minHeight: 8,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${CurrencyFormatter.format(goal.currentAmount)} / ${CurrencyFormatter.format(goal.targetAmount)}',
                style: AppTypography.bodySmall(
                  color: AppColors.textSecondary(isDark),
                ),
              ),
              if (!goal.isCompleted)
                Text(
                  'Faltan ${CurrencyFormatter.format(goal.remainingAmount)}',
                  style:
                      AppTypography.labelSmall(color: AppColors.accent),
                ),
              if (goal.isCompleted)
                Row(
                  children: [
                    const Icon(Icons.check_circle_rounded,
                        color: AppColors.success, size: 14),
                    const SizedBox(width: AppSpacing.xs),
                    Text(
                      'Meta alcanzada',
                      style: AppTypography.labelSmall(
                          color: AppColors.success),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }
}
