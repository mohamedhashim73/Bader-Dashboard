import 'package:badir_app/Admin/model/event_model.dart';
import 'package:badir_app/shared/components/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/club_model.dart';
import '../model/file_model.dart';

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
    ClubModel model = ClubModel(description:"",name: name,id: lastIdForClubCreated, image: "", college: college, leaderEmail: "", leaderID: "", committees: [], contactAccounts: "", leaderName: "", memberNum: 0);
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).doc(lastIdForClubCreated.toString()).set(model.toJson());
  }

  Future<void> deleteClub({required String clubID}) async {
    await FirebaseFirestore.instance.collection(Constants.kClubsCollectionName).doc(clubID).delete();
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
      'clubIDThatHeLead' : clubID,
    });
  }

  Future<List<EventModel>> getEvents() async {
    List<EventModel> events = [];
    await FirebaseFirestore.instance.collection('Events').get().then((value){
      for( var item in value.docs )
      {
        events.add(EventModel.fromJson(json: item.data()));
      }
    });
    return events;
  }

}