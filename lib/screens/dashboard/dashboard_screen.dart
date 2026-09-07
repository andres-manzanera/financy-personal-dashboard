import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/transaction_model.dart';
import '../../providers/theme_provider.dart';
import '../../providers/navigation_provider.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final themeProvider = context.read<ThemeProvider>();

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
                            'Dashboard',
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
                      // Only show theme toggle on mobile (desktop/tablet have it in sidebar)
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return IconButton(
                            onPressed: themeProvider.toggleTheme,
                            icon: Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: AppColors.textSecondary(isDark),
                              size: 22,
                            ),
                          );
                        },
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor: AppColors.secondary,
                        child: Text(
                          'AM',
                          style: AppTypography.labelMedium(
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ─── Greeting ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Bienvenido de nuevo ✨',
                    style: AppTypography.bodySmall(
                      color: AppColors.textTertiary(isDark),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xxs),
                  Text(
                    'Hola, ${MockData.userName} 👋',
                    style: AppTypography.headlineMedium(
                      color: AppColors.textPrimary(isDark),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Balance Card ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: _BalanceCard(isDark: isDark),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Income / Expense Summary ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  Expanded(
                    child: _SummaryChip(
                      label: 'Ingreso Mes',
                      amount: MockData.monthlyIncome,
                      isPositive: true,
                      isDark: isDark,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _SummaryChip(
                      label: 'Gastos Mes',
                      amount: -MockData.monthlyExpense,
                      isPositive: false,
                      isDark: isDark,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Quick Actions ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Acciones Rápidas',
                        style: AppTypography.titleMedium(
                          color: AppColors.textPrimary(isDark),
                        ),
                      ),
                      Text(
                        'Frecuentes',
                        style: AppTypography.bodySmall(
                          color: AppColors.textTertiary(isDark),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _QuickAction(
                        icon: Icons.add_rounded,
                        label: 'Ingreso',
                        color: AppColors.success,
                        isDark: isDark,
                        onTap: () {},
                      ),
                      _QuickAction(
                        icon: Icons.arrow_upward_rounded,
                        label: 'Gasto',
                        color: AppColors.error,
                        isDark: isDark,
                        onTap: () {},
                      ),
                      _QuickAction(
                        icon: Icons.receipt_long_rounded,
                        label: 'Facturas',
                        color: AppColors.accent,
                        isDark: isDark,
                        onTap: () {},
                      ),
                      _QuickAction(
                        icon: Icons.savings_rounded,
                        label: 'Ahorrar',
                        color: AppColors.secondary,
                        isDark: isDark,
                        onTap: () {
                          context.read<NavigationProvider>().setIndex(2);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Savings Goals Preview ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            'Mis Metas de Ahorro',
                            style: AppTypography.titleMedium(
                              color: AppColors.textPrimary(isDark),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: AppSpacing.sm,
                                vertical: AppSpacing.xxs),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.2),
                              borderRadius:
                                  BorderRadius.circular(AppSpacing.radiusFull),
                            ),
                            child: Text(
                              '2 activas',
                              style: AppTypography.labelSmall(
                                color: AppColors.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          context.read<NavigationProvider>().setIndex(2);
                        },
                        child: Text(
                          'Ver todas',
                          style: AppTypography.labelMedium(
                            color: AppColors.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 100,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _SavingsPreviewCard(
                          icon: Icons.laptop_mac_rounded,
                          title: 'Mi PC Gamer',
                          progress:
                              '520 € / 1.100 €',
                          percent: 47,
                          isDark: isDark,
                        ),
                        const SizedBox(width: AppSpacing.md),
                        _SavingsPreviewCard(
                          icon: Icons.build_rounded,
                          title: 'Reparación Coche',
                          progress:
                              '100 € / 2.320 €',
                          percent: 4,
                          isDark: isDark,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Recent Movements ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Últimos Movimientos',
                    style: AppTypography.titleMedium(
                      color: AppColors.textPrimary(isDark),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<NavigationProvider>().setIndex(1);
                    },
                    child: Text(
                      'Ver todos',
                      style: AppTypography.labelMedium(
                        color: AppColors.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.sm)),

          // Movement list
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index >= 4) return null;
                  final tx = MockData.transactions[index];
                  return _MovementRow(transaction: tx, isDark: isDark);
                },
                childCount: 4,
              ),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: AppSpacing.lg)),

          // ─── Savings Tip ───
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
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
                        Icons.eco_rounded,
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
                            'Ritmo de Ahorro Saludable',
                            style: AppTypography.titleSmall(
                              color: AppColors.textPrimary(isDark),
                            ),
                          ),
                          Text(
                            'Has ahorrado un 18% más que el mes pasado.',
                            style: AppTypography.bodySmall(
                              color: AppColors.textSecondary(isDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right_rounded,
                      color: AppColors.textTertiary(isDark),
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

// ─── Balance Card (green dark card with VISA) ───
class _BalanceCard extends StatelessWidget {
  final bool isDark;
  const _BalanceCard({required this.isDark});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.primary, Color(0xFF2D6A4F)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.35),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  'SALDO DISPONIBLE',
                  style: AppTypography.labelSmall(color: Colors.white70),
                ),
              ),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.2),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      '17/24',
                      style: AppTypography.labelSmall(
                          color: AppColors.accent),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            CurrencyFormatter.format(MockData.totalBalance),
            style: AppTypography.displayMedium(color: Colors.white),
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.xs),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Text(
                    MockData.cardNumber,
                    style: AppTypography.amountSmall(
                        color: Colors.white70),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'TITULAR',
                    style:
                        AppTypography.labelSmall(color: Colors.white54),
                  ),
                  Text(
                    MockData.cardHolder,
                    style: AppTypography.labelLarge(color: Colors.white),
                  ),
                ],
              ),
              Text(
                'VISA',
                style: AppTypography.headlineSmall(
                  color: Colors.white,
                ).copyWith(
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Summary Chip (Income / Expense) ───
class _SummaryChip extends StatelessWidget {
  final String label;
  final double amount;
  final bool isPositive;
  final bool isDark;

  const _SummaryChip({
    required this.label,
    required this.amount,
    required this.isPositive,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isPositive ? AppColors.success : AppColors.error;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.cardBorder(isDark)),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isPositive
                  ? Icons.arrow_downward_rounded
                  : Icons.arrow_upward_rounded,
              color: color,
              size: 16,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.labelSmall(
                    color: AppColors.textTertiary(isDark),
                  ),
                ),
                Text(
                  CurrencyFormatter.formatWithSign(amount),
                  style: AppTypography.amountTiny(color: color),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Quick Action Button ───
class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.cardBorder(isDark)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.labelSmall(
              color: AppColors.textSecondary(isDark),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Savings Preview Card ───
class _SavingsPreviewCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String progress;
  final int percent;
  final bool isDark;

  const _SavingsPreviewCard({
    required this.icon,
    required this.title,
    required this.progress,
    required this.percent,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface(isDark),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.cardBorder(isDark)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(icon,
                      color: AppColors.textSecondary(isDark), size: 18),
                  const SizedBox(width: AppSpacing.sm),
                  Flexible(
                    child: Text(
                      title,
                      style: AppTypography.titleSmall(
                        color: AppColors.textPrimary(isDark),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                decoration: BoxDecoration(
                  color: AppColors.secondary.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  '$percent%',
                  style: AppTypography.labelSmall(color: AppColors.secondary),
                ),
              ),
            ],
          ),
          Text(
            progress,
            style: AppTypography.bodySmall(
              color: AppColors.textTertiary(isDark),
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: percent / 100,
              backgroundColor: AppColors.surfaceVariant(isDark),
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.secondary),
              minHeight: 6,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Movement Row ───
class _MovementRow extends StatelessWidget {
  final Transaction transaction;
  final bool isDark;

  const _MovementRow({required this.transaction, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final isPositive = transaction.amount >= 0;
    final amountColor = isPositive
        ? (isDark ? AppColors.successLight : AppColors.success)
        : (isDark ? AppColors.errorLight : AppColors.error);

    String statusLabel;
    Color statusColor;
    switch (transaction.status) {
      case TransactionStatus.completed:
        statusLabel = 'Completado';
        statusColor = AppColors.success;
        break;
      case TransactionStatus.pending:
        statusLabel = 'Pendiente';
        statusColor = AppColors.accent;
        break;
      case TransactionStatus.paid:
        statusLabel = 'Pagado';
        statusColor = AppColors.warning;
        break;
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface(isDark),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          border: Border.all(color: AppColors.cardBorder(isDark)),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: transaction.iconColor.withOpacity(0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(
                transaction.icon,
                color: transaction.iconColor,
                size: 20,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.title,
                    style: AppTypography.titleSmall(
                      color: AppColors.textPrimary(isDark),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    transaction.subtitle,
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
                  CurrencyFormatter.formatWithSign(transaction.amount),
                  style: AppTypography.amountTiny(color: amountColor),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm, vertical: AppSpacing.xxs),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.12),
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(
                    statusLabel,
                    style: AppTypography.labelSmall(color: statusColor),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
