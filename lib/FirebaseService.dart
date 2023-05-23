import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
}

class UserInfo{
  late String email;
  late String password;
  late String name;
  late String phoneNum;

  UserInfo({required this.email, required this.password, required this.name, required this.phoneNum});

  Map<String, dynamic> toMap(){
    return {
      'email' : email,
      'password' : password,
      'name' : name,
      'phoneNum' : phoneNum,
    };
  }
}