 import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
}

class UserInfo{
  late String email;
  late String name;
  late String phoneNum;
  late int birthYear;
  late int birthMonth;
  late int birthDay;
  late int height;
  late int weight;
  late int skeletalMuscleMass;
  late int fatMass;
  late int leftArmMuscleMass;
  late int rightArmMuscleMass;
  late int leftLegMuscleMass;
  late int rightLegMuscleMass;
  late int torsoMuscleMass;


  UserInfo({required this.email, required this.name, required this.phoneNum, required this.birthYear, required this.birthMonth, required this.birthDay, required this.height,
  required this.weight, required this.skeletalMuscleMass, required this.fatMass, required this.leftArmMuscleMass, required this.rightArmMuscleMass, required this.leftLegMuscleMass, required this.rightLegMuscleMass, required this.torsoMuscleMass});

  Map<String, dynamic> toMap(){
    return {
      'email' : email,
      'name' : name,
      'phoneNum' : phoneNum,
      'birthYear' : birthYear,
      'birthMonth' : birthMonth,
      'birthDay' : birthDay,
      'height' : height,
      'weight' : weight,
      'skeletalMuscleMass' : skeletalMuscleMass,
      'fatMass' : fatMass,
      'leftArmMuscleMass' : leftArmMuscleMass,
      'rightArmMuscleMass' : rightArmMuscleMass,
      'leftLegMuscleMass' : leftLegMuscleMass,
      'rightLegMuscleMass' : rightLegMuscleMass,
      'torsoMuscleMass' : torsoMuscleMass
    };
  }
}