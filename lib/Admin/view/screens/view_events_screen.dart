import 'package:badir_app/Admin/model/admin_category_model.dart';
import 'package:badir_app/Admin/model/club_model.dart';
import 'package:badir_app/Admin/model/event_model.dart';
import 'package:badir_app/Admin/model/file_model.dart';
import 'package:badir_app/Admin/shared/components/colors.dart';
import 'package:badir_app/Admin/view/screens/view_club_details.dart';
import 'package:badir_app/Admin/view/screens/view_event_details.dart';
import 'package:badir_app/Admin/view/screens/view_report_details.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewEventsScreen extends StatelessWidget {
  const ViewEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                drawer: DrawerItem(),
                appBar: AppBar(title: const Text("الفعاليات")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                    child: cubit.reports.isNotEmpty ?
                    ListView.builder(
                        itemCount: cubit.reports.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return GestureDetector(
                              onTap: ()
                              {
                                _openEventDetails(context: context, model: cubit.events[index]);
                              },
                              child: _eventItem(model: cubit.events[index],context: context)
                          );
                        }
                    ) :
                    Center(
                      child: Text("لم يتم اضافه فعاليات حتي الآن",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp,color: Colors.grey),),
                    )
                )
            );
          },
        )
    );
  }
}

Widget _eventItem({required EventModel model,required BuildContext context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
    decoration: const BoxDecoration(
        color: greyColor
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: FittedBox(fit:BoxFit.scaleDown,child: Text("${model.clubName!} - ${model.name!}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.5.sp),)),
      trailing: MaterialButton(
        onPressed: ()
        {
          _openEventDetails(context: context, model: model);
        },
        textColor: Colors.white,
        color: mainColor,
        child: Text("عرض",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
      ),
    ),
  );
}

void _openEventDetails({required BuildContext context,required EventModel model})
{
  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewEventDetails(model: model)));
}
