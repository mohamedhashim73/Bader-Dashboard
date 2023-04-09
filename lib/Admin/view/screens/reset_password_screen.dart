import 'package:badir_app/Admin/view/widgets/display_dialogs.dart';
import 'package:badir_app/Admin/view_model/auth_view_model/auth_cubit.dart';
import 'package:badir_app/Admin/view_model/auth_view_model/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                                  if(  _emailController.text.trim() == "mohamedhashimrezk73@gmail.com" )
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
