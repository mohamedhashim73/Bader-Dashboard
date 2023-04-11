class EventModel{
  String? name;
  String? id;
  String? description;
  String? image;
  String? startDate;
  String? endDate;
  String? time;
  bool? forPublic;
  String? location;
  String? link;
  List? speakers;
  String? clubName;
  String? clubID;

  EventModel({required this.speakers,required this.id,required this.startDate,required this.endDate,required this.clubID,required this.name,required this.image,required this.clubName,required this.link,required this.location,required this.forPublic,required this.time});

  EventModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    image = json['image'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    forPublic = json['forPublic'];
    time = json['time'];
    speakers = json['speakers'];
    location = json['location'];
    clubID = json['clubID'];
    clubName = json['clubName'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'id' : id,
      'image' : image,
      'forPublic' : forPublic,
      'startDate' : startDate,
      'endDate' : endDate,
      'time' : time,
      'location' : location,
      'speakers' : speakers,
      'clubID' : clubID,
      'clubName' : clubName,
    };
  }
}