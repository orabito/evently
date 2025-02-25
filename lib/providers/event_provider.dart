// import 'dart:async';
//
// import 'package:flutter/cupertino.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class EventProvider extends ChangeNotifier {
// //this is the first thing to can use package location
//   Location location = Location();
//   LatLng?eventLocation;
//   StreamSubscription<LocationData>? _locationSubscription;
//
//   //and i use the controller onMap created also  we init this in function changeLocationOnMap
//   late GoogleMapController mapController;
//
//   // we init this in function changeLocationOnMap
//   CameraPosition cameraPosition = const CameraPosition(
//     target: LatLng(29.964713, 31.256447),
//     zoom: 17,
//   );
//
//   // we init this in function changeLocationOnMap
//   Set<Marker> markers = {
//     Marker(
//       markerId: MarkerId("0"),
//       position: LatLng(37.42796133580664, -122.085749655962),
//     )
//   };
//
// //i use it in floating button
//   Future<void> getLocation() async {
//     bool locationPermissionGranted = await getLocationPermission();
//     if (!locationPermissionGranted) {
//       notifyListeners();
//       return;
//     }
//     var locationServiceEnabled = await locationServiceEnable();
//     if (!locationServiceEnabled) {
//       notifyListeners();
//       return;
//     }
//
//     notifyListeners();
//     LocationData locationData = await location.getLocation();
//     changeLocationOnMap(locationData);
//     notifyListeners();
//   }
//
// //second function when i use location
//   Future<bool> locationServiceEnable() async {
//     bool locationServiceEnabled = await location.serviceEnabled();
//     if (!locationServiceEnabled) {
//       locationServiceEnabled = await location.requestService();
//     }
//     return locationServiceEnabled;
//   }
//
// //first function when i use location
//   Future<bool> getLocationPermission() async {
//     var permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//     }
//     return permissionGranted == PermissionStatus.granted;
//   }
//
//   //i use it in function setLocationListener that i use it in onMapCreated\
//   //and i use the controller onMap created also
//   changeLocationOnMap(LocationData locationData) {
//     final newPosition = LatLng(
//       locationData.latitude ?? 0,
//       locationData.longitude ?? 0,
//     );
//     cameraPosition = CameraPosition(target: newPosition, zoom: 17);
//     markers = {
//       Marker(
//         markerId: MarkerId("0"),
//         position: newPosition,
//       )
//     };
//     mapController.animateCamera(
//       CameraUpdate.newCameraPosition(
//         cameraPosition,
//       ),
//     );
//     notifyListeners();
//   }
//   void changeLocation(LatLng newEventLocation){
//  eventLocation=newEventLocation;
//  notifyListeners();
//   }
//   bool eventLocationbolin(){
//     if(eventLocation==null){
//       ChangeNotifier();
//       return false;
//     }else{
//       ChangeNotifier();
//       return true;
//     }
//
//   }
//   void dispose() {
//     _locationSubscription?.cancel();
//     super.dispose();
//   }
//
//   //i use ut  to fix the error
//   void cancelLocationSubscription() {
//     _locationSubscription?.cancel();
//     _locationSubscription = null;
//   }
// }
