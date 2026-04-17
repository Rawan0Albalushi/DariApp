import 'package:flutter/material.dart';

class CategoryItemData {
  const CategoryItemData({
    required this.label,
    required this.icon,
    required this.gradientColors,
  });

  final String label;
  final IconData icon;
  final List<Color> gradientColors;
}

class CategoryIconsSection extends StatelessWidget {
  const CategoryIconsSection({required this.categories, super.key});

  final List<CategoryItemData> categories;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool compact = constraints.maxWidth < 420;
        return Flex(
          direction: Axis.horizontal,
          children: categories
              .map(
                (CategoryItemData item) => Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(14),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: compact ? 52 : 60,
                            height: compact ? 52 : 60,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: item.gradientColors,
                              ),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color(0x26000000),
                                  blurRadius: 8,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Icon(
                              item.icon,
                              color: Colors.white,
                              size: compact ? 22 : 26,
                            ),
                          ),
                          const SizedBox(height: 8),
                          SizedBox(
                            width: double.infinity,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.label,
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.bodyMedium
                                    ?.copyWith(
                                      fontSize: compact ? 13 : 14,
                                      fontWeight: FontWeight.w700,
                                      color: const Color(0xFF151515),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
