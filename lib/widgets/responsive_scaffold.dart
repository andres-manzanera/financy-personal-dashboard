import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../core/theme/app_colors.dart';
import '../core/theme/app_spacing.dart';
import '../core/theme/app_typography.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';

class ResponsiveScaffold extends StatelessWidget {
  final List<Widget> screens;

  const ResponsiveScaffold({super.key, required this.screens});

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Inicio'),
    _NavItem(icon: Icons.swap_horiz_rounded, label: 'Movimientos'),
    _NavItem(icon: Icons.savings_rounded, label: 'Ahorro'),
    _NavItem(icon: Icons.bar_chart_rounded, label: 'Estadísticas'),
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= AppSpacing.desktopMin) {
          return _DesktopLayout(screens: screens);
        } else if (constraints.maxWidth >= AppSpacing.tabletMin) {
          return _TabletLayout(screens: screens);
        } else {
          return _MobileLayout(screens: screens);
        }
      },
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  const _NavItem({required this.icon, required this.label});
}

// ─── Mobile: Bottom Navigation Bar ───
class _MobileLayout extends StatelessWidget {
  final List<Widget> screens;
  const _MobileLayout({required this.screens});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: navProvider.currentIndex,
        children: screens,
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              borderRadius: BorderRadius.circular(AppSpacing.radiusXl),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm, vertical: AppSpacing.xs),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  ResponsiveScaffold._navItems.length,
                  (i) => _MobileNavItem(
                    item: ResponsiveScaffold._navItems[i],
                    isSelected: navProvider.currentIndex == i,
                    onTap: () => navProvider.setIndex(i),
                    isDark: isDark,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _MobileNavItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _MobileNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? (isDark ? AppColors.secondary : AppColors.primary)
        : AppColors.textTertiary(isDark);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(item.icon, color: color, size: 22),
            const SizedBox(height: AppSpacing.xxs),
            Text(
              item.label,
              style: AppTypography.labelSmall(color: color),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tablet: Navigation Rail ───
class _TabletLayout extends StatelessWidget {
  final List<Widget> screens;
  const _TabletLayout({required this.screens});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 80,
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              border: Border(
                right: BorderSide(
                  color: AppColors.cardBorder(isDark),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Logo
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
                      size: 22,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Nav items
                  ...List.generate(
                    ResponsiveScaffold._navItems.length,
                    (i) => _RailNavItem(
                      item: ResponsiveScaffold._navItems[i],
                      isSelected: navProvider.currentIndex == i,
                      onTap: () => navProvider.setIndex(i),
                      isDark: isDark,
                    ),
                  ),
                  const Spacer(),
                  // Theme toggle
                  IconButton(
                    onPressed: themeProvider.toggleTheme,
                    icon: Icon(
                      isDark
                          ? Icons.light_mode_rounded
                          : Icons.dark_mode_rounded,
                      color: AppColors.textSecondary(isDark),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: navProvider.currentIndex,
              children: screens,
            ),
          ),
        ],
      ),
    );
  }
}

class _RailNavItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _RailNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? (isDark ? AppColors.secondary : AppColors.primary)
        : AppColors.textTertiary(isDark);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          width: 60,
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    .withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(item.icon, color: color, size: 22),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                item.label,
                style: AppTypography.labelSmall(color: color),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Desktop: Fixed Sidebar ───
class _DesktopLayout extends StatelessWidget {
  final List<Widget> screens;
  const _DesktopLayout({required this.screens});

  @override
  Widget build(BuildContext context) {
    final navProvider = context.watch<NavigationProvider>();
    final themeProvider = context.watch<ThemeProvider>();
    final isDark = themeProvider.isDarkMode;

    return Scaffold(
      body: Row(
        children: [
          Container(
            width: 240,
            decoration: BoxDecoration(
              color: AppColors.surface(isDark),
              border: Border(
                right: BorderSide(
                  color: AppColors.cardBorder(isDark),
                  width: 1,
                ),
              ),
            ),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.lg),
                  // Logo + Brand
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
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
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Text(
                          'Financy',
                          style: AppTypography.headlineSmall(
                            color: AppColors.textPrimary(isDark),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    child: Text(
                      'Dashboard',
                      style: AppTypography.bodySmall(
                        color: AppColors.textTertiary(isDark),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Nav items
                  ...List.generate(
                    ResponsiveScaffold._navItems.length,
                    (i) => _SidebarNavItem(
                      item: ResponsiveScaffold._navItems[i],
                      isSelected: navProvider.currentIndex == i,
                      onTap: () => navProvider.setIndex(i),
                      isDark: isDark,
                    ),
                  ),
                  const Spacer(),
                  // Theme toggle
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                    child: InkWell(
                      onTap: themeProvider.toggleTheme,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                      child: Container(
                        padding: const EdgeInsets.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceVariant(isDark),
                          borderRadius:
                              BorderRadius.circular(AppSpacing.radiusMd),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              isDark
                                  ? Icons.light_mode_rounded
                                  : Icons.dark_mode_rounded,
                              color: AppColors.textSecondary(isDark),
                              size: 20,
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Text(
                              isDark ? 'Modo claro' : 'Modo oscuro',
                              style: AppTypography.titleSmall(
                                color: AppColors.textSecondary(isDark),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
          Expanded(
            child: IndexedStack(
              index: navProvider.currentIndex,
              children: screens,
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarNavItem extends StatelessWidget {
  final _NavItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDark;

  const _SidebarNavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? (isDark ? AppColors.secondary : AppColors.primary)
        : AppColors.textSecondary(isDark);

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md, vertical: AppSpacing.xxs),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        child: Container(
          padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md, vertical: AppSpacing.md),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? AppColors.primaryLight : AppColors.primary)
                    .withOpacity(0.1)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          child: Row(
            children: [
              Icon(item.icon, color: color, size: 22),
              const SizedBox(width: AppSpacing.md),
              Text(
                item.label,
                style: AppTypography.titleSmall(color: color),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
