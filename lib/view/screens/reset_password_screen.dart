import 'package:badir_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:badir_app/view_model/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/display_dialogs.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    AuthCubit cubit = AuthCubit.getInstance(context);
    return BlocConsumer<AuthCubit,AuthStates>(
        listener: (context,state)
        {
          if( state is SendPasswordResetEmailSuccessState )
          {
            showSnackBar(seconds: 25,context: context, message: "تم إرسال ايميل للبريد الإلكتروني  لإعادة تعيين كلمة المرور ، برجاء التحقق منه",backgroundColor: Colors.green);
            Navigator.pop(context);
          }
          if( state is SendPasswordResetEmailFailureState )
          {
            showSnackBar(context: context, message: "حدث خطأ أثناء المصادقه مع البريد الالكتروني",backgroundColor: Colors.red);
          }
        },
        builder: (context,state) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: SafeArea(
              child: Scaffold(
                  body: isMobile?
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 15.0.w),
                        child: _resetPasswordBody(state: state, context: context, cubit: cubit, emailController: _emailController),
                      ) :
                      Row(
                        children:
                        [
                          const Expanded(flex:1,child: SizedBox()),
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                              [
                                Text("البريد الإلكتروني",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                                SizedBox(height: 5.h,),
                                _textField(controller: _emailController),
                                SizedBox(height: 22.5.h,),
                                MaterialButton(
                                  color: const Color(0xFF3E5788),
                                  height: 45.h,
                                  padding: EdgeInsets.symmetric(vertical: 10.h),
                                  minWidth: double.infinity,
                                  textColor: Colors.white,
                                  child: Text("تأكيد",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                                  onPressed: ()
                                  {
                                    if( _emailController.text.isNotEmpty )
                                    {
                                      if(  _emailController.text.trim() == AuthCubit.getInstance(context).adminModel!.email!.trim() )
                                      {
                                        cubit.sendPasswordResetToEmail(email: _emailController.text.trim());
                                      }
                                      else
                                      {
                                        showSnackBar(context: context, message: "غير مصرح لهذا البريد الإلكتروني بالدخول",backgroundColor: Colors.red);
                                      }
                                    }
                                    else
                                    {
                                      showSnackBar(context: context, message: "برجاء إدخال البريد الإلكتروني",backgroundColor: Colors.red);
                                    }
                                  },
                                ),
                                SizedBox(height: 10.h,),
                                Center(
                                  child: GestureDetector(
                                    onTap: ()
                                    {
                                      Navigator.pop(context);
                                    },
                                    child: Text("الرجوع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),
                                  ),
                                )
                              ],
                            ),
                          ),
                          const Expanded(flex:1,child: SizedBox()),
                        ],
                  )
              ),
            ),
          );
        }
    );
  }
}

Widget _resetPasswordBody({required AuthStates state, required BuildContext context,required AuthCubit cubit,required TextEditingController emailController}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      Text("البريد الإلكتروني",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      SizedBox(height: 5.h,),
      _textField(controller: emailController),
      SizedBox(height: 22.5.h,),
      MaterialButton(
        color: const Color(0xFF3E5788),
        height: 45.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        minWidth: double.infinity,
        textColor: Colors.white,
        child: Text("تأكيد",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
        onPressed: ()
        {
          if( emailController.text.isNotEmpty )
          {
            if( emailController.text.trim() == AuthCubit.getInstance(context).adminModel!.email!.trim() )
            {
              cubit.sendPasswordResetToEmail(email: emailController.text.trim());
            }
            else
            {
              showSnackBar(context: context, message: "غير مصرح لهذا البريد الإلكتروني بالدخول",backgroundColor: Colors.red);
            }
          }
          else
          {
            showSnackBar(context: context, message: "برجاء إدخال البريد الإلكتروني",backgroundColor: Colors.red);
          }
        },
      ),
      SizedBox(height: 10.h,),
      Center(
        child: GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },
          child: Text("الرجوع",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),
        ),
      )
    ],
  );
}

Widget _textField({required TextEditingController controller,bool? isSecure}){
  return SizedBox(
    width: double.infinity,
    height: 45.h,
    child: TextFormField(
      controller: controller,
      obscureText: isSecure ?? false,
      decoration: InputDecoration(
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4)
        ),
      ),
    ),
  );
}
