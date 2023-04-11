class MeetingModel{
  String? id;
  String? description;
  String? time;
  String? date;
  String? location;
  String? link;
  String? clubName;
  String? clubID;

  MeetingModel({required this.id,required this.description,required this.date,required this.time,required this.clubID,required this.clubName,required this.link,required this.location});

  MeetingModel.fromJson({required Map<String,dynamic> json}){
    id = json['id'];
    date = json['date'];
    description = json['description'];
    time = json['time'];
    location = json['location'];
    link = json['link'];
    clubID = json['clubID'];
    clubName = json['clubName'];
  }

  Map<String,dynamic> toJson(){
    return {
      'id' : id,
      'description' : description,
      'date' : date,
      'time' : time,
      'location' : location,
      'link' : link,
      'clubID' : clubID,
      'clubName' : clubName,
    };
  }
}