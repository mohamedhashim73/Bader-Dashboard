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
  ContactMeansForClubModel? contactAccounts;  // Todo: Mean Leader Gmail

  ClubModel({required this.id,required this.college,required this.name});

  ClubModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    image = json['image'];
    description = json['description'];
    leaderEmail = json['leaderEmail'];
    leaderID = json['leaderID'];
    college = json['college'];
    leaderName = json['leaderName'];
    committees = json['committees'];
    memberNum = json['memberNum'];
    contactAccounts = json['contactAccounts'] != null ? ContactMeansForClubModel.fromJson(json: json['contactAccounts']) : null;
  }

  // انا بعت داتا ب null لان اللي هيبقي يسند لهم قيمه هو الليدر
  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'id' : id,
      'description' : null,
      'image' : null,
      'leaderEmail' : null,
      'leaderID' : null,
      'college' : college,
      'leaderName' : null,
      'committees' : null,
      'memberNum' : null,
      'contactAccounts' : null,
    };
  }
}

class ContactMeansForClubModel{
  String? phone;
  String? twitter;
  ContactMeansForClubModel({required this.phone, required this.twitter});

  factory ContactMeansForClubModel.fromJson({required Map<String,dynamic> json}) => ContactMeansForClubModel(phone: json['phone'], twitter: json['twitter']);

  Map<String,dynamic> toJson(){
    return {
      'phone' : phone,
      'twitter' : twitter,
    };
  }

}