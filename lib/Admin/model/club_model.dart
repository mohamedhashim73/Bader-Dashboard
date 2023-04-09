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
  String? contactAccounts;  // Todo: Mean Leader Gmail

  ClubModel({required this.committees,required this.description,required this.id,required this.memberNum,required this.contactAccounts,required this.leaderName,required this.name,required this.image,required this.college,required this.leaderEmail,required this.leaderID});

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
    contactAccounts = json['contactAccounts'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'id' : id,
      'description' : description,
      'image' : image,
      'leaderEmail' : leaderEmail,
      'leaderID' : leaderID,
      'college' : college,
      'leaderName' : leaderName,
      'committees' : committees,
      'memberNum' : memberNum,
      'contactAccounts' : contactAccounts,
    };
  }
}