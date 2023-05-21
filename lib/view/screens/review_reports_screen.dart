
import 'package:badir_app/shared/Constants/constants.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/view/screens/view_club_details.dart';
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:badir_app/shared/components/show_loading_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/report_model.dart';
import '../../view_model/dashboard_cubit/dashboard_states.dart';
import '../widgets/display_dialogs.dart';

class ReviewReportsScreen extends StatelessWidget {
  const ReviewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context);
    if( cubit.annualPlansReports.isEmpty ) cubit.getAllReports();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state)
          {
            if( state is AcceptOrRejectPlanForClubLoadingState ) showLoadingDialog(context: context);
            if( state is ErrorDuringOpenPdfState ) showSnackBar(context: context, message: state.message,backgroundColor: Colors.red);
            if( state is FailedToAcceptOrRejectPlanForClubState )
              {
                Navigator.pop(context);
                showSnackBar(context: context, message: state.message,backgroundColor: Colors.red);
              }
            if( state is AcceptOrRejectPlanForClubSuccessState )
              {
                Navigator.pop(context);
                showSnackBar(context: context, message: "تم إرسال نتيجة المراجعة لقائد النادي");
              }
          },
          builder: (context,state){
            return Scaffold(
                appBar: AppBar(title: const Text("مراجعة التقارير")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                    child: cubit.annualPlansReports.isNotEmpty ?
                    ListView.separated(
                        separatorBuilder: (context,index) => SizedBox(height: 10.h,),
                        itemCount: cubit.annualPlansReports.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return _reportItem(isMobile:isMobile,model: cubit.annualPlansReports[index],context: context);
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
      padding: EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
      decoration: const BoxDecoration(
          color: greyColor
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text("${model.clubName!} - خطة سنوية",style: TextStyle(fontWeight: FontWeight.w600,fontSize: isMobile ? 14.5.sp : 16.5.sp,overflow: TextOverflow.ellipsis),),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children:
            [
              _buttonItem(
                color: mainColor,
                onTap: ()
                {
                  DashBoardCubit.getInstance(context).openPdf(link: model.pdfLink!);
                },
                title: "عرض",
                isMobile: isMobile
              ),
              SizedBox(width: isMobile ? 7.w : 10.w,),
              _buttonItem(
                color: Colors.green,
                onTap: ()
                {
                  DashBoardCubit.getInstance(context).acceptOrRejectPlanForClub(report: model, responseStatus: true);
                },
                title: "موافقة",
                isMobile: isMobile
              ),
              SizedBox(width: isMobile ? 7.w : 10.w,),
              _buttonItem(
                color: Colors.red,
                onTap: ()
                {
                  DashBoardCubit.getInstance(context).acceptOrRejectPlanForClub(report: model, responseStatus: false);
                },
                title: "رفض",
                isMobile: isMobile
              ),
            ],
          )
        ],
      )
  );
}

Widget _buttonItem({required bool isMobile,required String title,required Function() onTap,required Color color}){
  return MaterialButton(
    onPressed: onTap,
    textColor: Colors.white,
    color: color,
    minWidth: isMobile? 50.w : null,
    elevation: 0,
    child: Text(title,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
  );
}

