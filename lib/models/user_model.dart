class Name {
  String first;
  String last;

  Name({
    this.first,
    this.last,
  });

  Name.fromJson(Map<String, dynamic> json) {
    first = json['first'] as String;
    last = json['last'] as String;
  }
}

class User {
  String id;
  String email;
  String username;
  String phoneNumber;

  Name name;

  String organization;

  User(
      {this.id,
      this.email,
      this.username,
      this.phoneNumber,
      this.name});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] as String;
    email = json['email'] as String;
    username = json['username'] as String;
    phoneNumber = json['phoneNumber'] as String;

    name = Name.fromJson(json['name']);

    organization = json['organization'] as String;
  }
}
