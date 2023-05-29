import 'package:badir_app/view_model/auth_cubit/auth_cubit.dart';
import 'package:badir_app/view_model/auth_cubit/auth_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/components/colors.dart';
import '../../view_model/dashboard_cubit/dashboard_cubit.dart';

class DrawerItem extends StatelessWidget{
  List<Map<String,dynamic>> drawerData = [
    {
      'title' : 'خدماتي',
      'iconData' : Icons.home,
      'routeName' : 'dashboard_screen'
    },
    {
      'title' : 'الفعاليات',
      'iconData' : Icons.event_available_sharp,
      'routeName' : 'view_Events'
    },
    {
      'title' : 'الأندية',
      'iconData' : Icons.view_agenda,
      'routeName' : 'view_Clubs'
    },
    {
      'title' : 'تسجيل خروج',
      'iconData' : Icons.logout,
      'routeName' : 'login_screen'
    },
  ];

  DrawerItem({super.key});
  @override
  Widget build(BuildContext context){
    AuthCubit cubit = AuthCubit.getInstance(context);
    if( cubit.adminModel == null ) cubit.getAdminInfo();
    return Drawer(
        child: BlocBuilder<AuthCubit,AuthStates>(
          buildWhen: (pastState,currentState) => currentState is GetAdminDataSuccessState,
          builder: (context,state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
              [
                if( cubit.adminModel != null ) UserAccountsDrawerHeader(
                  decoration: const BoxDecoration(
                      color: mainColor
                  ),
                  accountName: Text(cubit.adminModel!.name!),
                  accountEmail: Text(cubit.adminModel!.email!),
                  currentAccountPicture: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.person,color: Colors.black,),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: drawerData.length,
                      itemBuilder: (context,index){
                        return ListTile(
                          onTap: ()
                          {
                            // 4 => 0 1 2 3
                            if( index == drawerData.length-1 )        // TODO: Mean هو كده في تسجيل الخروج
                            {
                              Navigator.pushReplacementNamed(context, drawerData[index]['routeName']);
                            }
                            else
                            {
                              Navigator.pushNamed(context, drawerData[index]['routeName']);
                            }
                          },
                          leading: Text(drawerData[index]['title']),
                          trailing: Icon(drawerData[index]['iconData']),
                        );
                      }
                  ),
                )
              ],
            );
          }
        )
    );
  }
}