import 'dart:io';
import 'package:badir_app/Admin/model/event_model.dart';
import 'package:badir_app/Admin/model/notification_model.dart';
import 'package:badir_app/Admin/repositories/dashboard_repo.dart';
import 'package:badir_app/shared/components/constants.dart';
import 'package:badir_app/shared/components/enumeration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jiffy/jiffy.dart';
import '../../model/admin_category_model.dart';
import '../../model/club_model.dart';
import '../../model/file_model.dart';
import '../../model/user_model.dart';
import 'dashboard_states.dart';
import 'package:flutter/material.dart';

class DashBoardCubit extends Cubit<DashBoardStates>{
  DashboardRepository dashboardRepository;
  DashBoardCubit({required this.dashboardRepository}) : super(DashboardInitialState());

  // Todo: Get Instance From Cubit Class
  static DashBoardCubit getInstance(BuildContext context) => BlocProvider.of(context);

  // TODO : SEND A NOTIFICATION TO USER AFTER MAKE HIM A LEADER ON SPECIFIC CLUB
  Future<bool> sendNotifyToUserAfterMakingHimALeaderOnSpecificClub({required String receiverID,required String clubID,required String clubName}) async {
    String? adminUid = FirebaseAuth.instance.currentUser!.uid;
    final model = NotifyModel(
        notifyDate: Constants.getTimeNow(),
        clubID: clubID,
        notifyMessage: 'لقد تم تعيينك ك أدمن ل $clubName',
        fromAdmin: true,
        senderID: adminUid,
        notifyType: NotificationType.adminAskYouToBeALeaderOnClubThatHeSpecified.name
    );
    try
    {
      await FirebaseFirestore.instance.collection(Constants.kUsersCollectionName).doc(receiverID).
      collection(Constants.kNotificationsCollectionName).add(model.toJson());
      return true;
    }
    on FirebaseException catch(e)
    {
      return false;
    }
  }

  String? selectedCollege;
  void chooseCollege({required String value}){
    selectedCollege = value;
    emit(ChooseCollegeState());
  }

  // ده هتتعرض في dropDownButton عند انشاء نادي
  List<String> colleges = ["كليه حاسبات ومعلومات","كليه هندسه","كليه صيدله","كليه تمريض","كليه طب","كليه تربيه رياضيه"];

  List<CategoryModel> adminCategories =
  [
    CategoryModel(title: "انشاء نادي", iconData: Icons.add,routeName: "create_Club"),
    CategoryModel(title: "حذف نادي", iconData: Icons.clear,routeName: "delete_Club"),
    // CategoryModel(title: "الأندية", iconData: Icons.slideshow_sharp,routeName: "view_Clubs"),
    CategoryModel(title: "عرض التقارير", iconData: Icons.display_settings,routeName: "view_Reports"),
    CategoryModel(title: "تعيين قائد", iconData: Icons.select_all,routeName: "assign_Club_Leader"),
    CategoryModel(title: "مراجعة التقارير", iconData: Icons.preview,routeName: "review_Reports"),
  ];

  // TODO: Get ALl Users to choose between them on select Leader ( Related to : Assign Leader to Club Screen )
  List<UserModel> usersThatAreNotLeadersData = [];
  void getUsersThatAreNotLeaders() async {
    usersThatAreNotLeadersData.clear();
    await FirebaseFirestore.instance.collection(Constants.kUsersCollectionName).get().then((value){
      for( int count = 0 ; count < value.docs.length ; count++ )
        {
          // Todo: عشان لو بالفعل قائد لنادي متظهرش الداتا بتاعته
          if( value.docs[count].data()['isALeader'] == false )
            {
              usersThatAreNotLeadersData.add(UserModel.fromJson(json: value.docs[count].data()));
            }
        }
      debugPrint("Users number is : ${usersThatAreNotLeadersData.length}");
      emit(GetUsersDataSuccessState());
    });
  }

  // Todo: ده هستدعيها اما الادمن يضغط علي تعيين القائد في الاخر بعد اما اختار البريد تبع القائد من خلال dropDownButton ( Related to : Assign Leader to Club Screen )
  Future<UserModel> getInfoForSelectedLeaderFromDropDownButton({required String email}) async {
    return usersThatAreNotLeadersData.firstWhere((element) => element.email!.trim() == email.trim());
  }

  // TODO: ده عشان امرر الايميل لل DropDownButton  ( Related to : Assign Leader to Club Screen )
  String? selectedLeaderEmail;
  void chooseALeaderFromDropDownButton({required String value}){
    selectedLeaderEmail = value;
    emit(ChooseALeaderSuccessState());
  }

  // TODO: Get ALl Users to choose between them on select Leader ( Related to : Assign Leader to Club Screen )
  List<ClubModel> clubsWithoutLeaderData = [];
  Future<void> getClubsWithoutLeader() async {
    clubsWithoutLeaderData.clear();
    for( int count = 0 ; count < clubs.length ; count++ )
    {
      if( clubs[count].leaderID == null || clubs[count].leaderID!.isEmpty )
        {
          clubsWithoutLeaderData.add(clubs[count]);
        }
    }
    debugPrint("Clubs that without leader number is : ${clubsWithoutLeaderData.length}");
    emit(GetClubsWithoutLeaderSuccessState());
  }

  // TODO: ده عشان امرر اسم النادي لل DropDownButton ( Related to : Assign Leader to Club Screen )
  String? selectedClubName;
  void chooseClubNameFromDropDownButton({required String value}){
    selectedClubName = value;
    emit(ChooseClubNameSuccessState());
  }

  // Todo: ده هستدعيها اما الادمن يضغط علي تعيين القائد في الاخر بعد اما اختار البريد تبع القائد من خلال dropDownButton  ( Related to : Assign Leader to Club Screen )
  Future<ClubModel> getInfoForClubChosenFromDropDownButton({required String clubName}) async {
    return clubs.firstWhere((element) => element.name!.trim() == clubName.trim());
  }

  // Todo: Responsible to change password by click on Forget Password Button
  Future<void> createClub({required String name,required String college}) async {
    emit(CreateClubLoadingState());
    try {
      await dashboardRepository.createClub(name: name,college: college.trim());
      await getAllClubs();
      await getClubsWithoutLeader();
      emit(CreateClubSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To create Club, reason is : ${e.message}");
      emit(FailedToCreateClubState());
    }
  }

  // Todo: Remove Club
  Future<void> deleteClub({required String clubID}) async {
    emit(DeleteClubLoadingState());
    try {
      await dashboardRepository.deleteClub(clubID: clubID);
      await getAllClubs();
      emit(DeleteClubSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To Remove Club, reason is : ${e.message}");
      emit(FailedToDeleteClubState());
    }
  }

  // Todo: Assign Club Leader
  Future<void> assignClubLeader({required String clubName,required String clubID,required String leaderID,required String leaderName,required String leaderEmail}) async {
    emit(AssignLeaderToClubLoadingState());
    try
    {
      await dashboardRepository.assignClubLeader(clubID: clubID, leaderID: leaderID, leaderEmail: leaderEmail, leaderName: leaderName);
      // Todo: Send Notification to Leader that you assigned to Know about his new role
      bool sendNotification = await sendNotifyToUserAfterMakingHimALeaderOnSpecificClub(clubID: clubID,clubName: clubName,receiverID: leaderID);
      if( sendNotification == true )
        {
          emit(AssignLeaderToClubSuccessState());
        }
      else
        {
          emit(FailedToAssignLeaderToClubState());
        }
    }
    on FirebaseException catch(e){
      debugPrint("Error during assign Leader to Club, reason : ${e.message}");
      emit(FailedToAssignLeaderToClubState());
    }
  }

  // Todo: Get Clubs Info
  List<ClubModel> clubs = [];
  Future<void> getAllClubs() async {
    emit(GetClubsLoadingState());
    try
    {
      clubs = await dashboardRepository.getClubs();
      await getClubsWithoutLeader();
      emit(GetClubsSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To get Clubs, reason is : ${e.message}");
      emit(FailedToGetClubsState());
    }
  }

  // Todo: Get Events Info
  List<EventModel> events = [];
  Future<void> getEvents() async {
    emit(GetEventsLoadingState());
    try {
      events = await dashboardRepository.getEvents();
      emit(GetEventsSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To get Events, reason is : ${e.message}");
      emit(FailedToGetEventsState());
    }
  }

  // Todo: Get Reports to Display on ReportsView Screen
  List<ReportModel> reports = [];
  Future<void> getReports() async {
    emit(GetReportsLoadingState());
    try {
      reports = await dashboardRepository.getReports();
      emit(GetReportsSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To get Reports, reason is : ${e.message}");
      emit(FailedToGetReportsState());
    }
  }

}