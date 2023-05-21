import 'package:badir_app/model/admin_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<AdminModel?> getAdminData() async {
    AdminModel? model;
    await FirebaseFirestore.instance.collection('Admin').get().then((value){
      model = AdminModel.fromJson(json: value.docs.first.data());
      debugPrint("Admin Info is : ${value.docs.first.data()}");
    });
    return model;
  }

  // هستعملها في حاله تسجيل الدخول لو وجدت ان الباسورد مش هو اللي موجود ف FireStore لان ده معناها ان عمل نسيت كلمه السر وقام بتغييرها بالفعل
  Future<void> updateAdminPassword({required String newPassword,required String adminID}) async {
    await FirebaseFirestore.instance.collection('Admin').doc(adminID).update({
      'password' : newPassword
    });
  }

}