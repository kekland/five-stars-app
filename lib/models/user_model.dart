import 'package:five_stars/utils/app_data.dart';

class Name {
  String first;
  String last;

  Name({
    this.first,
    this.last,
  });
  Name.fromString(String name) {
    List<String> arr = name.split(" ");

    first = arr.first;
    last = arr.last;
  }
  Name.fromJson(Map json) {
    first = json['first'] as String;
    last = json['last'] as String;
  }

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
      };

  @override
  String toString() {
    return first + " " + last;
  }
}

class User {
  String uid;
  String username;
  String email;
  String phoneNumber;
  bool verified;
  String organization;
  Name name;

  User({
    this.uid,
    this.organization,
    this.verified,
    this.email,
    this.username,
    this.phoneNumber,
    this.name,
  });

  User.fromJson(Map json) {
    email = json['email'] as String;
    username = json['username'] as String;
    phoneNumber = json['phoneNumber'] as String;
    name = Name.fromJson(json['name']);
    organization = json['organization'] as String;
    verified = json['verified'] as bool;
  }

  Map<String, dynamic> toJson() => {
        "username": username,
        "email": email,
        "phoneNumber": phoneNumber,
        "verified": verified,
        "organization": organization,
        "name": name.toJson(),
      };

  bool get isCurrentUser => AppData.uid == this.uid;
}
