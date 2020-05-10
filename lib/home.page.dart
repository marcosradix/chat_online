
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'chat.page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatelessWidget {
  final googleSignIn = GoogleSignIn();
  final firebaseAuth = FirebaseAuth.instance;

  Future<Null> insureLoggedIn() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) {
      user = await googleSignIn.signInSilently();
    }
    if (user == null) {
      user = await googleSignIn.signIn();
    }
    if (await firebaseAuth.currentUser() == null) {
      final GoogleSignInAuthentication googleAuth = await googleSignIn.currentUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken,
  );
          await firebaseAuth.signInWithCredential(credential);
          
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chat Online"),
        centerTitle: true,
        elevation: Theme.of(context).platform == TargetPlatform.iOS ? 0.0 : 4.0,
      ),
      body: ChatPage(),
    );
  }
}
