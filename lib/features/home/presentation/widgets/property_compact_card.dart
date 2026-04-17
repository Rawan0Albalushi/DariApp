import 'package:dari/core/theme/app_colors.dart';
import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:flutter/material.dart';

/// List / grid tile aligned with [FeaturedPropertiesList] card styling.
class PropertyCompactCard extends StatelessWidget {
  const PropertyCompactCard({
    required this.property,
    required this.bedsLabel,
    required this.bathsLabel,
    this.onTap,
    super.key,
  });

  final FeaturedPropertyData property;
  final String bedsLabel;
  final String bathsLabel;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.textSecondary.withValues(alpha: 0.12),
            ),
            boxShadow: const <BoxShadow>[
              BoxShadow(
                color: Color(0x16000000),
                blurRadius: 14,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: SizedBox(
            height: 124,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                ClipRRect(
                  borderRadius: const BorderRadiusDirectional.horizontal(
                    start: Radius.circular(16),
                  ),
                  child: SizedBox(
                    width: 112,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: property.imageGradient,
                        ),
                      ),
                      child: Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          const Align(
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.apartment_rounded,
                              color: Colors.white70,
                              size: 40,
                            ),
                          ),
                          PositionedDirectional(
                            top: 8,
                            start: 8,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
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
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                      10,
                      10,
                      10,
                      10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          property.title,
                          style: Theme.of(context).textTheme.titleSmall
                              ?.copyWith(fontWeight: FontWeight.w800),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.location_on_outlined,
                              size: 15,
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.95,
                              ),
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
                        const Spacer(),
                        Row(
                          children: <Widget>[
                            Icon(
                              Icons.local_offer_outlined,
                              size: 17,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              property.priceLabel,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(fontWeight: FontWeight.w800),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Wrap(
                          spacing: 6,
                          runSpacing: 4,
                          children: <Widget>[
                            _MiniChip(
                              icon: Icons.king_bed_outlined,
                              label: '${property.bedrooms} $bedsLabel',
                            ),
                            _MiniChip(
                              icon: Icons.bathtub_outlined,
                              label: '${property.bathrooms} $bathsLabel',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MiniChip extends StatelessWidget {
  const _MiniChip({required this.icon, required this.label});

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
        padding: const EdgeInsetsDirectional.fromSTEB(7, 4, 9, 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, size: 14, color: AppColors.primaryDark),
            const SizedBox(width: 4),
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
