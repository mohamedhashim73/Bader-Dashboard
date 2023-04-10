import 'package:badir_app/Admin/model/event_model.dart';
import 'package:badir_app/Admin/repositories/dashboard_repo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/admin_category_model.dart';
import '../../model/club_model.dart';
import '../../model/file_model.dart';
import 'dashboard_states.dart';
import 'package:flutter/material.dart';

class DashBoardCubit extends Cubit<DashBoardStates>{
  DashboardRepository dashboardRepository;
  DashBoardCubit({required this.dashboardRepository}) : super(DashboardInitialState());

  // Todo: Get Instance From Cubit Class
  static DashBoardCubit getInstance(BuildContext context) => BlocProvider.of(context);

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

  // Todo: Responsible to change password by click on Forget Password Button
  Future<void> createClub({required String name,required String college}) async {
    emit(CreateClubLoadingState());
    try {
      await dashboardRepository.createClub(name: name,college: college.trim());
      await getClubs();
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
      await getClubs();
      emit(DeleteClubSuccessState());
    }
    on FirebaseException catch(e)
    {
      debugPrint("Failed To Remove Club, reason is : ${e.message}");
      emit(FailedToDeleteClubState());
    }
  }

  // Todo: Assign Club Leader
  Future<void> assignClubLeader({required String clubID,required String leaderID,required String leaderName,required String leaderEmail}) async {
    emit(AssignLeaderToClubLoadingState());
    try{
      await dashboardRepository.assignClubLeader(clubID: clubID,leaderEmail: leaderEmail,leaderID: leaderID,leaderName: leaderName);
      // Todo: Send Notification to Leader that you assigned to Know about his new role
      emit(AssignLeaderToClubSuccessState());
    }
    on FirebaseException catch(e){
      debugPrint("Error during assign Leader to Club, reason : ${e.message}");
      emit(FailedToAssignLeaderToClubState());
    }
  }

  // Todo: Get Clubs Info
  List<ClubModel> clubs = [];
  Future<void> getClubs() async {
    emit(GetClubsLoadingState());
    try {
      clubs = await dashboardRepository.getClubs();
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

  // Todo: .................. Related To Leader ( User App ) ............................
  /*
  // Todo: Related to Upload Pdf for Reports
  File? pdfFile;
  void selectPdf() async {
    final pickedFile = await FilePicker.platform.pickFiles(allowedExtensions: ['pdf']);
    if( pickedFile != null )
      {
        pdfFile = File(pickedFile.files.single.path!);
        emit(SelectPdfSuccessState());
      }
    else
      {
        debugPrint("Failed To Choose Pdf to Upload it with Club Info");
        emit(FailedToSelectPdfState());
      }
  }

  // Todo: Related to Upload Image with Club Data
  File? clubImageFile;
  void selectClubImage() async {
    var pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
    if( pickedImage != null )
    {
      clubImageFile = File(pickedImage.path);
      emit(SelectImageSuccessState());
    }
    else
    {
      debugPrint("Failed To Choose Image to Upload it with Club Info");
      emit(FailedToSelectImageState());
    }
  }

  void cancelClubImage(){
    clubImageFile = null;
    emit(CancelClubImageState());
  }

  Future<String> uploadClubImageToFireStorage() async {
    Reference imageReference = FirebaseStorage.instance.ref('Clubs/${basename(clubImageFile!.path)}');
    await imageReference.putFile(clubImageFile!);
    String clubImage = await imageReference.getDownloadURL();
    debugPrint("Club Image after upload is : $clubImage");
    return clubImage;
  }
   */

}