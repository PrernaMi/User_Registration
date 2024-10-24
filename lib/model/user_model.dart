class UserModel {
  String name;
  String email;
  String phone;
  String password;

  UserModel(
      {required this.name,
      required this.email,
      required this.password,
      required this.phone});

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        name: map['name'],
        email: map['email'],
        password: map['password'],
        phone: map['phone']);
  }

  Map<String,dynamic> toMap(){
    return {
      'name' : name,
      'phone' : phone,
      'email' : email,
      'password' : password
    };
  }
}
