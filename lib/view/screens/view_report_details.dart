import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/report_model.dart';

class ViewReportDetails extends StatelessWidget {
  final ReportModel model;
  const ViewReportDetails({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(title: const Text("التفاصيل")),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                child: const Text("Here I will display Pdf for Report")
            )
        )
    );
  }
}

