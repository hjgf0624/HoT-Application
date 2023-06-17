class UserSingleton {
  UserSingleton._internal();

  static final UserSingleton _instance = UserSingleton._internal();

  factory UserSingleton() {
    return _instance;
  }

  late String uid;
  late Map? user_data;

  void setUserInfo(String uid, Map<String, dynamic>? user_data) {
    this.uid = uid;
    this.user_data = user_data;
  }
}