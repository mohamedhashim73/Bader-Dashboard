class UserModel {
  String? name;
  String? id;
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
  String? committeeName;

  UserModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    id = json['id'];
    email = json['email'];
    role = json['role'];
    password = json['password'];
    gender = json['gender'];
    college = json['college'];
    phone = json['phone'];
    isALeader = json['isALeader'];
    idForClubLead = json['idForClubLead'];
    membershipStartDate = json['membershipStartDate'];
    committeeName = json['committeeName'];
    volunteerHoursNumber = json['volunteerHoursNumber'];
  }
}