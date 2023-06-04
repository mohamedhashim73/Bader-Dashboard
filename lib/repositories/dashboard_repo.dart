import 'dart:convert';

import 'package:badir_app/model/event_model.dart';
import 'package:badir_app/model/notification_model.dart';
import 'package:badir_app/shared/Constants/constants.dart';
import 'package:badir_app/shared/Constants/enumeration.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/club_model.dart';
import '../model/report_model.dart';
import 'package:http/http.dart' as http;

class DashboardRepository{

  Future<int> getIdForLastClubCreated() async {
    int idForLastClubCreated = 0;
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).get().then((value){
      if(value.docs.isEmpty)
        {
          idForLastClubCreated = 0;
        }
      else
        {
          idForLastClubCreated = int.parse(value.docs.last.id);
        }
    });
    return idForLastClubCreated;
  }

  Future<void> createClub({required String name,required String college}) async {
    int lastIdForClubCreated = await getIdForLastClubCreated();
    lastIdForClubCreated++;  // lastIdForClubCreated = lastIdForClubCreated + 1 ;
    ClubModel model = ClubModel(name: name,id: lastIdForClubCreated, college: college);
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).doc(lastIdForClubCreated.toString()).set(model.toJson());
  }

  Future<void> deleteClub({required ClubModel club}) async {
    if( club.leaderID != null )
      {
        await FirebaseFirestore.instance.collection(Constants.kUsersCollectionName).doc(club.leaderID!).update({
          "idForClubLead" : null,
          "isALeader" : false
        });
      }
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).doc(club.id.toString()).delete();
  }

  Future<List<ClubModel>> getClubs() async {
    List<ClubModel> clubs = [];
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).get().then((value){
      for( var item in value.docs )
      {
        clubs.add(ClubModel.fromJson(json: item.data()));
      }
    });
    return clubs;
  }

  // Three reports => "خطة سنوية","فعالية","ساعات تطوعية"
  Future<List<ReportModel>> getAllReports() async {
    List<ReportModel> reports = [];
    await FirebaseFirestore.instance.collection(Constants.kReportsCollectionName).get().then((value){
      for( var item in value.docs )
      {
        reports.add(ReportModel.fromJson(json: item.data()));
      }
    });
    return reports;
  }

  Future<List<ReportModel>> getReports() async {
    List<ReportModel> reports = [];
    await FirebaseFirestore.instance.collection('Reports').get().then((value){
      for( var item in value.docs )
      {
        reports.add(ReportModel.fromJson(json: item.data()));
      }
    });
    return reports;
  }

  // Todo: Assign Club Leader
  Future<void> assignClubLeader({required String clubID,required String leaderID,required String leaderEmail,required String leaderName}) async {
    // Todo: Update Club Data | leader info on its Row ( Object Data )
    await FirebaseFirestore.instance.collection('Clubs').doc(clubID).update(
        {
          'leaderID' : leaderID,
          'leaderEmail' : leaderEmail,
          'leaderName' : leaderName
        }
    );
    // TODO: Update LeaderInfo on FireStore | isLeader = true as he became a Leader
    await FirebaseFirestore.instance.collection(Constants.kUsersCollectionName).doc(leaderID).update({
      'isALeader' : true,
      'idForClubLead' : clubID,
    });
  }

  Future<List<EventModel>> getEvents() async {
    List<EventModel> events = [];
    await FirebaseFirestore.instance.collection(Constants.kEventsCollectionName).get().then((value) async {
      for( var item in value.docs )
      {
        events.add(EventModel.fromJson(json: item.data()));
      }
    });
    return events;
  }

  Future<bool> sendNotification({required String receiverID,required NotifyModel notifyModel}) async {
    try
    {
      await FirebaseFirestore.instance.collection(Constants.kUsersCollectionName).doc(receiverID).collection(Constants.kNotificationsCollectionName).add(notifyModel.toJson());
      return true;
    }
    on FirebaseException catch(e){
      return false;
    }
  }

  Future<bool> notifyUserOrAllUsersUsingFCMAPI({String? receiverFirebaseFCMToken,required NotificationType notifyType,required String notifyBody,required bool toAllUsersNotToSpecificOne}) async {
    try
    {
      Uri apiUri = Uri.parse("https://fcm.googleapis.com/fcm/send");
      await http.post(
          apiUri,
          headers:
          {
            'Content-Type': "application/json",
            'Authorization': Constants.serverKey
          },
          body: jsonEncode(
              {
                // TODO: Topics/all لان اي حد بيسجل في التطبيق بخليه يعمل subscribe to this topic
                "to": toAllUsersNotToSpecificOne ? "/topics/all" : receiverFirebaseFCMToken!,
                "notification":
                {
                  "title": "بادر",
                  "body": notifyBody,
                  "mutable_content": true,
                  "sound": "default"
                },
                "priority": "high",
                "data":
                {
                  "type": notifyType.name,
                }
              }
          )
      );
      return true;
    }
    on FirebaseException catch(e){
      return false;
    }
  }

  Future<ClubModel> getDataForSpecificClub({required String clubID}) async {
    late ClubModel club;
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).doc(clubID).get().then((value) async {
      club = ClubModel.fromJson(json: value.data()!);
    });
    return club;
  }

  Future<void> acceptOrRejectPlanForClub({required ReportModel report,required bool responseStatus}) async {
    ClubModel clubModel = await getDataForSpecificClub(clubID: report.clubID!);   // TODO: عشان بس محتاج id بتاع القائد عشان ابعت له notification
    NotifyModel notifyModel = NotifyModel(receiveDate: Constants.getTimeNow(), notifyType: responseStatus ? NotificationType.acceptPlanForClubYouLead.name : NotificationType.rejectPlanForClubYouLead.name, fromAdmin: true, notifyMessage: responseStatus ? "لقد تم قبول الخطة السنوية التي قمت بتقديمها لنادي ${report.clubName}" : "لقد تم رفض الخطة السنوية التي قمت بتقديمها لنادي ${report.clubName}", clubID: report.clubID);
    await sendNotification(receiverID: clubModel.leaderID!, notifyModel: notifyModel);
    if( responseStatus )
      {
        // TODO: عشان بعدين في الاسكرينه اعرض كلمه تمت الموافقه بالفعل مثلا
        await FirebaseFirestore.instance.collection(Constants.kReportsCollectionName).doc(report.reportID).update({
          'isAccepted' : true
        });
      }
    else
      {
        // TODO: هحذفها في حاله تم الرفض فقط
        await FirebaseFirestore.instance.collection(Constants.kReportsCollectionName).doc(report.reportID).delete();
      }
  }

}