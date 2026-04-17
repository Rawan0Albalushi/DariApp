import 'package:dari/core/theme/app_colors.dart';
import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:dari/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class PropertyDetailsPage extends StatelessWidget {
  const PropertyDetailsPage({required this.property, super.key});

  final FeaturedPropertyData property;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            backgroundColor: AppColors.primaryDark,
            foregroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsetsDirectional.only(
                start: 16,
                bottom: 16,
                end: 16,
              ),
              title: null,
              background: _PropertyImageCarousel(
                baseGradient: property.imageGradient,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final bool isDesktop = constraints.maxWidth >= 1000;
                final bool isTablet = constraints.maxWidth >= 600 && !isDesktop;
                final double contentMaxWidth = isDesktop
                    ? 900
                    : (isTablet ? 760 : constraints.maxWidth);
                final EdgeInsets contentPadding = EdgeInsets.symmetric(
                  horizontal: isDesktop ? 24 : (isTablet ? 20 : 16),
                  vertical: 20,
                );

                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: contentMaxWidth),
                    child: Padding(
                      padding: contentPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            property.title,
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                color: AppColors.textSecondary.withValues(
                                  alpha: 0.9,
                                ),
                                size: 18,
                              ),
                              const SizedBox(width: 6),
                              Expanded(
                                child: Text(
                                  property.subtitle,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          Wrap(
                            spacing: 8,
                            runSpacing: 8,
                            children: [
                              _InfoChip(
                                icon: Icons.king_bed_outlined,
                                label: '${property.bedrooms} ${l10n.beds}',
                              ),
                              _InfoChip(
                                icon: Icons.bathtub_outlined,
                                label: '${property.bathrooms} ${l10n.baths}',
                              ),
                              _InfoChip(
                                icon: Icons.straighten_rounded,
                                label: l10n.propertyAreaValue,
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),
                          _InfoCard(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        l10n.priceStartingFrom,
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodyMedium,
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        property.priceLabel,
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall
                                            ?.copyWith(
                                              color: AppColors.primaryDark,
                                              fontWeight: FontWeight.w900,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.call_outlined,
                                    size: 18,
                                  ),
                                  label: Text(l10n.contactAgent),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InfoCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.propertyOverviewTitle,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  l10n.propertyOverviewText,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 14),
                          _InfoCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  l10n.featuresLabel,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 8),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      _AmenityChip(
                                        icon: Icons.pool_outlined,
                                        label: l10n.amenityPool,
                                      ),
                                      const SizedBox(width: 8),
                                      _AmenityChip(
                                        icon: Icons.local_parking_outlined,
                                        label: l10n.amenityParking,
                                      ),
                                      const SizedBox(width: 8),
                                      _AmenityChip(
                                        icon: Icons.fitness_center_outlined,
                                        label: l10n.amenityGym,
                                      ),
                                      const SizedBox(width: 8),
                                      _AmenityChip(
                                        icon: Icons.security_outlined,
                                        label: l10n.amenitySecurity,
                                      ),
                                    ],
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
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 10, 16, 16),
        child: SizedBox(
          height: 56,
          child: ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.event_available_outlined),
            label: Text(
              l10n.bookVisit,
              maxLines: 1,
              overflow: TextOverflow.visible,
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.textSecondary.withValues(alpha: 0.14),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 12,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Padding(padding: const EdgeInsets.all(14), child: child),
    );
  }
}

class _InfoChip extends StatelessWidget {
  const _InfoChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.primaryDark.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 6, 12, 6),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primaryDark),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppColors.primaryDark,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmenityChip extends StatelessWidget {
  const _AmenityChip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFF5F7FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(10, 8, 12, 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: AppColors.primaryDark),
            const SizedBox(width: 6),
            Text(
              label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: const Color(0xFF2A3A4E),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PropertyImageCarousel extends StatefulWidget {
  const _PropertyImageCarousel({required this.baseGradient});

  final List<Color> baseGradient;

  @override
  State<_PropertyImageCarousel> createState() => _PropertyImageCarouselState();
}

class _PropertyImageCarouselState extends State<_PropertyImageCarousel> {
  late final PageController _pageController;
  int _activeIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 1);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  List<List<Color>> get _galleryGradients {
    final List<Color> base = widget.baseGradient;
    final Color first = base.first;
    final Color second = base.last;
    return <List<Color>>[
      <Color>[first, second],
      <Color>[
        Color.lerp(first, Colors.black, 0.18) ?? first,
        Color.lerp(second, Colors.white, 0.1) ?? second,
      ],
      <Color>[
        Color.lerp(first, Colors.white, 0.12) ?? first,
        Color.lerp(second, Colors.black, 0.2) ?? second,
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final List<List<Color>> slides = _galleryGradients;

    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _pageController,
          itemCount: slides.length,
          onPageChanged: (int value) {
            setState(() => _activeIndex = value);
          },
          itemBuilder: (BuildContext context, int index) {
            return DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: slides[index],
                ),
              ),
              child: const Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.apartment_rounded,
                  size: 76,
                  color: Colors.white70,
                ),
              ),
            );
          },
        ),
        IgnorePointer(
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0x22000000), Color(0xB3000000)],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 20,
          left: 0,
          right: 0,
          child: IgnorePointer(
            child: Center(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List<Widget>.generate(slides.length, (int index) {
                  final bool isActive = index == _activeIndex;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 220),
                    margin: const EdgeInsetsDirectional.only(end: 6),
                    height: 6,
                    width: isActive ? 18 : 6,
                    decoration: BoxDecoration(
                      color: isActive
                          ? Colors.white
                          : Colors.white.withValues(alpha: 0.45),
                      borderRadius: BorderRadius.circular(999),
                    ),
                  );
                }),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
