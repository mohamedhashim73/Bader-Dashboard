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
  }
}