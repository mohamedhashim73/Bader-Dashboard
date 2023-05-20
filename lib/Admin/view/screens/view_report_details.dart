import 'package:badir_app/Admin/model/club_model.dart';
import 'package:badir_app/Admin/model/report_model.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ViewReportDetails extends StatelessWidget {
  final ReportModel model;
  const ViewReportDetails({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            drawer: DrawerItem(),
            appBar: AppBar(title: const Text("التفاصيل")),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                child: const Text("Here I will display Pdf for Report")
            )
        )
    );
  }
}

