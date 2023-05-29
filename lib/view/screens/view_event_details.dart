import 'package:badir_app/model/event_model.dart';
import 'package:badir_app/shared/Constants/enumeration.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/dashboard_cubit/dashboard_states.dart';
import '../widgets/responsive_text.dart';

class EventDetailsScreen extends StatelessWidget {
  final EventModel model;
  const EventDetailsScreen({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
              appBar: AppBar(title: const Text("بيانات الفعالية")),
              body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: isMobile? 12.w : 50.w,vertical: isMobile? 10.h : 25.h),
                  child: isMobile?
                  _eventDetailsBody(model: model, isMobile: isMobile) :
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Row(
                      children:
                      [
                        const Expanded(flex: 1,child: SizedBox(),),
                        Expanded(
                            flex: 10,
                            child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 15.h),
                                child: _eventDetailsBody(model: model, isMobile: isMobile)
                            )
                        ),
                        const Expanded(flex: 1,child: SizedBox(),),
                      ],
                    ),
                  )
              ),
            );
          },
        )
    );
  }
}

Widget _eventDetailsBody({required EventModel model,required bool isMobile}){
  return ListView(
    shrinkWrap: true,
    physics: isMobile ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
    children:
    [
      Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.w),
          child: Image.network(model.image!,height: 400.h,width: double.infinity,fit: BoxFit.fill,),
        ),
      ),
      SizedBox(height: 20.h,),
      Center(child: ResponsiveText(child: Text("فعالية ${model.name!}",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: isMobile? 18.sp: 22.sp),textAlign: TextAlign.center,))),
      Center(
          child: Text(model.description!,maxLines:6,textAlign:TextAlign.center,overflow:TextOverflow.ellipsis,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14.sp),
          )
      ),
      SizedBox(height: 12.5.h,),
      Text("النادي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 15.5.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.clubName!
      ),
      SizedBox(height: 2.5.h,),
      Text("الحالة",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.forPublic == EventForPublicOrNot.public.name ? "للمستخدمين جميعا" : "خاص بأعضاء النادي فقط"
      ),
      SizedBox(height: 2.5.h,),
      Text("المكان",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.location!
      ),
      SizedBox(height: 2.5.h,),
      Text("اللينك",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.link!
      ),
      SizedBox(height: 2.5.h,),
      Text("تاريخ البداية",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.startDate!
      ),
      SizedBox(height: 2.5.h,),
      Text("تاريخ الإنتهاء",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.endDate!
      ),
      SizedBox(height: 2.5.h,),
      Text("التوقيت",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
          isMobile: isMobile,
          text: model.time!
      ),
    ],
  );
}

Widget _containerItem({required String text,required bool isMobile}){
  return SizedBox(
    width: double.infinity,
    child: Card(
        elevation: 0.2,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w,vertical: 10.h),
          child: Text(text,overflow:TextOverflow.ellipsis,textAlign: TextAlign.start,style: TextStyle(color: Colors.black.withOpacity(0.7)),),
        )
    ),
  );
}

