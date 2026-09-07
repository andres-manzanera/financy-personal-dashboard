import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_spacing.dart';
import '../../core/theme/app_typography.dart';
import '../../core/utils/currency_formatter.dart';
import '../../core/utils/date_formatter.dart';
import '../../data/mock/mock_data.dart';
import '../../data/models/transaction_model.dart';
import '../../providers/theme_provider.dart';

class MovementsScreen extends StatefulWidget {
  const MovementsScreen({super.key});

  @override
  State<MovementsScreen> createState() => _MovementsScreenState();
}

class _MovementsScreenState extends State<MovementsScreen> {
  int _selectedTab = 0; // 0=Reporte, 1=Movimientos
  String _selectedFilter = 'Todos';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'Todos',
    'Gastos',
    'Ingresos',
    'Facturas',
    'Alimentación',
    'Servicios',
    'Ocio',
    'Salud',
  ];

  List<Transaction> get _filteredTransactions {
    var list = MockData.transactions;
    if (_selectedFilter == 'Gastos') {
      list = list.where((t) => t.type == TransactionType.expense).toList();
    } else if (_selectedFilter == 'Ingresos') {
      list = list.where((t) => t.type == TransactionType.income).toList();
    } else if (_selectedFilter == 'Facturas') {
      list = list.where((t) => t.type == TransactionType.bill).toList();
    } else if (_selectedFilter != 'Todos') {
      list = list.where((t) => t.category == _selectedFilter).toList();
    }
    if (_searchController.text.isNotEmpty) {
      final query = _searchController.text.toLowerCase();
      list = list
          .where((t) => t.title.toLowerCase().contains(query))
          .toList();
    }
    return list;
  }

  Map<String, List<Transaction>> get _groupedTransactions {
    final grouped = <String, List<Transaction>>{};
    for (final tx in _filteredTransactions) {
      final key = DateFormatter.formatRelativeDay(tx.date);
      grouped.putIfAbsent(key, () => []).add(tx);
    }
    return grouped;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final grouped = _groupedTransactions;

    return SafeArea(
      child: Column(
        children: [
          // ─── Header ───
          Padding(
            padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.sm),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
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
                      'Movimientos',
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ─── Tab Toggle ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.xs),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant(isDark),
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
                              ? AppColors.surface(isDark)
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                          boxShadow: _selectedTab == 0
                              ? [
                                  BoxShadow(
                                    color:
                                        Colors.black.withOpacity(0.06),
                                    blurRadius: 4,
                                  )
                                ]
                              : null,
                        ),
                        child: Text(
                          'Reporte',
                          textAlign: TextAlign.center,
                          style: AppTypography.titleSmall(
                            color: _selectedTab == 0
                                ? AppColors.textPrimary(isDark)
                                : AppColors.textTertiary(isDark),
                          ),
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
                              ? AppColors.primary
                              : Colors.transparent,
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          'Movimientos',
                          textAlign: TextAlign.center,
                          style: AppTypography.titleSmall(
                            color: _selectedTab == 1
                                ? Colors.white
                                : AppColors.textTertiary(isDark),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // ─── Search Bar ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: TextField(
              controller: _searchController,
              onChanged: (_) => setState(() {}),
              style: AppTypography.bodyMedium(
                  color: AppColors.textPrimary(isDark)),
              decoration: InputDecoration(
                hintText: 'Buscar por comercio, concepto...',
                hintStyle: AppTypography.bodyMedium(
                  color: AppColors.textTertiary(isDark),
                ),
                prefixIcon: Icon(
                  Icons.search_rounded,
                  color: AppColors.textTertiary(isDark),
                ),
                suffixIcon: Icon(
                  Icons.tune_rounded,
                  color: AppColors.textTertiary(isDark),
                ),
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // ─── Period Selector ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.calendar_today_rounded,
                        size: 16, color: AppColors.textSecondary(isDark)),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      'Este mes (Marzo 2024)',
                      style: AppTypography.titleSmall(
                        color: AppColors.textPrimary(isDark),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.xs),
                    Icon(Icons.keyboard_arrow_down_rounded,
                        size: 20, color: AppColors.textSecondary(isDark)),
                  ],
                ),
                Text(
                  '24 movimientos',
                  style: AppTypography.bodySmall(
                    color: AppColors.textTertiary(isDark),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // ─── Filter Chips ───
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: _filters.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, index) {
                final filter = _filters[index];
                final isSelected = _selectedFilter == filter;
                return GestureDetector(
                  onTap: () => setState(() => _selectedFilter = filter),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.surfaceVariant(isDark),
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(
                      filter,
                      style: AppTypography.labelMedium(
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary(isDark),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: AppSpacing.md),

          // ─── Total Spent Card ───
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant(isDark),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: AppColors.cardBorder(isDark)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL GASTADO ESTE MES',
                        style: AppTypography.labelSmall(
                          color: AppColors.textTertiary(isDark),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        CurrencyFormatter.format(MockData.monthlyExpense),
                        style: AppTypography.amountLarge(
                          color: AppColors.textPrimary(isDark),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.sm,
                            vertical: AppSpacing.xxs),
                        decoration: BoxDecoration(
                          color: AppColors.error.withOpacity(0.12),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusFull),
                        ),
                        child: Text(
                          '+4,3% vs feb',
                          style:
                              AppTypography.labelSmall(color: AppColors.error),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(
                        'Límite: 2.000 €',
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

          const SizedBox(height: AppSpacing.md),

          // ─── Grouped Transactions List ───
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              itemCount: grouped.length,
              itemBuilder: (context, groupIndex) {
                final entry = grouped.entries.elementAt(groupIndex);
                final dayLabel = entry.key;
                final txList = entry.value;
                final dayTotal = txList.fold<double>(
                    0, (sum, tx) => sum + tx.amount);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: AppSpacing.sm),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            dayLabel,
                            style: AppTypography.titleSmall(
                              color: AppColors.textPrimary(isDark),
                            ),
                          ),
                          Text(
                            CurrencyFormatter.formatWithSign(dayTotal),
                            style: AppTypography.amountTiny(
                              color: AppColors.textTertiary(isDark),
                            ),
                          ),
                        ],
                      ),
                    ),
                    ...txList.map((tx) => _TransactionRow(
                        transaction: tx, isDark: isDark)),
                    const SizedBox(height: AppSpacing.sm),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Transaction Row ───
class _TransactionRow extends StatelessWidget {
  final Transaction transaction;
  final bool isDark;

  const _TransactionRow({required this.transaction, required this.isDark});

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
