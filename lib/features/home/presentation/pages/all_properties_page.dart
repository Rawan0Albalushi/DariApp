import 'dart:math' as math;

import 'package:dari/core/theme/app_colors.dart';
import 'package:dari/features/home/data/property_catalog_builder.dart';
import 'package:dari/features/home/presentation/pages/property_details_page.dart';
import 'package:dari/features/home/presentation/providers/property_listing_filter_provider.dart';
import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:dari/features/home/presentation/widgets/property_compact_card.dart';
import 'package:dari/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shimmer/shimmer.dart';

const double _kMobileBreakpoint = 600;
const double _kDesktopBreakpoint = 1000;
const int _kInitialVisibleCount = 8;
const int _kPageSize = 6;
const Duration _kInitialShimmerDelay = Duration(milliseconds: 420);

class AllPropertiesPage extends ConsumerStatefulWidget {
  const AllPropertiesPage({super.key});

  @override
  ConsumerState<AllPropertiesPage> createState() => _AllPropertiesPageState();
}

class _AllPropertiesPageState extends ConsumerState<AllPropertiesPage> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();

  AppLocalizations? _l10nBound;
  List<FeaturedPropertyData> _catalog = const <FeaturedPropertyData>[];
  bool _initialLoading = true;
  int _visibleCount = _kInitialVisibleCount;
  bool _loadingMore = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => _bootstrap());
  }

  Future<void> _bootstrap() async {
    await Future<void>.delayed(_kInitialShimmerDelay);
    if (!mounted) {
      return;
    }
    setState(() => _initialLoading = false);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (!_scrollController.hasClients || _initialLoading || _loadingMore) {
      return;
    }
    final ScrollPosition position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 320) {
      _loadMore();
    }
  }

  Future<void> _loadMore() async {
    if (_loadingMore) {
      return;
    }
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final PropertyListingFilter filter = ref.read(
      propertyListingFilterProvider,
    );
    final String query = _searchController.text.trim().toLowerCase();
    final List<FeaturedPropertyData> filtered = _computeFiltered(
      l10n,
      filter,
      query,
    );
    if (_visibleCount >= filtered.length) {
      return;
    }
    setState(() => _loadingMore = true);
    await Future<void>.delayed(const Duration(milliseconds: 320));
    if (!mounted) {
      return;
    }
    final List<FeaturedPropertyData> afterWait = _computeFiltered(
      AppLocalizations.of(context)!,
      ref.read(propertyListingFilterProvider),
      _searchController.text.trim().toLowerCase(),
    );
    setState(() {
      _visibleCount = math.min(
        _visibleCount + _kPageSize,
        afterWait.length,
      );
      _loadingMore = false;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    if (_l10nBound?.localeName != l10n.localeName) {
      _l10nBound = l10n;
      _catalog = buildPropertyCatalog(l10n);
      _applyFilterAndSearch(resetVisible: true);
    }
  }

  void _applyFilterAndSearch({required bool resetVisible}) {
    setState(() {
      if (resetVisible) {
        final AppLocalizations l10n = AppLocalizations.of(context)!;
        final PropertyListingFilter filter = ref.read(
          propertyListingFilterProvider,
        );
        final String query = _searchController.text.trim().toLowerCase();
        final List<FeaturedPropertyData> filtered = _computeFiltered(
          l10n,
          filter,
          query,
        );
        _visibleCount = math.min(_kInitialVisibleCount, filtered.length);
      }
    });
  }

  List<FeaturedPropertyData> _computeFiltered(
    AppLocalizations l10n,
    PropertyListingFilter filter,
    String queryLower,
  ) {
    Iterable<FeaturedPropertyData> items = _catalog;
    switch (filter) {
      case PropertyListingFilter.all:
        break;
      case PropertyListingFilter.forSale:
        items = items.where((FeaturedPropertyData p) => p.badgeLabel == l10n.forSale);
        break;
      case PropertyListingFilter.forRent:
        items = items.where((FeaturedPropertyData p) => p.badgeLabel == l10n.forRent);
        break;
    }
    if (queryLower.isNotEmpty) {
      items = items.where((FeaturedPropertyData p) {
        return p.title.toLowerCase().contains(queryLower) ||
            p.subtitle.toLowerCase().contains(queryLower);
      });
    }
    return items.toList(growable: false);
  }

  int _crossAxisCountForWidth(double width) {
    if (width >= _kDesktopBreakpoint) {
      return 3;
    }
    if (width >= _kMobileBreakpoint) {
      return 2;
    }
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final PropertyListingFilter filter = ref.watch(propertyListingFilterProvider);
    final String queryLower = _searchController.text.trim().toLowerCase();
    final List<FeaturedPropertyData> filtered = _computeFiltered(
      l10n,
      filter,
      queryLower,
    );
    final List<FeaturedPropertyData> visibleSlice = filtered.sublist(
      0,
      math.min(_visibleCount, filtered.length),
    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final double maxWidth = constraints.maxWidth;
          final int crossAxisCount = _crossAxisCountForWidth(maxWidth);
          final EdgeInsets pagePadding = EdgeInsets.symmetric(
            horizontal: maxWidth >= _kDesktopBreakpoint ? 28 : 16,
          );

          return CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                pinned: true,
                backgroundColor: AppColors.primaryDark,
                foregroundColor: Colors.white,
                title: Text(l10n.allPropertiesPageTitle),
              ),
              SliverPadding(
                padding: pagePadding.copyWith(top: 16, bottom: 12),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      TextField(
                        controller: _searchController,
                        onChanged: (_) => _applyFilterAndSearch(resetVisible: true),
                        decoration: InputDecoration(
                          hintText: l10n.allPropertiesSearchHint,
                          prefixIcon: const Icon(Icons.search_rounded),
                        ),
                      ),
                      const SizedBox(height: 12),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: <Widget>[
                            ChoiceChip(
                              label: Text(l10n.filterAllProperties),
                              selected: filter == PropertyListingFilter.all,
                              onSelected: (bool selected) {
                                if (!selected) {
                                  return;
                                }
                                ref
                                        .read(
                                          propertyListingFilterProvider
                                              .notifier,
                                        )
                                        .state =
                                    PropertyListingFilter.all;
                                _applyFilterAndSearch(resetVisible: true);
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: Text(l10n.forSale),
                              selected: filter == PropertyListingFilter.forSale,
                              onSelected: (bool selected) {
                                if (!selected) {
                                  return;
                                }
                                ref
                                        .read(
                                          propertyListingFilterProvider
                                              .notifier,
                                        )
                                        .state =
                                    PropertyListingFilter.forSale;
                                _applyFilterAndSearch(resetVisible: true);
                              },
                            ),
                            const SizedBox(width: 8),
                            ChoiceChip(
                              label: Text(l10n.forRent),
                              selected: filter == PropertyListingFilter.forRent,
                              onSelected: (bool selected) {
                                if (!selected) {
                                  return;
                                }
                                ref
                                        .read(
                                          propertyListingFilterProvider
                                              .notifier,
                                        )
                                        .state =
                                    PropertyListingFilter.forRent;
                                _applyFilterAndSearch(resetVisible: true);
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (_initialLoading)
                SliverPadding(
                  padding: pagePadding,
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 132,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return Shimmer.fromColors(
                          baseColor: AppColors.textSecondary.withValues(
                            alpha: 0.12,
                          ),
                          highlightColor: AppColors.textSecondary.withValues(
                            alpha: 0.04,
                          ),
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.textSecondary.withValues(
                                  alpha: 0.08,
                                ),
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsetsDirectional.fromSTEB(
                                12,
                                12,
                                12,
                                12,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    width: 96,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          height: 14,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Container(
                                          height: 12,
                                          width: 120,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        const Spacer(),
                                        Container(
                                          height: 14,
                                          width: 80,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: 6,
                    ),
                  ),
                )
              else if (filtered.isEmpty)
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        l10n.allPropertiesEmpty,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                )
              else
                SliverPadding(
                  padding: pagePadding.copyWith(bottom: 24),
                  sliver: SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      mainAxisExtent: 132,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final FeaturedPropertyData property = visibleSlice[index];
                        return PropertyCompactCard(
                          property: property,
                          bedsLabel: l10n.beds,
                          bathsLabel: l10n.baths,
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PropertyDetailsPage(property: property),
                              ),
                            );
                          },
                        );
                      },
                      childCount: visibleSlice.length,
                    ),
                  ),
                ),
              if (!_initialLoading && filtered.isNotEmpty && _loadingMore)
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: Center(
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
