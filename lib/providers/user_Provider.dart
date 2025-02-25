import 'package:event_planning_app/core/reusable_componets/firestore_handler.dart';
import 'package:event_planning_app/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  UserModel? user;
  
  bool isLoading=false;
  getUser()async{
    isLoading=true;
    notifyListeners();
    user = (await FirestoreHandler.getUser(FirebaseAuth.instance.currentUser!.uid)) ;
    isLoading=false;
    notifyListeners();
  }
  
  
}