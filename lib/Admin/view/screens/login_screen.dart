import 'package:badir_app/shared/components/colors.dart';
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
    bool isMobile = MediaQuery.of(context).size.width < 600;
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
              body: isMobile ?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.w),
                    child: Center(
                      child: SingleChildScrollView(
                          child: _loginBody(isMobile:isMobile,context: context, cubit: cubit, emailController: _emailController, passwordController: _passwordController)
                      ),
                    ),
                  ) :
                  Row(
                    children:
                      [
                        const Expanded(flex:1,child: SizedBox()),
                        Expanded(
                          flex: 1,
                          child: _loginBody(isMobile : isMobile, context: context, cubit: cubit, emailController: _emailController, passwordController: _passwordController),
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


Widget _loginBody({required bool isMobile,required BuildContext context,required AuthCubit cubit,required TextEditingController emailController,required TextEditingController passwordController}){
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.center,
    children:
    [
      if( !isMobile)
        Image.asset("assets/images/admin_login_banner.png",height: 276.h,width:double.infinity,fit: BoxFit.fill,),
      if( !isMobile )
        SizedBox(height: 20.h,),
      Text("البريد الإلكتروني",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      SizedBox(height: 10.h,),
      _textField(controller: emailController),
      SizedBox(height: 15.h,),
      Text("كلمه المرور",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      SizedBox(height: 10.h,),
      _textField(controller: passwordController,isSecure:true),
      SizedBox(height: 22.5.h,),
      BlocBuilder<AuthCubit,AuthStates>(
        builder: (context,state){
          return MaterialButton(
            color: mainColor,
            padding: EdgeInsets.symmetric(vertical: isMobile? 5.h : 10.h),
            minWidth: double.infinity,
            textColor: Colors.white,
            child: Text(state is LoginLoadingState ? "جاري تسجيل الدخول" : "تسجيل دخول",style: TextStyle(fontSize: 16.sp,fontWeight: FontWeight.bold),),
            onPressed: ()
            {
              if( emailController.text.isNotEmpty && passwordController.text.isNotEmpty )
              {
                cubit.login(email: emailController.text, password: passwordController.text);
              }
              else
              {
                showSnackBar(context: context, message: "برجاء إدخال البيانات كامله",backgroundColor: Colors.red,seconds: 2);
              }
            },
          );
        },
      ),
      SizedBox(height: 10.h,),
      Center(
        child: GestureDetector(
          onTap: ()
          {
            // Todo: عشان لو في بيانات وروحت علي الصفحه التانيه اما ارجع متكنش لسه موجوده
            emailController.clear();
            passwordController.clear();
            Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordScreen()));
          },
          child: Text("هل نسيت كلمه المرور ؟",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15.sp),),
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
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4)
        ),
      ),
    ),
  );
}

