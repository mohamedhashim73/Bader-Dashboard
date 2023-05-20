import 'dart:io';

import 'package:badir_app/Admin/repositories/auth_repo.dart';
import 'package:badir_app/Admin/repositories/dashboard_repo.dart';
import 'package:badir_app/shared/bloc_observer/bloc_observer.dart';
import 'package:badir_app/shared/components/colors.dart';
import 'package:badir_app/Admin/view/screens/create_club_screen.dart';
import 'package:badir_app/Admin/view/screens/dashboard_screen.dart';
import 'package:badir_app/Admin/view/screens/login_screen.dart';
import 'package:badir_app/Admin/view/screens/view_clubs_screen.dart';
import 'package:badir_app/Admin/view_model/auth_view_model/auth_cubit.dart';
import 'package:badir_app/Admin/view_model/home_view_model/dashboard_cubit.dart';
import 'package:badir_app/shared/Constants/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Admin/view/screens/assign_leader_screen.dart';
import 'Admin/view/screens/delete_club_screen.dart';
import 'Admin/view/screens/review_reports_screen.dart';
import 'Admin/view/screens/view_events_screen.dart';
import 'Admin/view/screens/view_reports_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // if( Platform.isAndroid )
  //   {
  //     // لان لو ويب هخليه يبدأ علي طول من تسجيل الدخول
  //     final sharedPref = await SharedPreferences.getInstance();
  //     Constants.kAdminID = sharedPref.getString('adminID');
  //   }
  runApp( const MyApp());
}

class MyApp extends StatelessWidget {
  final Widget? initialRoute;
  const MyApp({super.key,this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context ,child) {
        return MultiBlocProvider(
          providers:
          [
            BlocProvider(create: (context) => AuthCubit(authRepository: AuthRepository()..getAdminData())),
            BlocProvider(create: (context) => DashBoardCubit(dashboardRepository: DashboardRepository())..getAllClubs()..getAllReports()..getEvents())
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: child,
            routes:
            {
              "dashboard_screen" : (context)=> const DashboardScreen(),
              "create_Club" : (context)=> CreateClubScreen(),
              "view_Clubs" : (context)=> const ViewClubsScreen(),
              "view_Reports" : (context)=> const ViewReportsScreen(),
              "view_Events" : (context)=> const ViewEventsScreen(),
              "review_Reports" : (context)=> const ReviewReportsScreen(),
              "delete_Club" : (context)=> const DeleteClubScreen(),
              "assign_Club_Leader" : (context)=> const AssignClubLeaderScreen(),
            },
            theme: ThemeData(
              fontFamily: "Cairo",
              appBarTheme: AppBarTheme(titleTextStyle:TextStyle(color:Colors.white,fontWeight: FontWeight.bold,fontSize: 18.sp),backgroundColor: mainColor,foregroundColor: Colors.white,elevation: 0),
              primaryColor: mainColor,
            ),
          ),
        );
      },
      child: LoginScreen()
      // (Platform.isAndroid || Platform.isIOS) && Constants.kAdminID != null ? const DashboardScreen() : LoginScreen()
    );
  }
}

