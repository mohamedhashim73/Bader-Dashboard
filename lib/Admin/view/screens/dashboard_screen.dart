import 'package:badir_app/Admin/model/admin_category_model.dart';
import 'package:badir_app/Admin/shared/components/colors.dart';
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
    final cubit = DashBoardCubit.getInstance(context);
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<DashBoardCubit,DashBoardStates>(
        listener: (context,state){},
        builder: (context,state){
          return Scaffold(
              drawer: DrawerItem(),
              appBar: AppBar(title: const Text("تطبيق بادر"),),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.w,vertical: 10.h),
                child: Row(
                  children:
                  [
                    const Expanded(flex: 1,child: SizedBox(),),
                    Expanded(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: Column(
                          children:
                          [
                           Expanded(
                             child: Container(
                               height:double.infinity,
                               width:double.infinity,
                               alignment: AlignmentDirectional.center,
                               margin: EdgeInsets.symmetric(vertical: 15.h),
                               child: GridView.builder(
                                   shrinkWrap: true,
                                   physics: const BouncingScrollPhysics(),
                                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                     crossAxisCount: 3,
                                     mainAxisSpacing: 30.h,
                                     crossAxisSpacing: 10.w,
                                     childAspectRatio: 1.2
                                   ),
                                   itemBuilder: (context,index){
                                     return _categoryItem(
                                         context: context,
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
                        ),
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

Widget _categoryItem({required BuildContext context,required String routeName,required String title,required IconData iconData}){
  return GestureDetector(
    onTap: ()
    {
      Navigator.pushNamed(context,routeName);
    },
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w,vertical: 5.h),
      decoration: BoxDecoration(
        color: greyColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.black)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Icon(iconData,size: 30,),
          SizedBox(height: 10.h,),
          FittedBox(fit:BoxFit.scaleDown,child: Text(title.toString(),style: TextStyle(fontWeight: FontWeight.w600,fontSize: 18.sp),))
        ],
      ),
    ),
  );
}
