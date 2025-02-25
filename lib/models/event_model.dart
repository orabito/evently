
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? tittle;
  String? description;
  String? category;
 Timestamp? date;
  String? eventId;
  String? uId;
double? lat;
double? long;



  EventModel({
    this.description,
    this.category,
    this.date,
    this.eventId,

    this.lat=0,
    this.long=0,
    this.tittle,
    this.uId,
  });
  EventModel.fromFireStore(Map<String,dynamic>? data){
    tittle=data?["tittle"];
    description=data?["description"];
    category=data?["category"];
    date=data?["date"];
    eventId=data?["eventId"];
    lat=data?["lat"];
    long=data?["long"];

    uId=data?["uId"];
  }

 Map<String,dynamic> toFireStore(){
return{
  "tittle":tittle,
  "description":description,
  "category":category,
  "date":date,
  "eventId":eventId,
  "lat":lat,
  "long":long,

  "uId":uId,
};
}

}