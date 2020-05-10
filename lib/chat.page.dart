import 'package:chat_online/textComposer.widget.dart';
import 'package:flutter/material.dart';
import 'chatMessage.widget.dart';

import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

final googleSignIn = GoogleSignIn();
final firebaseAuth = FirebaseAuth.instance;

_handleSubmitted(String text) async {
  print("$text");
  await insureLoggedIn();
  _sendMessage(text);
}

void _sendMessage(String text, [String imageUrl]) {
  Firestore.instance.collection("messages").add(
    {
      "text": text,
      "imageUrl" : imageUrl,
      "senderName": googleSignIn.currentUser.displayName,
      "senderPhotoUrl": googleSignIn.currentUser.photoUrl
    }
  );
}

Future<Null> insureLoggedIn() async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  if (user == null) {
    user = await googleSignIn.signInSilently();
  }
  if (user == null) {
    user = await googleSignIn.signIn();
  }
  if (await firebaseAuth.currentUser() == null) {
    final GoogleSignInAuthentication googleAuth =
        await googleSignIn.currentUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await firebaseAuth.signInWithCredential(credential);
  }
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      top: false,
      child: Column(
        children: <Widget>[
          Expanded(
            child: StreamBuilder(
              stream: Firestore.instance.collection("messages").snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                  case ConnectionState.waiting:
                    return Center(
                      child: CircularProgressIndicator()
                    );
                    

                  default:
                  return ListView.builder(
                    reverse: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (BuildContext context, index){
                      List r = snapshot.data.documents.reversed.toList();
                      return ChatMessage(r[index].data);
                    },

                  );
                }
              },
            ),
          ),
          Divider(
            height: 2.0,
          ),
          Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
              ),
              child: TextComposer(func: (_handleSubmitted)))
        ],
      ),
    );
  }
}
