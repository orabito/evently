import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_planning_app/models/event_model.dart';
import 'package:event_planning_app/models/user_model.dart';

//CRUD:create  read update_event delete

class FirestoreHandler {  static CollectionReference<UserModel> getUserCollection() {
    var collectionReference = FirebaseFirestore.instance
        .collection("User")
        .withConverter(fromFirestore: (snapshot, options) {
      Map<String, dynamic>? data = snapshot.data();
      return UserModel.fromFireStore(data);
    }, toFirestore: (user, options) {
      return user.toFirestore();
    });
    return collectionReference;
  }

  static Future<void> AddUser(UserModel user) {
    var collection = getUserCollection();
    var document = collection.doc(user.id);
    return document.set(user);
  }

  static Future<UserModel?> getUser(String uId) async {
    var collection = getUserCollection();
    var document = collection.doc(uId);
    var snapshot = await document.get();

    return snapshot.data();
  }

  static CollectionReference<EventModel> getEventCollection() {
    var collection =
    FirebaseFirestore.instance.collection("event").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return EventModel.fromFireStore(data);
      },
      toFirestore: (event, options) => event.toFireStore(),
    );
    return collection;
  }

  static Future<void> createEvent(EventModel event) {
    var collection = getEventCollection();
    var doc = collection.doc();
    event.eventId = doc.id;

    return doc.set(event);
  }

  static Future<List<EventModel>> getEvents() async {
    var collection = getEventCollection();
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
    )
        .toList();
    return eventList;
  }

  static Future<List<EventModel>> getEventsByCategory(String category) async {
    var collection =
    getEventCollection().where("category", isEqualTo: category);
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
    )
        .toList();
    return eventList;
  }

  static CollectionReference<EventModel> getWishListCollection(String uid) {
    var collection =
    getUserCollection().doc(uid).collection("wishList").withConverter(
      fromFirestore: (snapshot, options) {
        var data = snapshot.data();
        return EventModel.fromFireStore(data);
      },
      toFirestore: (event, options) => event.toFireStore(),
    );
    return collection;
  }

  static Future<void> addToFavorite(String uid, EventModel event) {
    var collection = getWishListCollection(uid);
    var doc = collection.doc(event.eventId);
    return doc.set(event);
  }
  static  Future<void> deleteEvent(EventModel event){
  var collection=getEventCollection();
  return collection.doc(event.eventId).delete();

  }

  static Future<void> removeFromFavorite(String eventId, String uid) {
    var collection = getWishListCollection(uid);
    return collection.doc(eventId).delete();
  }

  static Future<List<EventModel>> getMyWishlist(String uid,) async {
    var collection = getWishListCollection(uid);
    var querySnapshot = await collection.get();
    var docList = querySnapshot.docs;
    var eventList = docList
        .map(
          (doc) => doc.data(),
    )
        .toList();
    return eventList;
  }
  static Stream<List<EventModel>> getMyWishlistStream(String uid,) async*{
    var collection = getWishListCollection(uid);
    var Snapshot =  collection.snapshots();
       Stream<List<EventModel>> EventWishListsStream = Snapshot.map((Snapshot) =>
        Snapshot.docs.map((docs) => docs.data(),).toList());

    yield* EventWishListsStream;
  }
static Stream<List<EventModel>> getLoveEventStream(String uid)async*{
  //not working
  var collection =getWishListCollection(uid);
  var snapshots=collection.snapshots();
  Stream<List<EventModel>>eventStream=snapshots.map((snapshots) =>snapshots.docs.map((doc)=>doc.data()).toList() ,);
  yield* eventStream;
}

  static Future<void> updateUserFavorites(String uid, List<String>newFavorite) {
    var collection = getUserCollection();
    var doc = collection.doc(uid);
    return doc.update({
      "favorite": newFavorite
    });
  }
static Future<void> updateEvent( {required EventModel  event } ){
  var collection=getEventCollection();
  var doc=collection.doc(event.eventId);
  return doc.update(
    event.toFireStore()
  );
}

  static Stream<List<EventModel>> getAllEventsStream() async* {
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    var collection = getEventCollection().where("date",isGreaterThanOrEqualTo: today );
    var snapshots = collection.snapshots();
    Stream<List<EventModel>> allEventsStream = snapshots
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

    yield* allEventsStream;
  }

  static Stream<List<EventModel>> getAllEventsByCategoryStream(String category ) async*{

    var collection = getEventCollection().where(
       "category",isEqualTo: category
    );

    var snapshots = collection.snapshots();
    Stream<List<EventModel>> allEventsStream = snapshots
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());

    yield* allEventsStream;
  }

}









