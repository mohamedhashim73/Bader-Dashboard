class EventModel{
  String? name;
  String? id;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  String? time;
  String? forPublic;
  String? location;
  String? link;
  List? speakers;
  String? clubName;
  String? clubID;

  EventModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    image = json['image'];
    description = json['description'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    forPublic = json['forPublic'];
    time = json['time'];
    link = json['link'];
    speakers = json['speakers'];
    location = json['location'];
    clubID = json['clubID'];
    clubName = json['clubName'];
  }

}