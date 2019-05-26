class User {
  int id;
  String email;
  String username;
  String phoneNumber;

  String firstName;
  String middleName;
  String lastName;

  String organization;

  User({this.id, this.email, this.username, this.phoneNumber, this.firstName, this.middleName, this.lastName});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as int;
    email = json['email'] as String;
    username = json['username'] as String;
    phoneNumber = json['phoneNumber'] as String;

    firstName = json['firstName'] as String;
    middleName = '';
    lastName = json['lastName'] as String;
    
    organization = json['organization'] as String;
  }
}