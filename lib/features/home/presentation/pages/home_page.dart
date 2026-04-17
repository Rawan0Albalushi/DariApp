import 'package:dari/features/home/presentation/widgets/category_icons_section.dart';
import 'package:dari/features/home/presentation/widgets/custom_header.dart';
import 'package:dari/features/home/presentation/widgets/featured_properties_list.dart';
import 'package:dari/features/home/presentation/widgets/map_section.dart';
import 'package:dari/features/home/presentation/pages/all_properties_page.dart';
import 'package:dari/features/home/presentation/pages/property_details_page.dart';
import 'package:dari/features/home/presentation/widgets/section_title.dart';
import 'package:dari/features/account/presentation/pages/account_page.dart';
import 'package:flutter/material.dart';
import 'package:dari/l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedBottomIndex = 0;
  static const int _accountTabIndex = 4;

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;

    final List<CategoryItemData> categories = <CategoryItemData>[
      CategoryItemData(
        label: l10n.services,
        icon: Icons.handyman_rounded,
        gradientColors: const [Color(0xFF5F0F23), Color(0xFF8A2040)],
      ),
      CategoryItemData(
        label: l10n.investment,
        icon: Icons.query_stats_rounded,
        gradientColors: const [Color(0xFF26A69A), Color(0xFF4DB6AC)],
      ),
      CategoryItemData(
        label: l10n.rent,
        icon: Icons.vpn_key_rounded,
        gradientColors: const [Color(0xFF7E57C2), Color(0xFF9575CD)],
      ),
      CategoryItemData(
        label: l10n.buy,
        icon: Icons.house_rounded,
        gradientColors: const [Color(0xFF3A86FF), Color(0xFF5AA0FF)],
      ),
    ];

    final List<FeaturedPropertyData> properties = <FeaturedPropertyData>[
      FeaturedPropertyData(
        title: l10n.propertyNameLuxuryApartment,
        subtitle: 'Al Mouj, Muscat',
        priceLabel: 'OMR 350',
        badgeLabel: l10n.forRent,
        bedrooms: '2',
        bathrooms: '2',
        imageGradient: const [Color(0xFF5D89B3), Color(0xFF1E3A5F)],
      ),
      FeaturedPropertyData(
        title: l10n.propertyNameModernVilla,
        subtitle: 'Al Mouj, Muscat',
        priceLabel: 'OMR 250',
        badgeLabel: l10n.forSale,
        bedrooms: '3',
        bathrooms: '1',
        imageGradient: const [Color(0xFFB68C60), Color(0xFF6B4E2E)],
      ),
      FeaturedPropertyData(
        title: l10n.propertyNameFamilyHouse,
        subtitle: 'Al Khuwair, Muscat',
        priceLabel: 'OMR 420',
        badgeLabel: l10n.forSale,
        bedrooms: '4',
        bathrooms: '3',
        imageGradient: const [Color(0xFF8DA3B8), Color(0xFF3F5A74)],
      ),
    ];

    final bool isAccountSelected = _selectedBottomIndex == _accountTabIndex;

    return Scaffold(
      body: isAccountSelected
          ? const AccountPage()
          : LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                  final bool isDesktop = constraints.maxWidth >= 1000;
                  final bool isTablet =
                      constraints.maxWidth >= 600 && !isDesktop;

                  final EdgeInsets pagePadding = EdgeInsets.symmetric(
                    horizontal: isDesktop ? 28 : 16,
                    vertical: 16,
                  );

                  final Widget mainContent = Padding(
                    padding: pagePadding,
                    child: Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionTitle(title: l10n.categories),
                        const SizedBox(height: 12),
                        CategoryIconsSection(categories: categories),
                        const SizedBox(height: 20),
                        MapSection(
                          title: l10n.interactiveMapTitle,
                          scanButtonLabel: l10n.scanBuilding,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                              child: SectionTitle(
                                title: l10n.featuredPropertiesTitle,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(fontWeight: FontWeight.w800),
                              ),
                              onPressed: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<void>(
                                    builder: (BuildContext context) =>
                                        const AllPropertiesPage(),
                                  ),
                                );
                              },
                              child: Text(l10n.viewAllProperties),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        FeaturedPropertiesList(
                          properties: properties,
                          bedsLabel: l10n.beds,
                          bathsLabel: l10n.baths,
                          onPropertyTap: (FeaturedPropertyData property) {
                            Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    PropertyDetailsPage(property: property),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );

                  if (isDesktop) {
                    return Column(
                      children: [
                        CustomHeader(
                          searchHint: l10n.searchHint,
                          searchLabel: l10n.search,
                          propertyTypeLabel: l10n.propertyType,
                          appName: l10n.appName,
                        ),
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: SingleChildScrollView(
                                  child: mainContent,
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    top: 16,
                                    end: 28,
                                    start: 8,
                                  ),
                                  child: MapSection(
                                    title: l10n.interactiveMapTitle,
                                    scanButtonLabel: l10n.scanBuilding,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      CustomHeader(
                        searchHint: l10n.searchHint,
                        searchLabel: l10n.search,
                        propertyTypeLabel: l10n.propertyType,
                        appName: l10n.appName,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              bottom: isTablet ? 20 : 12,
                            ),
                            child: mainContent,
                          ),
                        ),
                      ),
                    ],
                  );
              },
            ),
      bottomNavigationBar: _HomeBottomNavigationBar(
        homeLabel: l10n.bottomHome,
        ordersLabel: l10n.bottomOrders,
        mapLabel: l10n.bottomMap,
        favoritesLabel: l10n.bottomFavorites,
        accountLabel: l10n.bottomAccount,
        selectedIndex: _selectedBottomIndex,
        onDestinationSelected: (int value) {
          setState(() => _selectedBottomIndex = value);
        },
      ),
    );
  }
}

class _HomeBottomNavigationBar extends StatelessWidget {
  const _HomeBottomNavigationBar({
    required this.homeLabel,
    required this.ordersLabel,
    required this.mapLabel,
    required this.favoritesLabel,
    required this.accountLabel,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  final String homeLabel;
  final String ordersLabel;
  final String mapLabel;
  final String favoritesLabel;
  final String accountLabel;
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;
    const Color selectedColor = Color(0xFF163355);

    return SafeArea(
      top: false,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colorScheme.surface,
          border: Border(
            top: BorderSide(color: selectedColor.withOpacity(0.08)),
          ),
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Color(0x14000000),
              blurRadius: 16,
              offset: Offset(0, -3),
            ),
          ],
        ),
        child: NavigationBarTheme(
          data: NavigationBarThemeData(
            height: 72,
            backgroundColor: Colors.transparent,
            elevation: 0,
            indicatorColor: selectedColor.withOpacity(0.14),
            iconTheme: WidgetStateProperty.resolveWith<IconThemeData>((
              Set<WidgetState> states,
            ) {
              final bool isSelected = states.contains(WidgetState.selected);
              return IconThemeData(
                color: isSelected
                    ? selectedColor
                    : colorScheme.onSurfaceVariant,
                size: isSelected ? 26 : 24,
              );
            }),
            labelTextStyle: WidgetStateProperty.resolveWith<TextStyle>((
              Set<WidgetState> states,
            ) {
              final bool isSelected = states.contains(WidgetState.selected);
              return Theme.of(context).textTheme.labelMedium!.copyWith(
                color: isSelected
                    ? selectedColor
                    : colorScheme.onSurfaceVariant,
                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
              );
            }),
          ),
          child: NavigationBar(
            selectedIndex: selectedIndex,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            onDestinationSelected: onDestinationSelected,
            destinations: <NavigationDestination>[
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home_rounded),
                label: homeLabel,
              ),
              NavigationDestination(
                icon: const Icon(Icons.inventory_2_outlined),
                selectedIcon: const Icon(Icons.inventory_2_rounded),
                label: ordersLabel,
              ),
              NavigationDestination(
                icon: const Icon(Icons.map_outlined),
                selectedIcon: const Icon(Icons.map_rounded),
                label: mapLabel,
              ),
              NavigationDestination(
                icon: const Icon(Icons.favorite_outline),
                selectedIcon: const Icon(Icons.favorite_rounded),
                label: favoritesLabel,
              ),
              NavigationDestination(
                icon: const Icon(Icons.person_outline_rounded),
                selectedIcon: const Icon(Icons.person_rounded),
                label: accountLabel,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
