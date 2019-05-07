class AppData {
  static String firstName;
  static String middleName;
  static String lastName;
  static bool loggedIn = false;

  static String phoneNumber;
  static String city;

  static String getName() {
    if(loggedIn) {
      return (lastName ?? "") + " " + (firstName ?? "") + " " + (lastName ?? "");
    }
    else {
      return "Не авторизован";
    }
  }
}