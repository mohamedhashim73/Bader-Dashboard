class AdminModel{
  String? name;
  String? id;
  String? email;
  String? role;
  String? password;
  String? gender;
  String? college;
  int? phone;

  AdminModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    email = json['email'].trim();
    id = json['title'];
    role = json['role'];
    password = json['password'];
    gender = json['gender'];
    college = json['college'];
    phone = json['phone'];
  }

  Map<String,dynamic> toJson(){
    return {
      'name' : name,
      'email' : email,
      'password' : password,
      'role' : role,
      'gender' : gender,
      'phone' : phone,
      'id' : id
    };
  }

}