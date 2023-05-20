import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/widgets/drawer_item.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_states.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DashBoardCubit,DashBoardStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              drawer: DrawerItem(),
              appBar: AppBar(title: const Text("بادر"),),
              body: isMobile?
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.w,vertical: 5.h),
                    child: _dashboardBody(cubit: cubit,isMobile: isMobile),
                  ) :
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 10.h),
                    child: Row(
                      children:
                      [
                        const Expanded(flex: 1,child: SizedBox(),),
                        Expanded(
                          flex: 10,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 15.h),
                            child: _dashboardBody(cubit: cubit,isMobile: isMobile)
                          )
                        ),
                        const Expanded(flex: 1,child: SizedBox(),),
                      ],
                    )
              )
          );
        },
      )
    );
  }
}

Widget _dashboardBody({required DashBoardCubit cubit,required bool isMobile}){
  return Column(
    children:
    [
      Expanded(
        child: Container(
          height:double.infinity,
          width:double.infinity,
          alignment: isMobile? AlignmentDirectional.topStart : AlignmentDirectional.center,
          margin: EdgeInsets.symmetric(vertical: 15.h),
          child: GridView.builder(
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isMobile? 2 : 3,
                  mainAxisSpacing: isMobile ? 20.h : 30.h,
                  crossAxisSpacing: isMobile ? 20.w : 15.w,
                  childAspectRatio: isMobile? 1 : 1.2
              ),
              itemBuilder: (context,index){
                return _categoryItem(
                    context: context,
                    isMobile: isMobile,
                    routeName: cubit.adminCategories[index].routeName.toString(),
                    title: cubit.adminCategories[index].title.toString(),
                    iconData: cubit.adminCategories[index].iconData!
                );
              },
              itemCount: cubit.adminCategories.length
          ),
        ),
      ),
    ],
  );
}

Widget _categoryItem({required bool isMobile,required BuildContext context,required String routeName,required String title,required IconData iconData}){
  return GestureDetector(
    onTap: ()
    {
      Navigator.pushNamed(context,routeName);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 5.h),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(isMobile? 6 : 8),
        border: Border.all(color: Colors.black.withOpacity(0.5))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Icon(iconData,size: isMobile? 25 : 30,),
          SizedBox(height: isMobile? 7.h : 10.h,),
          FittedBox(fit:BoxFit.scaleDown,child: Text(title.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: isMobile? 16.5.sp : 18.sp),))
        ],
      ),
    ),
  );
}
