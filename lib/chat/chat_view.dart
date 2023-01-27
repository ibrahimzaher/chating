import 'package:chating/chat/chat_navigator.dart';
import 'package:chating/chat/chat_view_model.dart';
import 'package:chating/chat/message_widget.dart';
import 'package:chating/model/message.dart';
import 'package:chating/model/room.dart';
import 'package:chating/provider/user_provider.dart';
import 'package:chating/utils.dart';
import 'package:chating/widgets/main_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key}) : super(key: key);
  static const String routeName = 'chats';
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> implements ChatNavigator {
  ChatViewModel viewModel = ChatViewModel();
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    viewModel.currentUser =
        Provider.of<UserProvider>(context, listen: false).user!;
  }

  TextEditingController message = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var room = ModalRoute.of(context)?.settings.arguments as Room;
    viewModel.room = room;
    viewModel.getMessages();
    return ChangeNotifierProvider(
      create: (BuildContext context) => viewModel,
      child: MainWidget(
        widget: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: Text(room.roomTitle),
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                15,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            padding: const EdgeInsets.all(
              14,
            ),
            margin: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 32,
            ),
            child: Column(
              children: [
                Expanded(
                  child: StreamBuilder<QuerySnapshot<Message>>(
                    stream: viewModel.messages,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.blue,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text(snapshot.error.toString());
                      } else {
                        var messages = snapshot.data?.docs
                                .map((message) => message.data())
                                .toList() ??
                            [];
                        return ListView.builder(
                          itemBuilder: (context, index) => MessageWidget(
                            message: messages[index],
                          ),
                          itemCount: messages.length,
                        );
                      }
                    },
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: message,
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.all(3),
                          hintText: 'Type A Message',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        viewModel.sendMessage(message.text);
                      },
                      child: Row(
                        children: const [
                          Text('Send'),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.send,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void showMessage(String message) {
    Utils.showMessage(message: message, context: context);
  }

  @override
  void clearMessage() {
    message.clear();
  }
}
