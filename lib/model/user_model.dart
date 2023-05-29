class UserModel {
  String? name;
  String? id;
  String? firebaseMessagingToken;
  String? email;
  String? role;
  String? password;
  String? gender;
  String? college;
  int? phone;
  bool? isALeader;
  String? idForClubLead;
  String? membershipStartDate;
  int? volunteerHoursNumber;
  List? committeesNames;
  List? idForClubsMemberIn;

  UserModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    firebaseMessagingToken = json['firebaseMessagingToken'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    gender = json['gender'];
    college = json['college'];
    phone = json['phone'];
    isALeader = json['isALeader'];
    idForClubLead = json['idForClubLead'];
    membershipStartDate = json['membershipStartDate'];
    committeesNames = json['committeesNames'];
    volunteerHoursNumber = json['volunteerHoursNumber'];
  }
}