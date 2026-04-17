import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:dari/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Demo catalog until Laravel API + pagination are wired.
List<FeaturedPropertyData> buildPropertyCatalog(AppLocalizations l10n) {
  const List<List<Color>> gradients = <List<Color>>[
    <Color>[Color(0xFF5D89B3), Color(0xFF1E3A5F)],
    <Color>[Color(0xFFB68C60), Color(0xFF6B4E2E)],
    <Color>[Color(0xFF8DA3B8), Color(0xFF3F5A74)],
    <Color>[Color(0xFF6B8E7D), Color(0xFF2F4A3C)],
    <Color>[Color(0xFF9B7EBD), Color(0xFF4A3568)],
    <Color>[Color(0xFF7EB8DA), Color(0xFF2E5A7A)],
  ];

  FeaturedPropertyData row({
    required String title,
    required String subtitle,
    required String priceLabel,
    required String badgeLabel,
    required String bedrooms,
    required String bathrooms,
    required int gradientIndex,
  }) {
    return FeaturedPropertyData(
      title: title,
      subtitle: subtitle,
      priceLabel: priceLabel,
      badgeLabel: badgeLabel,
      bedrooms: bedrooms,
      bathrooms: bathrooms,
      imageGradient: gradients[gradientIndex % gradients.length],
    );
  }

  return <FeaturedPropertyData>[
    row(
      title: l10n.propertyNameLuxuryApartment,
      subtitle: l10n.districtAlMouj,
      priceLabel: 'OMR 350',
      badgeLabel: l10n.forRent,
      bedrooms: '2',
      bathrooms: '2',
      gradientIndex: 0,
    ),
    row(
      title: l10n.propertyNameModernVilla,
      subtitle: l10n.districtAlMouj,
      priceLabel: 'OMR 250',
      badgeLabel: l10n.forSale,
      bedrooms: '3',
      bathrooms: '1',
      gradientIndex: 1,
    ),
    row(
      title: l10n.propertyNameFamilyHouse,
      subtitle: l10n.districtAlKhuwair,
      priceLabel: 'OMR 420',
      badgeLabel: l10n.forSale,
      bedrooms: '4',
      bathrooms: '3',
      gradientIndex: 2,
    ),
    row(
      title: l10n.propertyNameLuxuryApartment,
      subtitle: l10n.districtQurum,
      priceLabel: 'OMR 310',
      badgeLabel: l10n.forRent,
      bedrooms: '3',
      bathrooms: '2',
      gradientIndex: 3,
    ),
    row(
      title: l10n.propertyNameModernVilla,
      subtitle: l10n.districtBausher,
      priceLabel: 'OMR 580',
      badgeLabel: l10n.forSale,
      bedrooms: '5',
      bathrooms: '4',
      gradientIndex: 4,
    ),
    row(
      title: l10n.propertyNameFamilyHouse,
      subtitle: l10n.districtAlMouj,
      priceLabel: 'OMR 195',
      badgeLabel: l10n.forRent,
      bedrooms: '2',
      bathrooms: '2',
      gradientIndex: 5,
    ),
    row(
      title: l10n.propertyNameModernVilla,
      subtitle: l10n.districtAlKhuwair,
      priceLabel: 'OMR 265',
      badgeLabel: l10n.forSale,
      bedrooms: '3',
      bathrooms: '2',
      gradientIndex: 0,
    ),
    row(
      title: l10n.propertyNameLuxuryApartment,
      subtitle: l10n.districtAlKhuwair,
      priceLabel: 'OMR 390',
      badgeLabel: l10n.forRent,
      bedrooms: '2',
      bathrooms: '1',
      gradientIndex: 1,
    ),
    row(
      title: l10n.propertyNameFamilyHouse,
      subtitle: l10n.districtQurum,
      priceLabel: 'OMR 445',
      badgeLabel: l10n.forSale,
      bedrooms: '4',
      bathrooms: '2',
      gradientIndex: 2,
    ),
    row(
      title: l10n.propertyNameLuxuryApartment,
      subtitle: l10n.districtBausher,
      priceLabel: 'OMR 220',
      badgeLabel: l10n.forRent,
      bedrooms: '1',
      bathrooms: '1',
      gradientIndex: 3,
    ),
    row(
      title: l10n.propertyNameFamilyHouse,
      subtitle: l10n.districtAlMouj,
      priceLabel: 'OMR 510',
      badgeLabel: l10n.forSale,
      bedrooms: '4',
      bathrooms: '4',
      gradientIndex: 4,
    ),
    row(
      title: l10n.propertyNameModernVilla,
      subtitle: l10n.districtQurum,
      priceLabel: 'OMR 335',
      badgeLabel: l10n.forRent,
      bedrooms: '3',
      bathrooms: '3',
      gradientIndex: 5,
    ),
  ];
}
