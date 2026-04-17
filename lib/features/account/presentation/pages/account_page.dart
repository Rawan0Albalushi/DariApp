import 'package:dari/app.dart';
import 'package:dari/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  static const double _mobileBreakpoint = 600;
  static const double _desktopBreakpoint = 1000;
  static const double _mobilePadding = 16;
  static const double _tabletPadding = 24;
  static const double _desktopPadding = 32;
  static const double _sectionSpacing = 20;
  static const double _itemSpacing = 12;
  static const double _heroRadius = 22;
  static const double _profileRadius = 34;
  static const double _profileCardRadius = 20;
  static const double _profileNameSize = 20;
  static const double _menuTileRadius = 16;
  static const double _menuTileIconSize = 22;
  static const int _savedPropertiesCount = 12;
  static const int _activeRequestsCount = 3;
  static const int _appointmentsCount = 5;

  String? _displayName;
  String? _email;
  bool _notificationsEnabled = true;
  bool _biometricEnabled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    _displayName = _displayNameOrFallback(_displayName, l10n.accountUserName);
    _email = _displayNameOrFallback(_email, l10n.accountUserEmail);
  }

  String _displayNameOrFallback(String? currentValue, String fallback) {
    if (currentValue == null || currentValue.trim().isEmpty) {
      return fallback;
    }
    return currentValue;
  }

  void _showActionMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _openEditProfileDialog(AppLocalizations l10n) async {
    final TextEditingController nameController = TextEditingController(
      text: _displayName,
    );
    final TextEditingController emailController = TextEditingController(
      text: _email,
    );

    final bool? saved = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.accountEditProfile),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: l10n.accountNameFieldLabel,
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: l10n.accountEmailFieldLabel,
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(l10n.accountCancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(l10n.accountSave),
            ),
          ],
        );
      },
    );

    if (saved == true) {
      setState(() {
        _displayName = nameController.text.trim().isEmpty
            ? _displayName
            : nameController.text.trim();
        _email = emailController.text.trim().isEmpty
            ? _email
            : emailController.text.trim();
      });
      _showActionMessage(l10n.accountProfileUpdated);
    }
  }

  Future<void> _openLanguageSheet(AppLocalizations l10n) async {
    final Locale currentLocale = Localizations.localeOf(context);
    final Locale? selectedLocale = await showModalBottomSheet<Locale>(
      context: context,
      showDragHandle: true,
      builder: (BuildContext context) {
        final TextTheme textTheme = Theme.of(context).textTheme;
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(l10n.accountLanguage, style: textTheme.titleLarge),
                const SizedBox(height: 10),
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n.accountLanguageArabic),
                  trailing: currentLocale.languageCode == 'ar'
                      ? const Icon(Icons.check_rounded)
                      : null,
                  onTap: () => Navigator.of(context).pop(const Locale('ar')),
                ),
                ListTile(
                  leading: const Icon(Icons.language_rounded),
                  title: Text(l10n.accountLanguageEnglish),
                  trailing: currentLocale.languageCode == 'en'
                      ? const Icon(Icons.check_rounded)
                      : null,
                  onTap: () => Navigator.of(context).pop(const Locale('en')),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );

    if (!mounted) {
      return;
    }

    if (selectedLocale != null) {
      DariApp.setLocale(context, selectedLocale);
      final String selectedLabel = selectedLocale.languageCode == 'ar'
          ? l10n.accountLanguageArabic
          : l10n.accountLanguageEnglish;
      _showActionMessage('${l10n.accountLanguageChanged}: $selectedLabel');
    }
  }

  void _confirmLogout(AppLocalizations l10n) {
    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.accountLogout),
          content: Text(l10n.accountLogoutConfirmMessage),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(l10n.accountCancel),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _showActionMessage(l10n.accountLogoutDone);
              },
              child: Text(l10n.accountLogout),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final AppLocalizations l10n = AppLocalizations.of(context)!;
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final bool isDesktop = constraints.maxWidth >= _desktopBreakpoint;
        final bool isTablet =
            constraints.maxWidth >= _mobileBreakpoint && !isDesktop;

        final double horizontalPadding = isDesktop
            ? _desktopPadding
            : isTablet
            ? _tabletPadding
            : _mobilePadding;

        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _AccountHero(
                appName: l10n.appName,
                title: l10n.bottomAccount,
                cardRadius: _heroRadius,
                onMenuPressed: () => _showActionMessage(l10n.accountMoreOpened),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                  horizontalPadding,
                  _mobilePadding,
                  horizontalPadding,
                  _mobilePadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    _ProfileCard(
                      name: _displayName!,
                      email: _email!,
                      actionLabel: l10n.accountEditProfile,
                      avatarRadius: _profileRadius,
                      cardRadius: _profileCardRadius,
                      nameSize: _profileNameSize,
                      onEditPressed: () => _openEditProfileDialog(l10n),
                    ),
                    const SizedBox(height: _sectionSpacing),
                    Text(
                      l10n.accountOverview,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: _itemSpacing),
                    _StatsSection(
                      savedPropertiesLabel: l10n.accountSavedProperties,
                      activeRequestsLabel: l10n.accountActiveRequests,
                      appointmentsLabel: l10n.accountAppointments,
                      savedPropertiesCount: _savedPropertiesCount,
                      activeRequestsCount: _activeRequestsCount,
                      appointmentsCount: _appointmentsCount,
                      isDesktop: isDesktop,
                    ),
                    const SizedBox(height: _sectionSpacing),
                    Text(
                      l10n.accountSettings,
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: _itemSpacing),
                    _SettingsMenu(
                      tileRadius: _menuTileRadius,
                      iconSize: _menuTileIconSize,
                      items: <_MenuItemData>[
                        _MenuItemData(
                          icon: Icons.person_outline_rounded,
                          title: l10n.accountPersonalInformation,
                          onTap: () => _openEditProfileDialog(l10n),
                        ),
                        _MenuItemData(
                          icon: Icons.notifications_none_rounded,
                          title: l10n.accountNotifications,
                          trailing: Switch.adaptive(
                            value: _notificationsEnabled,
                            onChanged: (bool value) {
                              setState(() => _notificationsEnabled = value);
                              _showActionMessage(
                                value
                                    ? l10n.accountNotificationsEnabled
                                    : l10n.accountNotificationsDisabled,
                              );
                            },
                          ),
                        ),
                        _MenuItemData(
                          icon: Icons.fingerprint_rounded,
                          title: l10n.accountBiometricLogin,
                          trailing: Switch.adaptive(
                            value: _biometricEnabled,
                            onChanged: (bool value) {
                              setState(() => _biometricEnabled = value);
                              _showActionMessage(
                                value
                                    ? l10n.accountBiometricEnabled
                                    : l10n.accountBiometricDisabled,
                              );
                            },
                          ),
                        ),
                        _MenuItemData(
                          icon: Icons.language_rounded,
                          title: l10n.accountLanguage,
                          onTap: () => _openLanguageSheet(l10n),
                        ),
                        _MenuItemData(
                          icon: Icons.credit_card_outlined,
                          title: l10n.accountPaymentMethods,
                          onTap: () =>
                              _showActionMessage(l10n.accountPaymentOpened),
                        ),
                        _MenuItemData(
                          icon: Icons.help_outline_rounded,
                          title: l10n.accountHelpSupport,
                          onTap: () =>
                              _showActionMessage(l10n.accountSupportOpened),
                        ),
                        _MenuItemData(
                          icon: Icons.logout_rounded,
                          title: l10n.accountLogout,
                          iconColor: colorScheme.error,
                          titleColor: colorScheme.error,
                          onTap: () => _confirmLogout(l10n),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProfileCard extends StatelessWidget {
  const _ProfileCard({
    required this.name,
    required this.email,
    required this.actionLabel,
    required this.onEditPressed,
    required this.avatarRadius,
    required this.cardRadius,
    required this.nameSize,
  });

  final String name;
  final String email;
  final String actionLabel;
  final VoidCallback onEditPressed;
  final double avatarRadius;
  final double cardRadius;
  final double nameSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colorScheme.primaryContainer.withValues(alpha: 0.72),
            colorScheme.surface,
          ],
        ),
        borderRadius: BorderRadius.circular(cardRadius),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.6),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.08),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: colorScheme.primary.withValues(alpha: 0.35),
                    width: 1.5,
                  ),
                ),
                child: CircleAvatar(
                  radius: avatarRadius,
                  backgroundColor: colorScheme.primary.withValues(alpha: 0.12),
                  child: Icon(
                    Icons.person_rounded,
                    size: 36,
                    color: colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      name,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                        fontSize: nameSize,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton.filledTonal(
                onPressed: onEditPressed,
                icon: const Icon(Icons.edit_outlined),
              ),
            ],
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onEditPressed,
              icon: const Icon(Icons.edit_note_rounded),
              label: Text(actionLabel),
            ),
          ),
        ],
      ),
    );
  }
}

class _AccountHero extends StatelessWidget {
  const _AccountHero({
    required this.appName,
    required this.title,
    required this.cardRadius,
    required this.onMenuPressed,
  });

  final String appName;
  final String title;
  final double cardRadius;
  final VoidCallback onMenuPressed;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(cardRadius),
        ),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: <Color>[Color(0xFF0E2240), Color(0xFF163355)],
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(18, 16, 18, 18),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      appName,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: theme.textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: onMenuPressed,
                visualDensity: VisualDensity.compact,
                icon: const Icon(Icons.more_vert_rounded, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatsSection extends StatelessWidget {
  const _StatsSection({
    required this.savedPropertiesLabel,
    required this.activeRequestsLabel,
    required this.appointmentsLabel,
    required this.savedPropertiesCount,
    required this.activeRequestsCount,
    required this.appointmentsCount,
    required this.isDesktop,
  });

  final String savedPropertiesLabel;
  final String activeRequestsLabel;
  final String appointmentsLabel;
  final int savedPropertiesCount;
  final int activeRequestsCount;
  final int appointmentsCount;
  final bool isDesktop;

  @override
  Widget build(BuildContext context) {
    final List<_StatData> stats = <_StatData>[
      _StatData(
        value: savedPropertiesCount.toString(),
        label: savedPropertiesLabel,
        icon: Icons.favorite_rounded,
      ),
      _StatData(
        value: activeRequestsCount.toString(),
        label: activeRequestsLabel,
        icon: Icons.bolt_rounded,
      ),
      _StatData(
        value: appointmentsCount.toString(),
        label: appointmentsLabel,
        icon: Icons.calendar_month_rounded,
      ),
    ];

    if (isDesktop) {
      return Row(
        children: stats
            .asMap()
            .entries
            .map(
              (MapEntry<int, _StatData> entry) => Expanded(
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    end: entry.key == stats.length - 1 ? 0 : 8,
                  ),
                  child: _StatCard(
                    value: entry.value.value,
                    label: entry.value.label,
                    icon: entry.value.icon,
                  ),
                ),
              ),
            )
            .toList(),
      );
    }

    return SizedBox(
      height: 74,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: stats.length,
        separatorBuilder: (BuildContext context, int index) =>
            const SizedBox(width: 8),
        itemBuilder: (BuildContext context, int index) {
          final _StatData stat = stats[index];
          return SizedBox(
            width: 170,
            child: _StatCard(
              value: stat.value,
              label: stat.label,
              icon: stat.icon,
            ),
          );
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: <Color>[
            colorScheme.primaryContainer.withValues(alpha: 0.24),
            colorScheme.surface,
          ],
        ),
        border: Border.all(
          color: colorScheme.outlineVariant.withValues(alpha: 0.65),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: colorScheme.primary),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  value,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: colorScheme.primary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsMenu extends StatelessWidget {
  const _SettingsMenu({
    required this.items,
    required this.tileRadius,
    required this.iconSize,
  });

  final List<_MenuItemData> items;
  final double tileRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items
          .map(
            (_MenuItemData item) => Padding(
              padding: const EdgeInsetsDirectional.only(bottom: 10),
              child: _SettingTile(
                icon: item.icon,
                title: item.title,
                iconColor: item.iconColor,
                titleColor: item.titleColor,
                onTap: item.onTap,
                trailing: item.trailing,
                tileRadius: tileRadius,
                iconSize: iconSize,
              ),
            ),
          )
          .toList(),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.onTap,
    required this.tileRadius,
    required this.iconSize,
    this.iconColor,
    this.titleColor,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Widget? trailing;
  final double tileRadius;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ColorScheme colorScheme = theme.colorScheme;
    final Color resolvedIconColor = iconColor ?? colorScheme.primary;
    final Color resolvedTitleColor = titleColor ?? colorScheme.onSurface;
    final bool hasTrailing = trailing != null;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(tileRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(tileRadius),
          color: colorScheme.surface,
          border: Border.all(color: colorScheme.outlineVariant),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: <Widget>[
            Icon(icon, color: resolvedIconColor, size: iconSize),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: resolvedTitleColor,
                ),
              ),
            ),
            if (hasTrailing)
              trailing!
            else
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: colorScheme.onSurfaceVariant,
              ),
          ],
        ),
      ),
    );
  }
}

class _MenuItemData {
  const _MenuItemData({
    required this.icon,
    required this.title,
    this.onTap,
    this.iconColor,
    this.titleColor,
    this.trailing,
  });

  final IconData icon;
  final String title;
  final VoidCallback? onTap;
  final Color? iconColor;
  final Color? titleColor;
  final Widget? trailing;
}

class _StatData {
  const _StatData({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;
}
