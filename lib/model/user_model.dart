// import 'package:cloud_firestore/cloud_firestore.dart';
//
// class UserModel {
//   final String fullname;
//   final String emailAddress;
//   final String password;
//   final String userUid;
//   UserModel({
//     required this.fullname,
//     required this.emailAddress,
//     required this.password,
//     required this.userUid,
//   });
//
//   factory UserModel.fromDocument(DocumentSnapshot doc) {
//     return UserModel(
//       fullname: doc['fullname'],
//       emailAddress: doc['emailAddress'],
//       password: doc['password'],
//       userUid: doc['userUid'],
//     );
//   }
// }