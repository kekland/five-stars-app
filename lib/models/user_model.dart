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

  @override
  String toString() {
    return first + " " + last;
  }
}

class User {
  String id;
  String email;
  String username;
  String phoneNumber;

  Name name;

  String organization;

  List<String> cargo;
  List<String> vehicles;

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

    cargo = (json['cargo'] as List<dynamic>).cast<String>();
    vehicles = (json['vehicles'] as List<dynamic>).cast<String>();
  }
}
