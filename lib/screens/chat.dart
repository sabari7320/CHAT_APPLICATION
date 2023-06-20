import 'package:chat_app/widgets/chat_messages.dart';
import 'package:chat_app/widgets/new_messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  void setupPushNotifications() async{
    final fcm= FirebaseMessaging.instance;
    await fcm.requestPermission();
    fcm.subscribeToTopic('chat');
    final token=await fcm.getToken();
    print('fcm');
    print(token); // you could send this token( via HTTP or the Firebase SDK) to a backend;
  }
  @override
  void initState() {
    super.initState();

   setupPushNotifications();
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FlutterChat',style: TextStyle(fontWeight:FontWeight.w900),),
        actions: [
          IconButton(
              onPressed: (){FirebaseAuth.instance.signOut();},
              icon: Icon(Icons.exit_to_app,color: Theme.of(context).colorScheme.primary,))
        ],
      ),
      body:Column(children: const[
        Expanded(child: ChatMessages()),
        NewMessage()
      ],)


    );
  }
}
