import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseHelper {
  static FireBaseHelper fireBaseHelper = FireBaseHelper._();

  FireBaseHelper._();
// Todo signIn
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<bool?> Create({required email, required password}) async {
    bool? msg;
    return await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      return true;
    }).catchError((e) {
      return false;
    });
  }

  Future<bool?> Check({required email, required password}) async {
    bool? mag;

    return await firebaseAuth.signInWithEmailAndPassword(email: email, password: password)
        .then(
          (value) {
        return true;
      },
    ).catchError(
          (e) {
        return false;
      },
    );
    return mag;
  }

  bool StoreLigin() {
    User? user = firebaseAuth.currentUser;
    print("======================= method  $user");
    return user != null;
  }

  signOut() async {
    bool? check;
    await firebaseAuth.signOut().then((value) => check = true);
    await GoogleSignIn().signOut().then((value) => check = true);
    return check;
  }

  sinhInThroughGoogle() async {
    bool? msg;
    GoogleSignInAccount? user = await GoogleSignIn().signIn();

    GoogleSignInAuthentication? googleAuth = await user?.authentication;

    var crd = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await firebaseAuth
        .signInWithCredential(crd)
        .then((value) => msg = true)
        .catchError((e) => msg = false);
    return msg;
  }

  userData() {
    User? use = firebaseAuth.currentUser;
    String? image = use?.photoURL;
    String? email = use?.email;
    String? name = use?.displayName;
    return {'e1': email, 'name': name, 'img': image};
  }

  // ToDo App

  addData({notes,title,date,time,priority}) {
    User? user = firebaseAuth.currentUser;
    FirebaseFirestore inse = FirebaseFirestore.instance;
    inse.collection('Task').doc('${user!.uid}').collection("Todo").add(
      {
        "notes":notes,
        "title":title,
        "date":date,
        "time":time,
        "priority":priority,
      },
    );
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readData()
  {
    FirebaseFirestore inse = FirebaseFirestore.instance;
    User? user = firebaseAuth.currentUser;
    return  inse.collection('Task').doc('${user!.uid}').collection('Todo').snapshots();
  }

  Future<void> updateData({required key,required date,required time,required notes,required priority,required title,})
  {
    User? user = firebaseAuth.currentUser;
    FirebaseFirestore inse = FirebaseFirestore.instance;
    return inse.collection('Task').doc('${user?.uid}').collection('Todo').doc('$key').set({
      "date":date,
      "notes":notes,
      "priority":priority,
      "time":time,
      "title":title,
    });
  }
}
