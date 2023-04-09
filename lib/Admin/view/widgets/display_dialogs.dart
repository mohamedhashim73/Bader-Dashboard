import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

void displayAlertDialog({required BuildContext context,Color? backgroundColor,required Widget content}){
  showDialog(context: context, builder: (context){
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        content: content,
        backgroundColor: backgroundColor,
      ),
    );
  });
}

void showToast({required String message,Toast? toastLength,Color? backgroundColor}){
  Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength?? Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: backgroundColor ?? Colors.black,
      textColor: Colors.white,
      fontSize: 16.0
  );
}

void showSnackBar({required BuildContext context, required String message, Color? backgroundColor,int seconds = 1}){
  ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: Duration(seconds: seconds),
          backgroundColor: backgroundColor ?? Colors.black,
          padding: EdgeInsets.symmetric(vertical: 12.5.h,horizontal: 6.w),
          content: Text(message,style: TextStyle(color: Colors.white,fontSize: 17.sp),))
  );
}
