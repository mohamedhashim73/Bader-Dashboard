import 'package:badir_app/Admin/model/club_model.dart';
import 'package:badir_app/Admin/shared/components/colors.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/display_dialogs.dart';

class DeleteClubScreen extends StatelessWidget {
  const DeleteClubScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state)
          {
            if( state is DeleteClubSuccessState )
            {
              showSnackBar(context: context, message: "تم حذف النادي بنجاح",backgroundColor: Colors.green,seconds: 2);
            }
          },
          builder: (context,state){
            return Scaffold(
                drawer: const Drawer(),
                appBar: AppBar(title: const Text("حذف نادي")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 15.h),
                    child: cubit.clubs.isNotEmpty ?
                    ListView.separated(
                        itemCount: cubit.clubs.length,
                        shrinkWrap: true,
                        separatorBuilder: (context,index) {
                          return SizedBox(height: 15.h,);
                        },
                        itemBuilder: (context,index)
                        {
                          return _clubItem(model: cubit.clubs[index],cubit: cubit,context: context);
                        }
                    ) :
                    Center(
                      child: Text("لم يتم اضافه أندية حتي الآن",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp,color: Colors.grey),),
                    )
                )
            );
          },
        )
    );
  }
}

Widget _clubItem({required ClubModel model,required DashBoardCubit cubit,required BuildContext context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 15.h),
    decoration: const BoxDecoration(
        color: greyColor
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: FittedBox(fit:BoxFit.scaleDown,child: Text(model.name!,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.5.sp),)),
      trailing: MaterialButton(
        onPressed: ()
        {
          showDialog(
              context: context,
              builder: (context){
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: AlertDialog(
                    content: FittedBox(fit:BoxFit.scaleDown,child: Text("هل تريد حذف النادي بالفعل",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16.5.sp),)),
                    actions:
                    [
                      Padding(
                        padding: EdgeInsets.only(left: 2.5.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:
                          [
                            GestureDetector(
                              child: Text("نعم",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: 15.sp),),
                              onTap: ()
                              {
                                cubit.deleteClub(clubID: model.id.toString());
                                Navigator.pop(context);
                              },
                            ),
                            SizedBox(width: 7.w,),
                            GestureDetector(
                              child: Text("لا",style: TextStyle(color: Colors.red,fontSize: 15.sp,fontWeight: FontWeight.bold),),
                              onTap: ()
                              {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }
          );
        },
        textColor: Colors.white,
        color: Colors.red,
        child: Text("حذف",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      ),
    ),
  );
}
