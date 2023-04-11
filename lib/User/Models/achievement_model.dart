class AchievementModel{
  int? totalHours;
  int? eventsNum;
  int? membersOfMonth;
  String? clubName;
  String? clubID;

  AchievementModel({required this.totalHours,required this.eventsNum,required this.membersOfMonth,required this.clubID,required this.clubName});

  AchievementModel.fromJson({required Map<String,dynamic> json}){
    totalHours = json['totalHours'];
    eventsNum = json['eventsNum'];
    membersOfMonth = json['membersOfMonth'];
    clubID = json['clubID'];
    clubName = json['clubName'];
  }

  Map<String,dynamic> toJson(){
    return {
      'totalHours' : totalHours,
      'eventsNum' : eventsNum,
      'membersOfMonth' : membersOfMonth,
      'clubID' : clubID,
      'clubName' : clubName,
    };
  }
}