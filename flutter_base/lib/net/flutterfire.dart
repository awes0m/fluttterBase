//firebase SignIn Function using Email and Password

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

//https://firebase.flutter.dev/docs/auth/usage#emailpassword-registration--sign-in-Documentation
Future<bool> signIn(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
    return true;
  } catch (e) {
    //print(e);
    return false;
  }
}

//https://firebase.flutter.dev/docs/auth/usage#emailpassword-registration--sign-in-Documentation
Future<bool> register(String email, String password) async {
  try {
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
    //If registration is successful, return True
    return true;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
    //if registration is unsuccessful due to errors, return False
    return false;
  } catch (e) {
    //(e.toString());
    //if registration is unsuccessful due to errors, return False

    return false;
  }
}

Future<bool> addCoin(String id, String amount) async {
  try {
    //Creating a instance of FirebaseAuth data of user from uid
    String uid = FirebaseAuth.instance.currentUser!.uid;
    //Converting amount to double as value
    var value = double.parse(amount);
    //Opening a collection of user from uid, going to the database location where the coin must be added
    DocumentReference<dynamic> documentReference = FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id);
    //Adding the coin to the database
    FirebaseFirestore.instance.runTransaction((transaction) async {
      DocumentSnapshot<dynamic> snapshot =
          await transaction.get(documentReference);

      if (!snapshot.exists) {
        documentReference.set({'Amount': value});
        return true;
      }

      double newAmount = snapshot.data()!["Amount"] + value;
      transaction.update(documentReference, {'Amount': newAmount});
      return true;
    });
  } catch (e) {
    //print(e.toString());
  }
  return false;
}

Future<bool> removeCoin(String id) async {
  try {
    //Creating a instance of FirebaseAuth data of user from uid
    String uid = FirebaseAuth.instance.currentUser!.uid;

    //Opening a collection of user from uid, going to the database location from where coin must be removed
    FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .collection('Coins')
        .doc(id)
        .delete();
    //   FirebaseFirestore.instance.runTransaction((transaction) async {
    //     DocumentSnapshot<dynamic> snapshot =
    //         await transaction.get(documentReference);

    //     if (!snapshot.exists) {
    //       documentReference.set({'Amount': value});
    //       return true;
    //     }

    //     double newAmount = snapshot.data()!["Amount"] - value;
    //     transaction.update(documentReference, {'Amount': newAmount});
    //     return true;
    // });
    return true;
  } catch (e) {
    //print(e.toString());
  }
  return false;
}
