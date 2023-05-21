class AdminModel{
  String? name;
  String? id;
  String? email;
  String? role;
  String? password;

  AdminModel.fromJson({required Map<String,dynamic> json}){
    name = json['name'];
    email = json['email'].toString().trim();
    id = json['title'];
    role = json['role'];
    password = json['password'];
  }

}