import 'package:badir_app/Admin/shared/components/colors.dart';
import 'package:badir_app/Admin/view/screens/reset_password_screen.dart';
import 'package:badir_app/Admin/view/widgets/display_dialogs.dart';
import 'package:badir_app/Admin/view_model/auth_view_model/auth_cubit.dart';
import 'package:badir_app/Admin/view_model/auth_view_model/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthCubit cubit = AuthCubit.getInstance(context);
    return BlocConsumer<AuthCubit,AuthStates>(
      listener: (context,state)
      {
        if( state is LoginSuccessState )
          {
            showSnackBar(context: context, message: "تم تسجيل الدخول بنجاح",backgroundColor: Colors.green,seconds: 2);
            Navigator.pushReplacementNamed(context, 'dashboard_screen');
          }
        if( state is FailedToLoginState )
          {
            showSnackBar(context: context, message: state.message,backgroundColor: Colors.red,seconds: 2);
          }
      },
      builder: (context,state) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: SafeArea(
            child: Scaffold(
              body: Row(
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
                        Image.asset("assets/images/admin_login_banner.png",height: 276.h,width:double.infinity,fit: BoxFit.fill,),
                        SizedBox(height: 20.h,),
                        Text("البريد الإلكتروني",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5.h,),
                        _textField(controller: _emailController),
                        SizedBox(height: 13.h,),
                        Text("كلمه المرور",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                        SizedBox(height: 5.h,),
                        _textField(controller: _passwordController,isSecure:true),
                        SizedBox(height: 22.5.h,),
                        MaterialButton(
                          color: mainColor,
                          height: 45.h,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          child: Text(state is LoginLoadingState ? "جاري تسجيل الدخول" : "تسجيل دخول",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
                          onPressed: ()
                          {
                            if( _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty )
                              {
                                cubit.login(email: _emailController.text, password: _passwordController.text);
                              }
                            else
                              {
                                showSnackBar(context: context, message: "برجاء إدخال البيانات كامله",backgroundColor: Colors.red,seconds: 2);
                              }
                          },
                        ),
                        SizedBox(height: 10.h,),
                        Center(
                          child: GestureDetector(
                            onTap: ()
                            {
                              // Todo: عشان لو في بيانات وروحت علي الصفحه التانيه اما ارجع متكنش لسه موجوده
                              _emailController.clear();
                              _passwordController.clear();
                              Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
                            },
                            child: Text("هل نسيت كلمه المرور ؟",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),
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

