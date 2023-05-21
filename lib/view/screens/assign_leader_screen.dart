import 'package:badir_app/model/user_model.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/club_model.dart';
import '../../view_model/dashboard_cubit/dashboard_states.dart';
import '../widgets/display_dialogs.dart';

class AssignClubLeaderScreen extends StatelessWidget{
  const AssignClubLeaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context)..getUsersThatAreNotLeaders()..getClubsWithoutLeader();
    cubit.selectedLeaderEmail = null;
    cubit.selectedClubName = null;
    // Todo: Need To Get All Users on App to choose on | Get All Clubs Data
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state)
          {
            if( state is AssignLeaderToClubSuccessState )
              {
                cubit.selectedClubName = null;
                cubit.selectedLeaderEmail = null;
                showSnackBar(context: context, message: "تم تعيين المستخدم ك أدمن",backgroundColor: Colors.green);
                Navigator.pop(context);
              }
            if( state is FailedToAssignLeaderToClubState )
              {
                showSnackBar(context: context, message: "حدث خطأ ما برجاء المحاولة لاحقا",backgroundColor: Colors.red);
              }
          },
          builder: (context,state) {
            return Scaffold(
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
                          value: cubit.selectedClubName,
                          onChanged: (val)
                          {
                            cubit.chooseClubNameFromDropDownButton(value: val!);
                          },
                          items: cubit.clubsWithoutLeaderData.map((e) => DropdownMenuItem(value: e.name,child: Text(e.name!,textDirection: TextDirection.rtl,),)).toList(),
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
                          value: cubit.selectedLeaderEmail,
                          onChanged: (emailChosen)
                          {
                            cubit.chooseALeaderFromDropDownButton(value: emailChosen!);
                          },
                          items: cubit.usersThatAreNotLeadersData.map((e) => DropdownMenuItem(value: e.email,child: Text(e.email!,textDirection: TextDirection.rtl,),)).toList(),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.h,),
                    MaterialButton(
                        height: 42.5.h,
                        color: mainColor,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        onPressed: ()
                        async
                        {
                          if( cubit.selectedClubName == null || cubit.selectedLeaderEmail == null )
                            {
                              showSnackBar(context: context, message: "برجاء ادخال البيانات كاملة",backgroundColor: Colors.red);
                            }
                          else
                            {
                              UserModel leader = await cubit.getInfoForSelectedLeaderFromDropDownButton(email: cubit.selectedLeaderEmail!);
                              ClubModel club = await cubit.getInfoForClubChosenFromDropDownButton(clubName: cubit.selectedClubName!);
                              await cubit.assignClubLeader(clubName:cubit.selectedClubName!,clubID: club.id.toString(), leaderID: leader.id!, leaderName: leader.name!, leaderEmail: leader.email!);
                            }
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