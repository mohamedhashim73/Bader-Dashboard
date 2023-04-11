import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AssignClubLeaderScreen extends StatelessWidget{
  const AssignClubLeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    // Todo: Need To Get All Users on App to choose on | Get All Clubs Data
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state) {
            return Scaffold(
              drawer: DrawerItem(),
              appBar: AppBar(title: const Text("تعيين قائد")),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.5.w,vertical: 20.h),
                child: ListView(
                  shrinkWrap: true,
                  children:
                  [
                    Text("اسم النادي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
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
                            // cubit.chooseCollege(value: val!);
                          },
                          items: cubit.clubs.map((e) => DropdownMenuItem(value: e,child: Text(e.name!,textDirection: TextDirection.rtl,),)).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 12.h,),
                    Text("معلومات القائد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18.sp),),
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
                          hint: const Text("البريد الإلكتروني"),
                          value: cubit.selectedCollege,
                          onChanged: (val)
                          {
                            // cubit.chooseCollege(value: val!);
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
                          // cubit.assignClubLeader(clubID: clubID, leaderID: leaderID, leaderName: leaderName, leaderEmail: leaderEmail);
                        },
                        minWidth: double.infinity,
                        child: Text(state is CreateClubLoadingState? "جاري التعيين" : "تعيين",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18.5.sp),)
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