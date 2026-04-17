import 'package:dari/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FeaturedPropertyData {
  const FeaturedPropertyData({
    required this.title,
    required this.subtitle,
    required this.priceLabel,
    required this.badgeLabel,
    required this.bedrooms,
    required this.bathrooms,
    required this.imageGradient,
  });

  final String title;
  final String subtitle;
  final String priceLabel;
  final String badgeLabel;
  final String bedrooms;
  final String bathrooms;
  final List<Color> imageGradient;
}

class FeaturedPropertiesList extends StatelessWidget {
  const FeaturedPropertiesList({
    required this.properties,
    required this.bedsLabel,
    required this.bathsLabel,
    super.key,
  });

  final List<FeaturedPropertyData> properties;
  final String bedsLabel;
  final String bathsLabel;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 278,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: properties.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 12),
        itemBuilder: (BuildContext context, int index) {
          final FeaturedPropertyData property = properties[index];
          return SizedBox(
            width: 232,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.textSecondary.withValues(alpha: 0.12),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x16000000),
                    blurRadius: 14,
                    offset: Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Container(
                      height: 134,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: property.imageGradient,
                        ),
                      ),
                      child: Stack(
                        children: [
                          const Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(
                              Icons.apartment_rounded,
                              color: Colors.white,
                              size: 44,
                            ),
                          ),
                          PositionedDirectional(
                            top: 8,
                            start: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xCCB8F2C7),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                property.badgeLabel,
                                style: Theme.of(context).textTheme.labelSmall
                                    ?.copyWith(
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF145A32),
                                    ),
                              ),
                            ),
                          ),
                          PositionedDirectional(
                            top: 8,
                            end: 8,
                            child: DecoratedBox(
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.22),
                                shape: BoxShape.circle,
                              ),
                              child: const Padding(
                                padding: EdgeInsets.all(4),
                                child: Icon(
                                  Icons.favorite_border_rounded,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on_outlined,
                              size: 16,
                              color: AppColors.textSecondary.withValues(alpha: 0.95),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                property.subtitle,
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            Icon(
                              Icons.local_offer_outlined,
                              size: 18,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              property.priceLabel,
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _PropertyInfoChip(
                                icon: Icons.king_bed_outlined,
                                label: '${property.bedrooms} $bedsLabel',
                              ),
                              const SizedBox(width: 8),
                              _PropertyInfoChip(
                                icon: Icons.bathtub_outlined,
                                label: '${property.bathrooms} $bathsLabel',
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
          );
        },
      ),
    );
  }
}

class _PropertyInfoChip extends StatelessWidget {
  const _PropertyInfoChip({required this.icon, required this.label});

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
        padding: const EdgeInsetsDirectional.fromSTEB(8, 5, 10, 5),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 15,
              color: AppColors.primaryDark,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
