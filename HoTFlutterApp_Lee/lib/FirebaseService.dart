 import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
}

class UserInfo{
  late String email;
  late String name;
  late String phoneNum;

  UserInfo({required this.email, required this.name, required this.phoneNum});

  Map<String, dynamic> toMap(){
    return {
      'email' : email,
      'name' : name,
      'phoneNum' : phoneNum,
    };
  }
}