class UserSingleton {
  UserSingleton._internal();

  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  late String? email;
  late String uid;

  void setUserInfo(String? newEmail, String newUid) {
    email = newEmail;
    uid = newUid;
  }
}