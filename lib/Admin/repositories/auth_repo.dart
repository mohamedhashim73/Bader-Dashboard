import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthRepository{

  Future<UserCredential> login({required String email,required String password}) async {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email,password: password);
    return userCredential;
  }

  Future<bool> forgetPassword({required String email}) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      print("Send To Email Successfully ......");
      return true;
    }
    catch(e)
    {
      debugPrint("Failed To send Password Reset to Email, reason : ${e.toString()}");
      return false;
    }
  }

}