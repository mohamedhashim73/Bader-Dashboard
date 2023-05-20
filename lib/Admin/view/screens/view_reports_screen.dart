import 'package:badir_app/Admin/model/admin_category_model.dart';
import 'package:badir_app/Admin/model/club_model.dart';
import 'package:badir_app/Admin/model/report_model.dart';
import 'package:badir_app/shared/Constants/constants.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportsScreen extends StatelessWidget {
  const ViewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context);
    if( cubit.reports.isEmpty ) cubit.getAllReports();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(title: const Text("عرض التقارير")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                    child: cubit.reports.isNotEmpty ?
                    ListView.separated(
                        separatorBuilder: (context,index) => SizedBox(height: 10.h,),
                        itemCount: cubit.reports.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return _reportItem(isMobile:isMobile,model: cubit.reports[index],context: context);
                        }
                    ) :
                    Center(
                      child: Text("لم يتم اضافه تقارير حتي الآن",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp,color: Colors.grey),),
                    )
                )
            );
          },
        )
    );
  }
}

Widget _reportItem({required bool isMobile,required ReportModel model,required BuildContext context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 15.h),
    decoration: const BoxDecoration(
        color: greyColor
    ),
    child: Row(
      children:
      [
        Expanded(
          child: Text("${model.clubName!} - ${model.reportType == "فعالية" ? "خاص بفعالية" : "ساعات تطوعية"}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: isMobile ? 14.5.sp : 16.5.sp,overflow: TextOverflow.ellipsis),),
        ),
        SizedBox(width: 10.w,),
        MaterialButton(
          onPressed: ()
          {
            DashBoardCubit.getInstance(context).openPdf(link: model.pdfLink!);
          },
          textColor: Colors.white,
          color: mainColor,
          elevation: 0,
          child: Text("عرض",style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
        ),
      ],
    )
  );
}

