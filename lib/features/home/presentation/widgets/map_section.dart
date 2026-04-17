import 'package:dari/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class MapSection extends StatefulWidget {
  const MapSection({
    required this.title,
    required this.scanButtonLabel,
    super.key,
  });

  final String title;
  final String scanButtonLabel;

  static final LatLng _defaultCenter = LatLng(23.588, 58.3829);
  static const double _defaultZoom = 12.5;
  static final List<LatLng> _propertyLocations = <LatLng>[
    LatLng(23.6020, 58.3815),
    LatLng(23.5871, 58.4102),
    LatLng(23.5744, 58.3668),
  ];

  @override
  State<MapSection> createState() => _MapSectionState();
}

class _MapSectionState extends State<MapSection> {
  LatLng? _userLocation;

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  Future<void> _loadUserLocation() async {
    final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final Position position = await Geolocator.getCurrentPosition();
    if (!mounted) {
      return;
    }
    setState(() {
      _userLocation = LatLng(position.latitude, position.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: SizedBox(
                height: 170,
                width: double.infinity,
                child: FlutterMap(
                  options: MapOptions(
                    initialCenter: _userLocation ?? MapSection._defaultCenter,
                    initialZoom: MapSection._defaultZoom,
                  ),
                  children: [
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.example.dari',
                    ),
                    MarkerLayer(
                      markers:
                          MapSection._propertyLocations
                              .map(
                                (LatLng point) => Marker(
                                  point: point,
                                  width: 30,
                                  height: 30,
                                  child: Icon(
                                    Icons.location_on_rounded,
                                    color: AppColors.primaryAccent,
                                    size: 26,
                                  ),
                                ),
                              )
                              .toList()
                            ..addAll(<Marker>[
                              if (_userLocation != null)
                                Marker(
                                  point: _userLocation!,
                                  width: 34,
                                  height: 34,
                                  child: const Icon(
                                    Icons.my_location_rounded,
                                    color: Color(0xFF1E88E5),
                                    size: 28,
                                  ),
                                ),
                            ]),
                    ),
                  ],
                ),
              ),
            ),
            PositionedDirectional(
              end: 12,
              bottom: 12,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF163355),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 7,
                  ),
                  minimumSize: const Size(0, 32),
                  textStyle: Theme.of(context).textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                onPressed: () {},
                icon: const Icon(Icons.qr_code_2_rounded, size: 15),
                label: Text(widget.scanButtonLabel),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
