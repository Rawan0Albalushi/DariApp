import 'package:flutter_riverpod/legacy.dart';

enum PropertyListingFilter { all, forSale, forRent }

final propertyListingFilterProvider =
    StateProvider.autoDispose<PropertyListingFilter>(
  (ref) => PropertyListingFilter.all,
);
