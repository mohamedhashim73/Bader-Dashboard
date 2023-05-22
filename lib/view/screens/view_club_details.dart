import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/club_model.dart';
import '../../view_model/dashboard_cubit/dashboard_states.dart';
import '../widgets/responsive_text.dart';

class ViewClubDetails extends StatelessWidget {
  final ClubModel model;
  const ViewClubDetails({Key? key,required this.model}) : super(key: key);

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
                appBar: AppBar(title: const Text("بيانات النادي")),
                body: Padding(
                      padding: EdgeInsets.symmetric(horizontal: isMobile? 12.w : 50.w,vertical: isMobile? 10.h : 25.h),
                      child: isMobile?
                          _clubDetailsBody(model: model, isMobile: isMobile) :
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
                                      child: _clubDetailsBody(model: model, isMobile: isMobile)
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

Widget _clubDetailsBody({required ClubModel model,required bool isMobile}){
  return ListView(
    shrinkWrap: true,
    physics: isMobile ? const BouncingScrollPhysics() : const NeverScrollableScrollPhysics(),
    children:
    [
      model.image != null ?
      Center(child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        child: Image.network(model.image!,height: 400.h,width: double.infinity,fit: BoxFit.fill,),
      )) :
      Container(
        padding: EdgeInsets.symmetric(vertical: isMobile ? 5.h : 10.h,horizontal: isMobile ? 5.w : 10.w),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.5))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Icon(Icons.image,color: Colors.green,size: isMobile? 20.sp : 30.sp),
            SizedBox(width: isMobile? 5.w : 2.w,),
            FittedBox(
                fit:BoxFit.scaleDown,
                child: Text("لم يتم إضافة شعار للنادي",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 15.sp : 18.sp),
                )
            )
          ],
        ),
      ),
      SizedBox(height: 20.h,),
      Center(child: ResponsiveText(child: Text("نادي ${model.name!}",style: TextStyle(color: mainColor,fontWeight: FontWeight.bold,fontSize: isMobile? 18.sp: 22.sp),textAlign: TextAlign.center,))),
      if( model.description != null )
        Center(
            child: Text(model.description!,
              maxLines:3,textAlign:TextAlign.center,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500,fontSize: 14.sp),
            )
        ),
      SizedBox(height: 12.5.h,),
      Text("القائد",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 15.5.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
        isMobile: isMobile,
        text: model.leaderEmail != null ? model.leaderName! : "لم يتم تعيين قائد حتي الآن"
      ),
      SizedBox(height: 2.5.h,),
      Text("الكليه",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
        isMobile: isMobile,
        text: model.college!
      ),
      SizedBox(height: 2.5.h,),
      Text("عدد الأعضاء",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
        isMobile: isMobile,
        text: model.memberNum != null ? model.memberNum.toString() : "لم يتم تحديد عدد الأعضاء حتي الآن"
      ),
      SizedBox(height: 2.5.h,),
      Text("اللجان",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
      SizedBox(height: 2.5.h,),
      _containerItem(
        isMobile: isMobile,
        text: model.committees != null ? model.committees!.join(" - ") : "لم يتم تحديد اللجان حتي الآن"
      ),
      if( model.contactAccounts != null )
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          SizedBox(height: 2.5.h,),
          Text("حساب الإيميل",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
          SizedBox(height: 2.5.h,),
          _containerItem(
              isMobile: isMobile,
              text: model.contactAccounts!.email!
          ),
          SizedBox(height: 2.5.h,),
          Text("حساب تويتر",style: TextStyle(fontWeight: FontWeight.bold,fontSize: isMobile? 16.sp : 18.sp),),
          SizedBox(height: 2.5.h,),
          _containerItem(
              isMobile: isMobile,
              text: model.contactAccounts!.twitter!
          ),
        ],
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

