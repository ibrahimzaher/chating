import 'package:chating/model/message.dart';
import 'package:chating/model/my_user.dart';
import 'package:chating/model/room.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseUtils {
  static CollectionReference<MyUser> getUserCollection() {
    return FirebaseFirestore.instance
        .collection(MyUser.collectionName)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, options) =>
              MyUser.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Room> getRoomCollection() {
    return FirebaseFirestore.instance
        .collection(Room.roomCollectionName)
        .withConverter<Room>(
          fromFirestore: (snapshot, options) => Room.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static CollectionReference<Message> getMessageCollection(String roomId) {
    return FirebaseFirestore.instance
        .collection(Room.roomCollectionName)
        .doc(roomId)
        .collection(Message.collectionName)
        .withConverter<Message>(
          fromFirestore: (snapshot, options) =>
              Message.fromJson(snapshot.data()!),
          toFirestore: (value, options) => value.toJson(),
        );
  }

  static Future<void> userRegister(MyUser user) async {
    return getUserCollection().doc(user.id).set(user);
  }

  static Future<MyUser?> getUser(String id) async {
    var docUser = await getUserCollection().doc(id).get();
    return docUser.data();
  }

  static Future<void> addRoomToFireStore(Room room) async {
    var doc = getRoomCollection().doc();
    room.roomId = doc.id;
    return doc.set(room);
  }

  static Stream<QuerySnapshot<Room>> getAllRooms() {
    return getRoomCollection().snapshots(includeMetadataChanges: true);
  }

  static Future<void> insertMessage(Message message) async {
    var messageCollection = getMessageCollection(message.roomId);
    var docRef = messageCollection.doc();
    message.id = docRef.id;
    return docRef.set(message);
  }

  static Stream<QuerySnapshot<Message>> getMessages(String roomId) {
    return getMessageCollection(roomId)
        .orderBy('dateTime')
        .snapshots(includeMetadataChanges: true);
  }
}
