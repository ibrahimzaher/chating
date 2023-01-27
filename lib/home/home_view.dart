import 'package:chating/add_room/add_room_view.dart';
import 'package:chating/add_room/room_widget.dart';
import 'package:chating/database/database_utils.dart';
import 'package:chating/login/login_view.dart';
import 'package:chating/model/room.dart';
import 'package:chating/widgets/main_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);
  static const String routeName = 'Home';
  @override
  Widget build(BuildContext context) {
    return MainWidget(
      widget: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
          title: const Text('Chat App'),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut().then((value) =>
                    Navigator.pushReplacementNamed(
                        context, LoginView.routeName));
              },
              icon: const Icon(
                Icons.logout,
              ),
              color: Colors.white,
            ),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Room>>(
          stream: DatabaseUtils.getAllRooms(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              var data =
                  snapshot.data?.docs.map((query) => query.data()).toList() ??
                      [];
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                itemBuilder: (context, index) {
                  return RoomWidget(room: data[index]);
                },
                itemCount: data.length,
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.blue,
              ));
            } else {
              return Text(snapshot.error.toString());
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AddRoomView.routeName);
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
