import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireAuth {
  // Code for registering new user in firebase
  static Future<User?> registerUsingEmailPassword({
    required BuildContext context,
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      var error = "Something went wrong";
      if (e.code == 'weak-password') {
        error = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        error = 'The account already exists for that email.';
      }
      var snackBar = SnackBar(
        content: Text(error),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
      var snackBar = const SnackBar(
        content: Text("Something went wrong"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar); //Showing snackbar when there is error in sign up
    }
    return user;
  }

  // Code for signing in an old user
  static Future<User?> signInUsingEmailPassword({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      var error = "Something went wrong";
      if (e.code == 'user-not-found') {
        error = 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        error = 'Wrong password provided.';
      }
      var snackBar = SnackBar(
        content: Text(error),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar); //Showing snackbar when there is error in sign in
    }

    return user;
  }
}
