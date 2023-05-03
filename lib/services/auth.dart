import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/navigator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:tichu_flutter/models/service_response.dart';
import 'package:tichu_flutter/screens/home/home_screen.dart';
import 'package:tichu_flutter/screens/login/login_screen.dart';

import 'firestore.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  void navigateBasedOnAuthState(NavigatorState navigator) {
    // navigator.pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    //   (route) => false,
    // );
    // return;

    final currentUser = _auth.currentUser;

    if (currentUser != null) {
      navigator.pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (context) => HomeScreen(),
        ),
        (route) => false,
      );
      return;
    }
    navigator.pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ),
      (route) => false,
    );
    return;
  }

  Future<ServiceResponse<void>> login(String email, String password) async {
    String? errString = 'Auth.login:error';
    try {
      await _auth.signInWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
      errString = null;
    } on FirebaseAuthException catch (e) {
      errString = e.code;
    } catch (e) {
      errString = 'Auth.login:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> signup(
    String email,
    String username,
    String password,
  ) async {
    String? errString = 'Auth.signup:error';
    try {
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email.toLowerCase().trim(), password: password);
      if (cred.user != null) {
        _auth.currentUser?.updateDisplayName(username);
        Firestore().createUserDoc(cred.user!.uid, email, username);
      }
      errString = null;
    } on FirebaseAuthException catch (e) {
      errString = e.code;
    } catch (e) {
      errString = 'Auth.signup:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Future<ServiceResponse<void>> logout(NavigatorState navigator) async {
    String? errString = 'Auth.logout:error';
    try {
      await _auth.signOut();
      navigateBasedOnAuthState(navigator);
      errString = null;
    } catch (e) {
      errString = 'Auth.logout:${e.toString()}';
    }
    return ServiceResponse(errString, null);
  }

  Stream<User?> getUserChangesStream() {
    return _auth.userChanges();
  }
}
