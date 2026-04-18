import 'dart:math' as math;

import 'package:dari/core/theme/app_colors.dart';
import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:flutter/material.dart';

const double _kCardRadius = 20;

/// Favorite: icon + padding; sits half on image, half on details.
const double _kFavoriteIconSize = 24;
const double _kFavoriteButtonPadding = 10;
const double _kFavoriteOuterSize =
    _kFavoriteIconSize + 2 * _kFavoriteButtonPadding;
const double _kFavoriteHalfExtent = _kFavoriteOuterSize / 2;

/// Minimum vertical space reserved for details block (title, price, location, amenities).
const double _kDetailsMinHeight = 242;

/// Property card: image (16:9), dots, favorite, then title, price, location, amenities.
class PropertyListingCard extends StatelessWidget {
  const PropertyListingCard({
    required this.property,
    required this.bedsLabel,
    required this.bathsLabel,
    required this.parkingLabel,
    required this.carouselActiveIndex,
    this.onTap,
    super.key,
  });

  final FeaturedPropertyData property;
  final String bedsLabel;
  final String bathsLabel;
  final String parkingLabel;

  /// Which carousel dot is highlighted (0–2).
  final int carouselActiveIndex;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final int dot = carouselActiveIndex.clamp(0, 2);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final double maxW = constraints.maxWidth;
        final double naturalImageH = maxW * 9 / 16;
        final bool hasTightHeight =
            constraints.maxHeight.isFinite && constraints.hasBoundedHeight;
        final double imageHeight = hasTightHeight
            ? math.min(
                naturalImageH,
                math.max(100, constraints.maxHeight - _kDetailsMinHeight),
              )
            : naturalImageH;

        return Material(
          color: Colors.transparent,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(_kCardRadius),
            side: BorderSide(
              color: AppColors.textSecondary.withValues(alpha: 0.08),
            ),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(_kCardRadius),
            splashColor: AppColors.primaryAccent.withValues(alpha: 0.08),
            highlightColor: AppColors.primaryAccent.withValues(alpha: 0.04),
            onTap: onTap,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(_kCardRadius),
                boxShadow: const <BoxShadow>[
                  BoxShadow(
                    color: Color(0x08000000),
                    blurRadius: 6,
                    offset: Offset(0, 2),
                  ),
                  BoxShadow(
                    color: Color(0x12000000),
                    blurRadius: 18,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(_kCardRadius),
                        ),
                        child: SizedBox(
                          height: imageHeight,
                          width: double.infinity,
                          child: Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              DecoratedBox(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.topCenter,
                                    end: Alignment.bottomCenter,
                                    colors: property.imageGradient,
                                  ),
                                ),
                              ),
                              Center(
                                child: Icon(
                                  Icons.apartment_rounded,
                                  color: Colors.white.withValues(alpha: 0.32),
                                  size: 46,
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 0,
                                height: 72,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      colors: <Color>[
                                        Colors.transparent,
                                        Colors.black.withValues(alpha: 0.38),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: 30,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List<Widget>.generate(3, (int i) {
                                    final bool active = i == dot;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 3,
                                      ),
                                      child: AnimatedContainer(
                                        duration: const Duration(
                                          milliseconds: 200,
                                        ),
                                        width: active ? 16 : 6,
                                        height: 6,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            999,
                                          ),
                                          color: active
                                              ? const Color(0xFFFFE082)
                                              : Colors.white.withValues(
                                                  alpha: 0.5,
                                                ),
                                          boxShadow: active
                                              ? const <BoxShadow>[
                                                  BoxShadow(
                                                    color: Color(0x66000000),
                                                    blurRadius: 4,
                                                    offset: Offset(0, 1),
                                                  ),
                                                ]
                                              : null,
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          14,
                          14 + _kFavoriteHalfExtent,
                          14,
                          14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              property.title,
                              style: textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                                color: AppColors.textPrimary,
                                height: 1.25,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.local_offer_outlined,
                                  size: 17,
                                  color: AppColors.textSecondary.withValues(
                                    alpha: 0.95,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    property.priceLabel,
                                    style: textTheme.titleLarge?.copyWith(
                                      fontWeight: FontWeight.w800,
                                      color: AppColors.textPrimary,
                                      letterSpacing: -0.3,
                                      height: 1.15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Expanded(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Icon(
                                        Icons.location_on_outlined,
                                        size: 17,
                                        color: AppColors.textSecondary
                                            .withValues(alpha: 0.95),
                                      ),
                                      const SizedBox(width: 4),
                                      Expanded(
                                        child: Text(
                                          property.subtitle,
                                          style: textTheme.bodySmall?.copyWith(
                                            color: AppColors.textSecondary,
                                            height: 1.25,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 8),
                                DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryDark.withValues(
                                      alpha: 0.05,
                                    ),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsetsDirectional.fromSTEB(
                                          8,
                                          5,
                                          8,
                                          5,
                                        ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Icon(
                                          Icons.straighten_rounded,
                                          size: 15,
                                          color: AppColors.textSecondary
                                              .withValues(alpha: 0.9),
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          property.areaLabel,
                                          style: textTheme.labelMedium
                                              ?.copyWith(
                                                color: AppColors.textSecondary,
                                                fontWeight: FontWeight.w700,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                color: AppColors.propertyCardAmenityAccent
                                    .withValues(alpha: 0.07),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: AppColors.propertyCardAmenityAccent
                                      .withValues(alpha: 0.12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 10,
                                  horizontal: 2,
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: _AmenityColumn(
                                        icon: Icons.king_bed_outlined,
                                        label:
                                            '${property.bedrooms} $bedsLabel',
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 28,
                                      color: AppColors.propertyCardAmenityAccent
                                          .withValues(alpha: 0.22),
                                    ),
                                    Expanded(
                                      child: _AmenityColumn(
                                        icon: Icons.bathtub_outlined,
                                        label:
                                            '${property.bathrooms} $bathsLabel',
                                      ),
                                    ),
                                    Container(
                                      width: 1,
                                      height: 28,
                                      color: AppColors.propertyCardAmenityAccent
                                          .withValues(alpha: 0.22),
                                    ),
                                    Expanded(
                                      child: _AmenityColumn(
                                        icon: Icons.directions_car_outlined,
                                        label:
                                            '${property.parking} $parkingLabel',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    top: imageHeight - _kFavoriteHalfExtent,
                    left: 0,
                    right: 0,
                    child: Center(
                      child: Material(
                        color: Colors.white,
                        shape: const CircleBorder(),
                        elevation: 3,
                        shadowColor: Colors.black.withValues(alpha: 0.2),
                        child: InkWell(
                          customBorder: const CircleBorder(),
                          onTap: () {},
                          child: Padding(
                            padding: const EdgeInsets.all(
                              _kFavoriteButtonPadding,
                            ),
                            child: Icon(
                              Icons.favorite_border_rounded,
                              size: _kFavoriteIconSize,
                              color: AppColors.textSecondary.withValues(
                                alpha: 0.85,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _AmenityColumn extends StatelessWidget {
  const _AmenityColumn({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final Color accent = AppColors.propertyCardAmenityAccent;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Icon(icon, size: 21, color: accent),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w700,
              color: accent,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
