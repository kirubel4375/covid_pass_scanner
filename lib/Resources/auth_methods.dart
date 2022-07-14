import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covid_pass_scanner/Models/user_info.dart';
import 'package:covid_pass_scanner/Models/user_model.dart';
class AuthMethods{
  final FirebaseFirestore _fireStore = FirebaseFirestore.instance;

  Future<UserModel?> getEmployeeInfo(String email)async{
    DocumentSnapshot<Map<String, dynamic>> doc = await _fireStore.collection("users").doc(email).get();
    if(doc.data() == null){
      return null;
    }
      UserModel userModel = UserModel.fromJson(doc.data());
      return userModel;
  }
  Future<UserInfo?> getEmployeeDetailInfo(String email, String uid) async{
    DocumentSnapshot<Map<String, dynamic>> doc = await _fireStore.collection("users").doc(email).collection("info").doc(uid).get();
    if(doc.data()==null){
      return null;
    }
    UserInfo userInfo = UserInfo.fromJson(doc.data());
    return userInfo;
  }
}