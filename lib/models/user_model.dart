

class UserModel {
  var created_at, updated_at,first_name,last_name,username,password,personal_code,role,api_token;

  UserModel();

  UserModel.fromJson(json){

  first_name = json['first_name'].toString();
  last_name = json['last_name'].toString();
  username = json['username'].toString();
  password = json['password'].toString();
  personal_code = json['personal_code'].toString();
  role = json['role'].toString();
  created_at = json['created_at'].toString();
  updated_at = json['updated_at'].toString();

  }


}


