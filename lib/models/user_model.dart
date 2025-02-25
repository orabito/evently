import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String?email;
  String? name;
List<String>?favorite;
  UserModel({  this.name, this.email, this.id,this.favorite});

  UserModel.fromFireStore(
    Map<String, dynamic>? data,) {
    email = data?["email"];
    id = data?["id"];
    name = data?["name"];
    favorite =List<String>.from( data?["favorite"]);
    //some time i have error with list that i get from database or api
    //i must  favorite = data?["favorite"]List<String>
    //but not working also so the right thing that i do it right here
  }

  Map<String, dynamic> toFirestore(){
   return {
     "name":name,
     "id":id,
     "email":email,
     "favorite":favorite,
   };
  }


}