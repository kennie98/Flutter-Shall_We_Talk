import 'package:shall_we_talk/models/user_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;
  DatabaseService({this.uid});

  // collection reference
  final CollectionReference userInfoCollection =
      Firestore.instance.collection('userInfo');

  Future<void> updateUserData(
      String name, String gender, int age, String selfIntro, bool pro) async {
    return await userInfoCollection.document(uid).setData({
      'name': name,
      'gender': gender,
      'age': age,
      'self_intro': selfIntro,
      'pro': pro,
    });
  }

  // brew list from snapshot
  List<UserInfo> _userInfoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return UserInfo(
        uid: doc.documentID,
        name: doc.data['name'] ?? '',
        gender: doc.data['gender'] ?? '',
        age: doc.data['age'] ?? '0',
        selfIntro: doc.data['selfIntro'] ?? '',
        pro: doc.data['pro'] ?? false,
      );
    }).toList();
  }

  // user data from snapshots
  UserInfo _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserInfo(
      uid: uid,
      name: snapshot.data['name'],
      gender: snapshot.data['gender'],
      age: snapshot.data['age'],
      selfIntro: snapshot.data['selfIntro'],
      pro: snapshot.data['pro'],
    );
  }

  // get userInfo stream
  Stream<List<UserInfo>> get userInfo {
    return userInfoCollection.snapshots().map(_userInfoListFromSnapshot);
  }

  // get user doc stream
  Stream<UserInfo> get userInfoOfUid {
    return userInfoCollection
        .document(uid)
        .snapshots()
        .map(_userDataFromSnapshot);
  }
}
