
import 'package:badir_app/view/screens/view_event_details.dart';
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/event_model.dart';
import '../../shared/components/colors.dart';
import '../../view_model/dashboard_cubit/dashboard_states.dart';

class ViewEventsScreen extends StatelessWidget {
  const ViewEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context)..getEvents();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(title: const Text("الفعاليات")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: isMobile ? 12.w : 6.w,vertical: 12.h),
                    child: cubit.events.isNotEmpty ?
                    ListView.separated(
                        itemCount: cubit.events.length,
                        separatorBuilder: (context,index) => SizedBox(height: 10.h,),
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return GestureDetector(
                              onTap: ()
                              {
                                _openEventDetails(context: context, model: cubit.events[index]);
                              },
                              child: _eventItem(model: cubit.events[index],context: context, isMobile: isMobile)
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

Widget _eventItem({required EventModel model,required BuildContext context,required bool isMobile}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: isMobile ? 6.w : 2.5.w,vertical: 10.h),
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
  Navigator.push(context, MaterialPageRoute(builder: (context) => EventDetailsScreen(model: model)));
}
