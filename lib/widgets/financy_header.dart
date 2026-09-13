import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/theme_provider.dart';

class FinancyHeader extends StatelessWidget {
  final String subtitle;

  const FinancyHeader({super.key, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.background(isDark),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left side
          Row(
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
                    ).copyWith(fontWeight: FontWeight.w800, height: 1.1),
                  ),
                  Text(
                    subtitle,
                    style: AppTypography.bodySmall(
                      color: AppColors.textTertiary(isDark),
                    ).copyWith(fontWeight: FontWeight.w600, height: 1.1),
                  ),
                ],
              ),
            ],
          ),
          // Right side
          Row(
            children: [
              // Theme toggle
              GestureDetector(
                onTap: themeProvider.toggleTheme,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark 
                        ? AppColors.surfaceVariant(true) 
                        : const Color(0xFFF6ECC9), // Light yellow for moon
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isDark ? Icons.light_mode_rounded : Icons.dark_mode_outlined,
                    color: isDark ? AppColors.textSecondary(true) : Colors.black87,
                    size: 20,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              // Profile with online dot
              Stack(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundColor: AppColors.secondary,
                    child: Text(
                      'AM',
                      style: AppTypography.labelMedium(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: AppColors.success,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.background(isDark),
                          width: 2,
                        ),
                      ),
                    ),
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
