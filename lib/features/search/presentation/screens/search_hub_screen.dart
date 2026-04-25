import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_radius.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_search_field.dart';
import '../../../../core/widgets/app_surface_card.dart';
import '../widgets/search_hub_browse_card.dart';
import '../widgets/search_hub_result_section.dart';

class SearchHubScreen extends StatefulWidget {
  const SearchHubScreen({super.key});

  @override
  State<SearchHubScreen> createState() => _SearchHubScreenState();
}

class _SearchHubScreenState extends State<SearchHubScreen> {
  static const _categories = [
    'All',
    'Doctors',
    'Services',
    'Medicines',
    'Articles',
  ];

  static const _recentSearches = [
    'Cardiologist',
    'Amoxicillin',
    'Full body MCU',
    'Blood pressure article',
  ];

  static const _suggestions = [
    'Dermatologist',
    'Vitamin C',
    'Lab Results',
    'Heart Health',
  ];

  final _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  _SearchFilters _filters = const _SearchFilters();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        scrolledUnderElevation: 1,
        shadowColor: AppColors.surfaceContainerHighest,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: AppColors.primary),
        ),
        title: Text(
          'Search Hub',
          style: textTheme.titleLarge?.copyWith(color: AppColors.primary),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.md,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchField(),
            const SizedBox(height: AppSpacing.md),
            _buildCategoryChips(textTheme),
            if (_filters.hasActiveFilters) ...[
              const SizedBox(height: AppSpacing.sm),
              _buildActiveFilterChips(textTheme),
            ],
            const SizedBox(height: AppSpacing.lg),
            _buildSectionLabel(textTheme, 'RECENT SEARCHES'),
            const SizedBox(height: AppSpacing.xs),
            _buildRecentSearches(textTheme),
            const SizedBox(height: AppSpacing.lg),
            _buildSectionLabel(textTheme, 'BROWSE QUICKLY'),
            const SizedBox(height: AppSpacing.xs),
            _buildBrowseQuickly(),
            const SizedBox(height: AppSpacing.lg),
            _buildSectionLabel(textTheme, 'SEARCH RESULTS'),
            const SizedBox(height: AppSpacing.xs),
            _buildSearchResults(textTheme),
            const SizedBox(height: AppSpacing.lg),
            _buildSectionLabel(textTheme, 'SUGGESTED FOR YOU'),
            const SizedBox(height: AppSpacing.xs),
            _buildSuggestions(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(TextTheme textTheme, String text) {
    return Text(
      text,
      style: textTheme.labelSmall?.copyWith(
        color: AppColors.outline,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.6,
      ),
    );
  }

  Widget _buildSearchField() {
    final activeCount = _filters.activeCount;

    return AppSearchField(
      controller: _searchController,
      hintText: 'Search doctors, services, medicines...',
      height: 52,
      leadingIconSize: 22,
      trailing: _SearchFilterButton(
        activeCount: activeCount,
        onTap: _openFilterSheet,
      ),
    );
  }

  Widget _buildCategoryChips(TextTheme textTheme) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, index) {
          final isSelected = index == _selectedCategoryIndex;

          return ChoiceChip(
            label: Text(_categories[index]),
            selected: isSelected,
            onSelected: (_) {
              setState(() => _selectedCategoryIndex = index);
            },
            showCheckmark: false,
            labelStyle: textTheme.labelMedium?.copyWith(
              color: isSelected ? AppColors.onPrimary : AppColors.outline,
              fontWeight: FontWeight.w700,
            ),
            selectedColor: AppColors.primary,
            backgroundColor: AppColors.surface,
            side: BorderSide(
              color: isSelected ? AppColors.primary : AppColors.outlineVariant,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          );
        },
      ),
    );
  }

  Widget _buildActiveFilterChips(TextTheme textTheme) {
    final chips = <String>[
      ..._filters.types.map((type) => type.label),
      if (_filters.dateRange != _SearchDateRange.any) _filters.dateRange.label,
      if (_filters.popularity != _SearchPopularity.any)
        _filters.popularity.label,
    ];

    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: [
        ...chips.map((chip) {
          return DecoratedBox(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppRadius.pill),
              border: Border.all(color: AppColors.outlineVariant),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs - 1,
              ),
              child: Text(
                chip,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        }),
        TextButton(
          onPressed: () {
            setState(() => _filters = const _SearchFilters());
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
            minimumSize: const Size(0, 32),
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: const Text('Clear filters'),
        ),
      ],
    );
  }

  Widget _buildRecentSearches(TextTheme textTheme) {
    return AppSurfaceCard(
      padding: EdgeInsets.zero,
      radius: AppRadius.lg,
      child: Column(
        children: List.generate(_recentSearches.length, (index) {
          final item = _recentSearches[index];
          final isLast = index == _recentSearches.length - 1;

          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 34,
                  height: 34,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryFixed,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.history_rounded,
                    size: 18,
                    color: AppColors.primary,
                  ),
                ),
                title: Text(
                  item,
                  style: textTheme.titleMedium?.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                trailing: const Icon(
                  Icons.north_west_rounded,
                  color: AppColors.outline,
                  size: 18,
                ),
                onTap: () {
                  _searchController.text = item;
                  setState(() {});
                },
              ),
              if (!isLast)
                const Divider(
                  height: 0,
                  indent: 16,
                  endIndent: 16,
                  color: AppColors.surfaceContainerLow,
                ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildBrowseQuickly() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: AppSpacing.sm,
      crossAxisSpacing: AppSpacing.sm,
      childAspectRatio: 1.25,
      children: [
        SearchHubBrowseCard(
          icon: Icons.medical_services_outlined,
          title: 'Find Doctor',
          iconBackgroundColor: AppColors.primaryFixed,
          iconColor: AppColors.primary,
          onTap: _noop,
        ),
        SearchHubBrowseCard(
          icon: Icons.monitor_heart_outlined,
          title: 'Book MCU',
          iconBackgroundColor: AppColors.secondaryContainer,
          iconColor: AppColors.secondary,
          onTap: _noop,
        ),
        SearchHubBrowseCard(
          icon: Icons.medication_outlined,
          title: 'Order Medicine',
          iconBackgroundColor: AppColors.primaryFixed,
          iconColor: AppColors.primary,
          onTap: _noop,
        ),
        SearchHubBrowseCard(
          icon: Icons.folder_open_outlined,
          title: 'Medical Records',
          iconBackgroundColor: AppColors.surfaceContainerHigh,
          iconColor: AppColors.primaryDark,
          onTap: _noop,
        ),
      ],
    );
  }

  Widget _buildSearchResults(TextTheme textTheme) {
    final showDoctors =
        _filters.types.isEmpty || _filters.types.contains(_SearchType.doctors);
    final showServices =
        _filters.types.isEmpty || _filters.types.contains(_SearchType.services);
    final showPharmacy =
        _filters.types.isEmpty || _filters.types.contains(_SearchType.pharmacy);
    final showArticles =
        _filters.types.isEmpty || _filters.types.contains(_SearchType.articles);

    return Column(
      children: [
        if (showDoctors) ...[
          SearchHubResultSection(
            icon: Icons.person_outline_rounded,
            title: 'DOCTORS',
            iconColor: AppColors.primary,
            children: [
              _doctorRow(
                initials: 'ER',
                initialsBg: AppColors.primaryFixed,
                name: 'Dr. Elena Rodriguez',
                subtitle: 'Senior Cardiologist • ★ 4.9',
              ),
              const SizedBox(height: AppSpacing.sm),
              _doctorRow(
                initials: 'JS',
                initialsBg: AppColors.secondaryContainer,
                name: 'Dr. Julian Sterling',
                subtitle: 'Senior Cardiologist',
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (showServices) ...[
          SearchHubResultSection(
            icon: Icons.medical_services_outlined,
            title: 'SERVICES',
            iconColor: AppColors.secondary,
            children: const [
              _SearchHubLineItem(
                title: 'Cardiology Consultation',
                showTrailingChevron: true,
              ),
              SizedBox(height: AppSpacing.sm),
              _SearchHubLineItem(
                title: 'Comprehensive MCU Screening',
                showTrailingChevron: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (showPharmacy) ...[
          SearchHubResultSection(
            icon: Icons.medication_outlined,
            title: 'PHARMACY',
            iconColor: AppColors.tertiary,
            children: const [
              _SearchHubLineItem(
                title: 'Amoxicillin 500mg',
                leadingIcon: Icons.sell_outlined,
              ),
              SizedBox(height: AppSpacing.sm),
              _SearchHubLineItem(
                title: 'Lisinopril 10mg',
                leadingIcon: Icons.sell_outlined,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        if (showArticles)
          SearchHubResultSection(
            icon: Icons.article_outlined,
            title: 'ARTICLES',
            iconColor: AppColors.outline,
            children: const [
              _SearchHubArticleItem(title: 'Understanding Blood Pressure'),
              SizedBox(height: AppSpacing.sm),
              _SearchHubArticleItem(title: '5 Tips for Better Sleep'),
            ],
          ),
      ],
    );
  }

  Widget _buildSuggestions(TextTheme textTheme) {
    return Wrap(
      spacing: AppSpacing.xs,
      runSpacing: AppSpacing.xs,
      children: _suggestions.map((item) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs - 1,
            ),
            child: Text(
              item,
              style: textTheme.labelSmall?.copyWith(
                color: AppColors.onSurface,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _doctorRow({
    required String initials,
    required Color initialsBg,
    required String name,
    required String subtitle,
  }) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(color: initialsBg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: Text(
            initials,
            style: textTheme.labelMedium?.copyWith(
              color: AppColors.primaryDark,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: textTheme.labelMedium?.copyWith(
                  color: AppColors.onSurface,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                subtitle,
                style: textTheme.labelSmall?.copyWith(
                  color: AppColors.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _openFilterSheet() async {
    final result = await showModalBottomSheet<_SearchFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _SearchFilterSheet(initialFilters: _filters),
    );

    if (result != null) {
      setState(() => _filters = result);
    }
  }

  void _noop() {}
}

class _SearchFilterButton extends StatelessWidget {
  const _SearchFilterButton({required this.activeCount, required this.onTap});

  final int activeCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: activeCount > 0
                  ? AppColors.primaryFixed
                  : AppColors.surfaceContainerLow,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: AppColors.primary,
              size: 20,
            ),
          ),
          if (activeCount > 0)
            Positioned(
              right: -4,
              top: -4,
              child: Container(
                width: 18,
                height: 18,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: Text(
                  '$activeCount',
                  style: textTheme.labelSmall?.copyWith(
                    color: AppColors.onPrimary,
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _SearchHubLineItem extends StatelessWidget {
  const _SearchHubLineItem({
    required this.title,
    this.leadingIcon,
    this.showTrailingChevron = false,
  });

  final String title;
  final IconData? leadingIcon;
  final bool showTrailingChevron;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        if (leadingIcon != null) ...[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: AppColors.secondaryContainer.withValues(alpha: 0.28),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(leadingIcon, size: 18, color: AppColors.tertiary),
          ),
          const SizedBox(width: AppSpacing.sm),
        ],
        Expanded(
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(color: AppColors.onSurface),
          ),
        ),
        if (showTrailingChevron)
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.outline,
            size: 18,
          ),
      ],
    );
  }
}

class _SearchHubArticleItem extends StatelessWidget {
  const _SearchHubArticleItem({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: AppColors.primaryFixed.withValues(alpha: 0.6),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: textTheme.titleMedium?.copyWith(color: AppColors.onSurface),
          ),
        ),
      ],
    );
  }
}

enum _SearchType { doctors, services, pharmacy, articles }

extension _SearchTypeLabel on _SearchType {
  String get label {
    switch (this) {
      case _SearchType.doctors:
        return 'Doctors';
      case _SearchType.services:
        return 'Services';
      case _SearchType.pharmacy:
        return 'Pharmacy';
      case _SearchType.articles:
        return 'Articles';
    }
  }
}

enum _SearchDateRange { any, today, thisWeek, thisMonth }

extension _SearchDateRangeLabel on _SearchDateRange {
  String get label {
    switch (this) {
      case _SearchDateRange.any:
        return 'Any time';
      case _SearchDateRange.today:
        return 'Today';
      case _SearchDateRange.thisWeek:
        return 'This week';
      case _SearchDateRange.thisMonth:
        return 'This month';
    }
  }
}

enum _SearchPopularity { any, popular, trending, highestRated }

extension _SearchPopularityLabel on _SearchPopularity {
  String get label {
    switch (this) {
      case _SearchPopularity.any:
        return 'Any popularity';
      case _SearchPopularity.popular:
        return 'Popular';
      case _SearchPopularity.trending:
        return 'Trending';
      case _SearchPopularity.highestRated:
        return 'Highest rated';
    }
  }
}

class _SearchFilters {
  const _SearchFilters({
    this.types = const {},
    this.dateRange = _SearchDateRange.any,
    this.popularity = _SearchPopularity.any,
  });

  final Set<_SearchType> types;
  final _SearchDateRange dateRange;
  final _SearchPopularity popularity;

  bool get hasActiveFilters =>
      types.isNotEmpty ||
      dateRange != _SearchDateRange.any ||
      popularity != _SearchPopularity.any;

  int get activeCount {
    var count = 0;
    if (types.isNotEmpty) {
      count += types.length;
    }
    if (dateRange != _SearchDateRange.any) {
      count += 1;
    }
    if (popularity != _SearchPopularity.any) {
      count += 1;
    }
    return count;
  }
}

class _SearchFilterSheet extends StatefulWidget {
  const _SearchFilterSheet({required this.initialFilters});

  final _SearchFilters initialFilters;

  @override
  State<_SearchFilterSheet> createState() => _SearchFilterSheetState();
}

class _SearchFilterSheetState extends State<_SearchFilterSheet> {
  late Set<_SearchType> _selectedTypes;
  late _SearchDateRange _selectedDateRange;
  late _SearchPopularity _selectedPopularity;

  @override
  void initState() {
    super.initState();
    _selectedTypes = {...widget.initialFilters.types};
    _selectedDateRange = widget.initialFilters.dateRange;
    _selectedPopularity = widget.initialFilters.popularity;
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.outlineVariant,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  'Filter Search',
                  style: textTheme.titleLarge?.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Filter doctors, pharmacy, articles, date, and popularity.',
                  style: textTheme.bodyMedium,
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSectionTitle(textTheme, 'Category'),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _SearchType.values.map((type) {
                    final isSelected = _selectedTypes.contains(type);
                    return FilterChip(
                      label: Text(type.label),
                      selected: isSelected,
                      onSelected: (value) {
                        setState(() {
                          if (value) {
                            _selectedTypes.add(type);
                          } else {
                            _selectedTypes.remove(type);
                          }
                        });
                      },
                      showCheckmark: false,
                      selectedColor: AppColors.primaryFixed,
                      backgroundColor: AppColors.surface,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.outlineVariant,
                      ),
                      labelStyle: textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSectionTitle(textTheme, 'Date'),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: AppSpacing.xs,
                  runSpacing: AppSpacing.xs,
                  children: _SearchDateRange.values.map((dateRange) {
                    final isSelected = _selectedDateRange == dateRange;
                    return ChoiceChip(
                      label: Text(dateRange.label),
                      selected: isSelected,
                      onSelected: (_) {
                        setState(() => _selectedDateRange = dateRange);
                      },
                      showCheckmark: false,
                      selectedColor: AppColors.primaryFixed,
                      backgroundColor: AppColors.surface,
                      side: BorderSide(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.outlineVariant,
                      ),
                      labelStyle: textTheme.labelMedium?.copyWith(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.lg),
                _buildSectionTitle(textTheme, 'Popularity'),
                const SizedBox(height: AppSpacing.xs),
                ..._SearchPopularity.values.map((popularity) {
                  final isSelected = _selectedPopularity == popularity;

                  return InkWell(
                    onTap: () {
                      setState(() => _selectedPopularity = popularity);
                    },
                    borderRadius: BorderRadius.circular(AppRadius.md),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.xs - 2,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.outlineVariant,
                                width: 1.5,
                              ),
                            ),
                            child: isSelected
                                ? const Center(
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: AppColors.primary,
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            popularity.label,
                            style: textTheme.labelMedium?.copyWith(
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(
                      child: AppButton(
                        label: 'Reset',
                        onPressed: () {
                          setState(() {
                            _selectedTypes.clear();
                            _selectedDateRange = _SearchDateRange.any;
                            _selectedPopularity = _SearchPopularity.any;
                          });
                        },
                        variant: AppButtonVariant.outline,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: AppButton(
                        label: 'Apply',
                        onPressed: () {
                          Navigator.pop(
                            context,
                            _SearchFilters(
                              types: _selectedTypes,
                              dateRange: _selectedDateRange,
                              popularity: _selectedPopularity,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(TextTheme textTheme, String title) {
    return Text(
      title,
      style: textTheme.titleMedium?.copyWith(color: AppColors.onSurface),
    );
  }
}
