import 'package:badir_app/Admin/model/admin_category_model.dart';
import 'package:badir_app/Admin/model/club_model.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/screens/view_club_details.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewClubsScreen extends StatelessWidget {
  const ViewClubsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state)
          {
            if( state is CreateClubSuccessState )
              {
                cubit.getAllClubs();
              }
          },
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(title: const Text("الأندية")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: isMobile? 10.h : 15.h),
                    child: cubit.clubs.isNotEmpty ?
                        ListView.separated(
                        itemCount: cubit.clubs.length,
                        shrinkWrap: true,
                        separatorBuilder: (context,index)
                        {
                            return SizedBox(height: isMobile? 10.h : 15.h,);
                        },
                        itemBuilder: (context,index){
                          return InkWell(
                              onTap: ()
                              {
                                Navigator.push(context, MaterialPageRoute(builder: (context) => ViewClubDetails(model: cubit.clubs[index])));
                              },
                              child: _clubItem(isMobile : isMobile ,model: cubit.clubs[index],context: context,cubit: cubit,index: index)
                          );
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

Widget _clubItem({required bool isMobile ,required ClubModel model,required BuildContext context,required DashBoardCubit cubit,required int index}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: isMobile? 12.w : 8.w,vertical: isMobile? 7.h : 15.h),
    decoration: const BoxDecoration(
        color: greyColor
    ),
    child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: FittedBox(fit:BoxFit.scaleDown,child: Text(model.name!,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.5.sp),)),
        trailing: MaterialButton(
          onPressed: ()
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ViewClubDetails(model: cubit.clubs[index])));
          },
          textColor: Colors.white,
          color: mainColor,
          child: Text("عرض",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
        ),
    ),
  );
}
