import 'dart:async';


import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationProvider extends ChangeNotifier {
  //this is the first thing to can use package location
  Location location = Location();
  StreamSubscription<LocationData>? _locationSubscription;
  //and i use the controller onMap created also  we init this in function changeLocationOnMap
  late GoogleMapController  mapController;
  // we init this in function changeLocationOnMap
  CameraPosition cameraPosition  = const CameraPosition(
    target: LatLng(29.964713, 31.256447),
    zoom: 17,
  );
  // we init this in function changeLocationOnMap
  Set<Marker>markers= {
    Marker(
      markerId:MarkerId("0"),
      position: LatLng(37.42796133580664, -122.085749655962),
    )
  };
//i use it in floating button
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

    notifyListeners();
    LocationData locationData=await location.getLocation();
    changeLocationOnMap(locationData);
  notifyListeners();
  }
//second function when i use location
  Future<bool> locationServiceEnable() async {
    bool locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();

    }
    return locationServiceEnabled;
  }
//first function when i use location
  Future<bool> getLocationPermission() async {
    var permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();

    }
    return permissionGranted == PermissionStatus.granted;
  }


   // i use this function in onMapCreated
    void setLocationListener(){
    location.changeSettings(accuracy: LocationAccuracy.balanced);
    _locationSubscription = location.onLocationChanged.listen((location) {
      changeLocationOnMap(location);
    });
  }

  //i use it in function setLocationListener that i use it in onMapCreated\
  //and i use the controller onMap created also
  changeLocationOnMap(LocationData locationData ){
    final newPosition = LatLng(
      locationData.latitude ?? 0,
      locationData.longitude ?? 0,
    );
    cameraPosition = CameraPosition(
        target:
        newPosition,zoom: 17);
    markers.add(    Marker(
      markerId:MarkerId(UniqueKey().toString()),
      position: newPosition,
    )) ;
    mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition,),);
notifyListeners();
  }
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();

  }

  //i use ut  to fix the error
  void cancelLocationSubscription() {
    _locationSubscription?.cancel();
    _locationSubscription = null;
  }

void  seeLocationOfEvent(LatLng location){
  final newPosition = LatLng(
    location.latitude ,
    location.longitude ,
  );
    cameraPosition = CameraPosition(
        zoom: 17,
        target: LatLng(
          newPosition.latitude ,
          newPosition.longitude ,
        ));
  markers= {
    Marker(
      markerId:MarkerId("0"),
      position: newPosition,
    )
  };
  mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition,),);
  notifyListeners();
  }
  //this is the first thing to can use package location

  LatLng?eventLocation;


  //and i use the controller onMap created also  we init this in function changeLocationOnMap


  // we init this in function changeLocationOnMap


  // we init this in function changeLocationOnMap


  clearLocation(){
    eventLocation = null;
    notifyListeners();
  }




//first function when i use location


  //i use it in function setLocationListener that i use it in onMapCreated\
  //and i use the controller onMap created also

   void changeLocation(LatLng newEventLocation){
    eventLocation=newEventLocation;
    notifyListeners();
  }
  bool eventLocationbolin(){
    if(eventLocation==null){
      ChangeNotifier();
      return false;
    }else{
      ChangeNotifier();
      return true;
    }

  }

}
