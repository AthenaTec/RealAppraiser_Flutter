import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart' as permission;
import 'package:real_appraiser/common_utilis/colors.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({super.key});

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  GoogleMapController? _mapController;
  LocationData? _currentLocation;
  Location _locationService = Location();
  TextEditingController _latController = TextEditingController();
  TextEditingController _lngController = TextEditingController();
  Marker? _currentLocationMarker;

  List<File> _images = []; // List to hold captured images
  final ImagePicker _picker = ImagePicker(); // Image picker instance

  @override
  void initState() {
    _checkLocationPermission();
    super.initState();
  }

  Future<void> _checkLocationPermission() async {
    // Request location permission
    permission.PermissionStatus status =
        await permission.Permission.location.request();

    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      // Handle permission denied scenario
      if (status.isPermanentlyDenied) {
        permission.openAppSettings(); // Open app settings to enable permission
      } else {
        _checkLocationPermission(); // Request permission again
      }
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      _currentLocation = await _locationService.getLocation();
      _updateMapLocation();
    } catch (e) {
      print("Error fetching location: $e");
    }
  }

  void _updateMapLocation() {
    if (_currentLocation != null) {
      setState(() {
        _latController.text = _currentLocation!.latitude.toString();
        _lngController.text = _currentLocation!.longitude.toString();
        _currentLocationMarker = Marker(
          markerId: MarkerId('currentLocation'),
          position:
              LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
          icon: BitmapDescriptor.defaultMarkerWithHue(
              BitmapDescriptor.hueRed), // Red color marker
        );

        _mapController?.animateCamera(CameraUpdate.newLatLngZoom(
            LatLng(_currentLocation!.latitude!, _currentLocation!.longitude!),
            14.0));
      });
    }
  }

  // Function to capture image from camera with permission handling
  Future<void> _pickImageFromCamera() async {
    if (await _requestPermission(permission.Permission.camera)) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    } else {
      print("Camera permission denied.");
    }
  }

  Future<void> _pickImageFromGallery() async {
    // Request permission for accessing photos or media.
    permission.PermissionStatus permissionStatus =
        await permission.Permission.storage.request();

    if (permissionStatus.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _images.add(File(image.path));
        });
      }
    } else if (permissionStatus.isDenied) {
      print("Gallery permission denied.");
    } else if (permissionStatus.isPermanentlyDenied) {
      // Show an alert asking user to manually enable the permission from settings.
      permission.openAppSettings();
    }
  }

  // Function to request permission
  Future<bool> _requestPermission(
      permission.Permission requestedPermission) async {
    final status = await requestedPermission.request();
    return status.isGranted;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 0,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Editable text field for latitude and longitude
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _latController,
                        decoration: InputDecoration(
                          labelText: 'Latitude',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 10),
                      TextField(
                        controller: _lngController,
                        decoration: InputDecoration(
                          labelText: 'Longitude',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Google Map view
              Container(
                alignment: Alignment.topRight,
                width: 160,
                height: 160,
                child: GoogleMap(
                  onMapCreated: (controller) => _mapController = controller,
                  markers: _currentLocationMarker != null
                      ? {_currentLocationMarker!}
                      : {},
                  initialCameraPosition: CameraPosition(
                    target: _currentLocation != null
                        ? LatLng(_currentLocation!.latitude!,
                            _currentLocation!.longitude!)
                        : LatLng(0.0, 0.0),
                    // Default location (latitude and longitude)
                    zoom: 14.0,
                  ),
                  myLocationEnabled: false,
                ),
              ),
            ],
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: RAColors.colorM,
                      borderRadius: BorderRadius.circular(28)),
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "   Add Image   ",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: "AldrichRegular",
                          color: RAColors.white),
                    ),
                  )),
              // Divider(
              //   color: RAColors.colorM,
              //   thickness: 2,
              // )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _pickImageFromCamera,
                child: Text('Camera'),
              ),
              ElevatedButton(
                onPressed: _pickImageFromGallery,
                child: Text('Gallery'),
              ),
            ],
          ),
        ),
        // Display images in a grid view
        Expanded(
          flex: 1,
          child: GridView.builder(
            padding: EdgeInsets.all(8.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // Number of columns in the grid
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: _images.length,
            itemBuilder: (context, index) {
              return Image.file(_images[index], fit: BoxFit.cover);
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _latController.dispose();
    _lngController.dispose();
    super.dispose();
  }
}
