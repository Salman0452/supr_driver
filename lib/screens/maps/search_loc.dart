import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:supr_driver/app/app_theme.dart';

class SearchLocationScreen extends StatefulWidget {
  const SearchLocationScreen({Key? key}) : super(key: key);

  @override
  State<SearchLocationScreen> createState() => _SearchLocationScreenState();
}

class _SearchLocationScreenState extends State<SearchLocationScreen> {
  final MapController _mapController = MapController();
  final TextEditingController _searchController = TextEditingController();
  LatLng _currentPosition = LatLng(28.6139, 77.2090); // Default to Delhi
  bool _isLoading = true;
  String _zoneName = "South Delhi Zone";

  // Example location data for search demonstration
  final List<Map<String, dynamic>> _locations = [
    {
      'name': 'South Delhi Zone',
      'location': LatLng(28.5494, 77.2001),
      'address': 'South Delhi, Delhi, India'
    },
    {
      'name': 'North Delhi Zone',
      'location': LatLng(28.7041, 77.1025),
      'address': 'North Delhi, Delhi, India'
    },
    {
      'name': 'East Delhi Zone',
      'location': LatLng(28.6280, 77.2789),
      'address': 'East Delhi, Delhi, India'
    },
    {
      'name': 'West Delhi Zone',
      'location': LatLng(28.6492, 77.1025),
      'address': 'West Delhi, Delhi, India'
    },
    {
      'name': 'Central Delhi Zone',
      'location': LatLng(28.6330, 77.2190),
      'address': 'Central Delhi, Delhi, India'
    },
  ];

  List<Map<String, dynamic>> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _getCurrentLocation() async {
    try {
      // Check location permissions
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          // Permissions are denied, handle accordingly
          _setDefaultLocation();
          return;
        }
      }
      
      if (permission == LocationPermission.deniedForever) {
        // Permissions are permanently denied
        _setDefaultLocation();
        return;
      }

      // Get current position
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
      });
      
      // Find closest zone to current location
      _updateZoneFromLocation(_currentPosition);
    } catch (e) {
      _setDefaultLocation();
    }
  }

  void _setDefaultLocation() {
    setState(() {
      // Default to Delhi coordinates
      _currentPosition = LatLng(28.6139, 77.2090);
      _isLoading = false;
      _updateZoneFromLocation(_currentPosition);
    });
  }

  void _updateZoneFromLocation(LatLng location) {
    // Find the closest zone to the given location
    double minDistance = double.infinity;
    String closestZone = _zoneName;
    
    for (var zone in _locations) {
      final zoneLocation = zone['location'] as LatLng;
      final distance = _calculateDistance(location, zoneLocation);
      
      if (distance < minDistance) {
        minDistance = distance;
        closestZone = zone['name'];
      }
    }
    
    setState(() {
      _zoneName = closestZone;
    });
  }

  double _calculateDistance(LatLng point1, LatLng point2) {
    // Simple Euclidean distance calculation for demonstration
    // In a real app, you'd use Haversine formula or a geodesic calculation
    final dx = point1.latitude - point2.latitude;
    final dy = point1.longitude - point2.longitude;
    return dx * dx + dy * dy;
  }

  void _search(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
      });
      return;
    }
    
    setState(() {
      _searchResults = _locations
          .where((location) => location['name'].toLowerCase().contains(query.toLowerCase()) ||
                              location['address'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  void _selectLocation(Map<String, dynamic> location) {
    final LatLng position = location['location'];
    
    setState(() {
      _currentPosition = position;
      _zoneName = location['name'];
      _searchResults = [];
      _searchController.text = "";
    });
    
    _mapController.move(position, 15);
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isDarkMode ? AppColors.darkBackgroundColor : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.chevron_left,
            size: 30,
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Search location',
          style: TextStyle(
            color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
            fontFamily: 'Poppins',
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Stack(
              children: [
                // Full screen map
                FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    center: _currentPosition,
                    zoom: 15,
                    maxZoom: 18,
                    minZoom: 3,
                    interactiveFlags: InteractiveFlag.all,
                    onTap: (tapPosition, point) {
                      setState(() {
                        _currentPosition = point;
                      });
                      _updateZoneFromLocation(point);
                    },
                  ),
                  children: [
                    // Base map layer
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.supr_driver.app',
                      tileProvider: NetworkTileProvider(),
                    ),
                    
                    // Center marker
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: _currentPosition,
                          width: 40,
                          height: 40,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.PrimaryColor.withOpacity(0.3),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: Icon(
                                Icons.location_on,
                                color: AppColors.PrimaryColor,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                
                // Bottom sheet for search
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: screenHeight * 0.25,
                    decoration: BoxDecoration(
                      color: isDarkMode ? AppColors.darkBackgroundColor : Colors.white,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, -5),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Handle indicator
                          Center(
                            child: Container(
                              width: 40,
                              height: 4,
                              decoration: BoxDecoration(
                                color: isDarkMode ? Colors.grey[600] : Colors.grey[300],
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Zone name label
                          Text(
                            'Zone Name',
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Zone name value
                          Text(
                            _zoneName,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                            ),
                          ),
                          
                          const SizedBox(height: 16),
                          
                          // Search field
                          Container(
                            decoration: BoxDecoration(
                              color: isDarkMode ? Colors.grey[800] : Colors.grey[100],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: _search,
                              decoration: InputDecoration(
                                hintText: 'Search for locations',
                                hintStyle: TextStyle(
                                  color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: isDarkMode ? Colors.grey[400] : Colors.grey[500],
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(vertical: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                
                // Search results dropdown
                if (_searchResults.isNotEmpty)
                  Positioned(
                    bottom: screenHeight * 0.25,
                    left: 0,
                    right: 0,
                    child: Container(
                      constraints: BoxConstraints(
                        maxHeight: screenHeight * 0.3,
                      ),
                      decoration: BoxDecoration(
                        color: isDarkMode ? AppColors.darkBackgroundColor : Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, -5),
                          ),
                        ],
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final item = _searchResults[index];
                          return ListTile(
                            title: Text(
                              item['name'],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: isDarkMode ? AppColors.lightSecondaryColor : AppColors.SecondaryColor,
                              ),
                            ),
                            subtitle: Text(
                              item['address'],
                              style: TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 14,
                                color: isDarkMode ? Colors.grey[400] : Colors.grey[600],
                              ),
                            ),
                            onTap: () => _selectLocation(item),
                          );
                        },
                      ),
                    ),
                  ),
                  
                // My location button
                Positioned(
                  bottom: screenHeight * 0.26,
                  right: 16,
                  child: FloatingActionButton(
                    backgroundColor: AppColors.PrimaryColor,
                    mini: true,
                    onPressed: () async {
                      await _getCurrentLocation();
                      _mapController.move(_currentPosition, 15);
                    },
                    child: const Icon(
                      Icons.my_location,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}