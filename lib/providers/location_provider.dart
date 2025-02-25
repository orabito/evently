import 'dart:async';

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/event_model.dart';

class LocationProvider extends ChangeNotifier {
  //this is the first thing to can use package location
  // Instance of Location package to retrieve location data.
  Location location = Location();
  // Subscription for continuous location updates.
  StreamSubscription<LocationData>? _locationSubscription;

  //and i use the controller onMap created also  we init this in function changeLocationOnMap
  /// Controller for Google Maps to manage camera movements.
  late GoogleMapController mapController;

  // we init this in function changeLocationOnMap
  /// Default camera position when the map initializes.
  CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(29.964713, 31.256447),
    zoom: 17,
  );


  /// Set of markers to display on the map.
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("0"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };

  /// Retrieves the user's current location and updates the map view.
  /// Ensures location permissions are granted and services are enabled before proceeding.
  /// If successful, it updates the map marker and moves the camera to the new location.
  Future<void> getLocation() async {
    bool locationPermissionGranted = await getLocationPermission();
    if (!locationPermissionGranted) {
      notifyListeners();
      return;
    }

    var locationServiceEnabled = await locationServiceEnable();
    if (!locationServiceEnabled) {
      notifyListeners();
      return;
    }
    // Get the current location data
    LocationData locationData = await location.getLocation();

    /// Update the map with the new location
    changeLocationOnMap(locationData);

///Move the camera to the updated location
    mapController.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      ),
    );

    notifyListeners();
  }


//second function when i use location
  /// Ensures the location service is enabled on the device.
  Future<bool> locationServiceEnable() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
    }
    return locationServiceEnabled;
  }

//first function when i use location
  /// Requests permission to access the device's location.
  Future<bool> getLocationPermission() async {
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
    }
    return permissionGranted == PermissionStatus.granted;
  }

  // i use this function in onMapCreated
  /// Starts listening for location updates and updates the map accordingly.
  void setLocationListener() {
    location.changeSettings(accuracy: LocationAccuracy.balanced);
    _locationSubscription = location.onLocationChanged.listen((location) {
      changeLocationOnMap(location);
    });
  }

  //i use it in function setLocationListener that i use it in onMapCreated\
  //and i use the controller onMap created also
  /// Updates the map with the new user location and moves the camera.
  void changeLocationOnMap(LocationData locationData) {
    final newPosition = LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0);

    if (cameraPosition.target == newPosition) return;

    cameraPosition = CameraPosition(target: newPosition, zoom: 17);

    // Ensure the user's marker is updated when location changes
    markers = {
      Marker(
        markerId: MarkerId("user_location"),
        position: newPosition,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed), // Ensure the red marker
      ),
    };

    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }

  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  //i use ut  to fix the error
  /// Cancels the location updates subscription when no longer needed.
  void cancelLocationSubscription() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }
  /// Moves the map camera to a selected event location and marks it.
  void seeLocationOfEvent(LatLng location) {
    final newPosition = CameraPosition(
      target: location,
      zoom: 17,
    );

    markers = {
      Marker(
        markerId: const MarkerId("event_marker"),
        position: location,
      )
    };

    mapController.animateCamera(CameraUpdate.newCameraPosition(newPosition));
    notifyListeners();
  }

  /// Stores the event location when selected.
  LatLng? eventLocation;

  /// Clears the selected event location.
  clearLocation() {
    eventLocation = null;
    notifyListeners();
  }

  /// Updates the event location manually.
  void changeLocation(LatLng newEventLocation) {
    eventLocation = newEventLocation;
    notifyListeners();
  }
  /// Checks if an event location is set.
  bool eventLocationbolin() {
    if (eventLocation == null) {
      ChangeNotifier();
      return false;
    } else {
      ChangeNotifier();
      return true;
    }
  }
// Updates the event markers on the map based on a list of events.
  void updateMarkers(List<EventModel> events) {
    Set<Marker> newMarkers = {};

    for (var event in events) {
      newMarkers.add(
        Marker(
          markerId: MarkerId(event.eventId!),
          position: LatLng(event.lat!, event.long!),
          infoWindow: InfoWindow(title: event.title!),
        ),
      );
    }

    if (newMarkers.length != markers.length) {
      markers = newMarkers;
      notifyListeners();
    }
  }
}
