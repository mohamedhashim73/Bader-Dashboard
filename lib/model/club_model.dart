class ClubModel{
  String? name;
  int? id;
  String? description;
  String? image;
  String? leaderEmail;
  String? leaderID;
  String? leaderName;
  String? college;
  List? committees;
  int? memberNum;
  int? volunteerHours;
  int? currentEventsNum;
  int? numOfRegisteredMembers;
  List? availableOnlyForThisCollege;
  bool? isAvailable;
  ContactMeansForClubModel? contactAccounts;  // Todo: Mean Leader Gmail

  ClubModel({required this.id,required this.college,required this.name});

  ClubModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    image = json['image'];
    availableOnlyForThisCollege = json['availableOnlyForThisCollege'];
    isAvailable = json['isAvailable'];
    description = json['description'];
    leaderEmail = json['leaderEmail'];
    leaderID = json['leaderID'];
    college = json['college'];
    leaderName = json['leaderName'];
    committees = json['committees'];
    volunteerHours = json['volunteerHours'];
    currentEventsNum = json['currentEventsNum'];
    memberNum = json['memberNum'];
    numOfRegisteredMembers = json['numOfRegisteredMembers'];
    contactAccounts = json['contactAccounts'] != null ? ContactMeansForClubModel.fromJson(json: json['contactAccounts']) : null;
  }

  // انا بعت داتا ب null لان اللي هيبقي يسند لهم قيمه هو الليدر
  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'id' : id,
      'isAvailable' : true,
      'availableOnlyForThisCollege' : [],
      'description' : null,
      'image' : null,
      'leaderEmail' : null,
      'leaderID' : null,
      'volunteerHours' : null,
      'currentEventsNum' : null,
      'college' : college,
      'leaderName' : null,
      'committees' : null,
      'memberNum' : null,
      'numOfRegisteredMembers' : null,
      'contactAccounts' : null,
    };
  }
}

class ContactMeansForClubModel{
  String? email;
  String? twitter;
  ContactMeansForClubModel({required this.email, required this.twitter});

  factory ContactMeansForClubModel.fromJson({required Map<String,dynamic> json}) => ContactMeansForClubModel(email: json['email'], twitter: json['twitter']);

  Map<String,dynamic> toJson(){
    return {
      'email' : email,
      'twitter' : twitter,
    };
  }

}