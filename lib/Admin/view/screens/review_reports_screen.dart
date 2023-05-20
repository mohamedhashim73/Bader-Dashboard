import 'package:badir_app/Admin/model/report_model.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/screens/view_report_details.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../widgets/drawer_item.dart';

class ReviewReportsScreen extends StatelessWidget {
  const ReviewReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    if( cubit.reports.isEmpty ) cubit.getAllReports();
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocConsumer<DashBoardCubit,DashBoardStates>(
          listener: (context,state){},
          builder: (context,state){
            return Scaffold(
                drawer: DrawerItem(),
                appBar: AppBar(title: const Text("مراجعة التقارير")),
                body: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                    child: cubit.annualPlansReports.isNotEmpty ?
                    ListView.builder(
                        itemCount: cubit.annualPlansReports.length,
                        shrinkWrap: true,
                        itemBuilder: (context,index){
                          return _reportItem(
                              model: cubit.annualPlansReports[index],
                              context: context,
                              cubit: cubit,
                              listViewIndex: index
                          );
                        }
                    ) :
                    Center(
                      child: Text("لم يتم اضافه خطط سنوية حتي الآن",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17.sp,color: Colors.grey),),
                    )
                )
            );
          },
        )
    );
  }
}

// Todo: listViewIndex get it to get specific report from Cubit.Reports as it is a List ( Get Index from ListView during display Reports throw it )
Widget _reportItem({required ReportModel model,required BuildContext context,required int listViewIndex,required DashBoardCubit cubit}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 10.h),
    decoration: const BoxDecoration(
        color: greyColor
    ),
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Text("${model.clubName!} - ${model.pdfLink!}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16.5.sp,overflow: TextOverflow.ellipsis),),
      trailing: Row(
        children:
        [
          _buttonItem(
              title: "عرض",
              backgroundColor: mainColor,
              onTap: ()
              {
                _openReportPdf(context: context,model: cubit.reports[listViewIndex]);
              }
          ),
          SizedBox(width: 5.w,),
          _buttonItem(
              title: "قبول",
              backgroundColor: Colors.green,
              onTap: ()
              {
                // Todo: Accept Report That sent from Leader .....
              }
          ),
          SizedBox(width: 5.w,),
          _buttonItem(
              title: "رفض",
              backgroundColor: Colors.red,
              onTap: ()
              {
                // Todo: Reject Report That sent from Leader .....
              }
          ),
        ],
      )
    ),
  );
}

Widget _buttonItem({required String title,required Color backgroundColor, required Function() onTap }){
  return MaterialButton(
    onPressed: onTap,
    textColor: Colors.white,
    color: backgroundColor,
    child: Text(title,style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
  );
}
void _openReportPdf({required BuildContext context,required ReportModel model}){
  Navigator.push(context, MaterialPageRoute(builder: (context) => ViewReportDetails(model: model)));
}
