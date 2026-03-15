// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:chatapp/cubit/send_message_cubit.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

User? user;

TextEditingController _controller = TextEditingController();
CollectionReference messageSender =
    FirebaseFirestore.instance.collection('messages');

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 216, 220, 240),
          appBar: AppBar(
            backgroundColor: const Color.fromARGB(255, 255, 255, 255),
            actions: [
              IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            height: 100,
                            child: Center(
                              child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: const Color.fromARGB(
                                          255, 205, 15, 15)),
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut();
                                    Navigator.popUntil(
                                        context, ModalRoute.withName('/'));
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                LoginScreen()));
                                  },
                                  child: Text('logout',
                                      style: TextStyle(color: Colors.black))),
                            ),
                          );
                        });
                  },
                  icon: Icon(Icons.more_vert, color: Colors.black))
            ],
            title: Row(
              children: [
                Icon(Icons.groups),
                SizedBox(
                  width: 10,
                ),
                Text('Our Group')
              ],
            ),
            leading: IconButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                icon: Icon(Icons.arrow_back_ios_new)),
          ),
          body: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: MessageStreamBuilder(),
                  ),
                  BlocProvider(
                    create: (context) => SendMessageCubit(),
                    child: BlocBuilder<SendMessageCubit, SendMessageState>(
                      builder: (context, state) {
                        return TextField(
                          controller: _controller,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(),
                              suffixIcon: IconButton(
                                icon: (state is SendMessageLoading)
                                    ? CircularProgressIndicator()
                                    : Icon(Icons.send_outlined),
                                onPressed: () {
                                  context.read<SendMessageCubit>().sendMessage(
                                      message: _controller.text,
                                      user: user!.email!);
                                  _controller.clear();
                                },
                              ),
                              hintText: 'Type your message',
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 3, style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10))),
                        );
                      },
                    ),
                  )
                ],
              )),
        ));
  }
}

var firestor = FirebaseFirestore.instance;

class MessageStreamBuilder extends StatelessWidget {
  const MessageStreamBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: firestor.collection('messages').orderBy('time').snapshots(),
        builder: (context, snapshot) {
          List<MessageShape> messageWidgets = [];
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Colors.black38,
              ),
            );
          }
          final messages = snapshot.data!.docs.reversed;
          for (var message in messages) {
            final messageSender = message.get('user');
            final messageText = message.get('message');

            final currentUser = user!.email;
            if (currentUser == messageSender) {}
            final messageWidget = MessageShape(
              user: messageSender,
              message: messageText,
              isCurrentUser: currentUser == messageSender,
            );
            messageWidgets.add(messageWidget);
          }
          return ListView(
            reverse: true,
            children: messageWidgets,
          );
        });
  }
}

class MessageShape extends StatelessWidget {
  final String user;

  final String message;
  final bool isCurrentUser;
  const MessageShape(
      {super.key,
      required this.user,
      required this.message,
      required this.isCurrentUser});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            user,
            style: TextStyle(
                color: isCurrentUser
                    ? const Color.fromARGB(255, 0, 0, 0)
                    : const Color.fromARGB(255, 3, 19, 247)),
          ),
          Material(
            elevation: 10,
            borderRadius: isCurrentUser
                ? BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(15))
                : BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomRight: Radius.circular(15)),
            color: isCurrentUser
                ? Colors.blue
                : const Color.fromARGB(255, 208, 212, 235),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                message,
                style: TextStyle(
                    fontSize: 15,
                    color: isCurrentUser ? Colors.white : Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
