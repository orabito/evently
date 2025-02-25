
import 'package:cloud_firestore/cloud_firestore.dart';

class EventModel {
  String? title;
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
    this.title,
    this.uId,
  });
  EventModel.fromFireStore(Map<String,dynamic>? data){
    title=data?["title"];
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
  "title":title,
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