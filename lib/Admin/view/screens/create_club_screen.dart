import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/display_dialogs.dart';

class CreateClubScreen extends StatelessWidget{
  final TextEditingController clubName = TextEditingController();
  CreateClubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    if( cubit.clubsNames.isEmpty ) cubit.getNamesForAllClubs();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DashBoardCubit,DashBoardStates>(
        listener: (context,state)
        {
          if( state is CreateClubSuccessState )
          {
            showSnackBar(context: context, message: "تم انشاء النادي بنجاح",backgroundColor: Colors.green,seconds: 5);
            clubName.clear();
            cubit.selectedCollege = null;
            Navigator.pushNamed(context, "dashboard_screen");
          }
          if( state is FailedToCreateClubState )
          {
            showSnackBar(context: context, message: "حدث خطأ ما اثناء انشاء النادي برجاء التأكد من حاله النت",backgroundColor: Colors.red,seconds: 5);
          }
        },
        builder: (context,state) {
          return Scaffold(
            appBar: AppBar(title: const Text("انشاء نادى")),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.5.w,vertical: 20.h),
              child: ListView(
                shrinkWrap: true,
                children:
                [
                  Text("اسم النادي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                  SizedBox(height: 12.h,),
                  SizedBox(
                    height: 50.h,
                    width: double.infinity,
                    child: TextFormField(
                      controller: clubName,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                      ),
                    ),
                  ),
                  SizedBox(height: 12.h,),
                  Text("الكليه",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
                  SizedBox(height: 12.h,),
                  Container(
                    height: 50.h,
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 4.w,vertical: 5.h),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey)
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text("اختار"),
                        value: cubit.selectedCollege,
                        onChanged: (val)
                        {
                          cubit.chooseCollege(value: val!);
                        },
                        items: cubit.colleges.map((e) => DropdownMenuItem(value: e,child: Text(e,textDirection: TextDirection.rtl,),)).toList(),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h,),
                  MaterialButton(
                      height: 42.5.h,
                      color: mainColor,
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      onPressed: ()
                      {
                        if( cubit.clubsNames.contains(clubName.text.trim()) == false )
                          {
                            cubit.createClub(name: clubName.text.trim(), college: cubit.selectedCollege!);
                          }
                        else if ( clubName.text.isEmpty || cubit.selectedCollege == null )
                          {
                            showSnackBar(context: context, message: "برجاء إدخال البيانات كامله !!",backgroundColor: Colors.red);
                          }
                        else if ( cubit.clubsNames.contains(clubName.text.trim()) == true )
                          {
                            showSnackBar(context: context, message: "برجاء اختيار اسم أخر للنادي لأن يوجد بالفعل نادي بهذا الإسم",backgroundColor: Colors.red);
                          }
                      },
                      minWidth: double.infinity,
                      child: Text(state is CreateClubLoadingState? "انتظر لثواني" : "إنشاء",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.5.sp),)
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}