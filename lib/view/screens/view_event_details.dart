
import 'package:badir_app/view_model/dashboard_cubit/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/event_model.dart';

class ViewEventDetails extends StatelessWidget {
  final EventModel model;
  const ViewEventDetails({Key? key,required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
            appBar: AppBar(title: const Text("تفاصيل الفعالية")),
            body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 12.h),
                child: const Text("سوف يتم عرض بيانات الفعاليه")
            )
        )
    );
  }
}

