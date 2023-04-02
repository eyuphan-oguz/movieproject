import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:movieproject/model/user_model.dart';


class AuthMethods{
  FirebaseAuth _auth=FirebaseAuth.instance;
  FirebaseFirestore _firestore=FirebaseFirestore.instance;


  Future<UserModel>getUserDetails()async{
    User currentUser=_auth.currentUser!;

    DocumentSnapshot snap= await _firestore.collection('users').doc(currentUser.uid).get();

    return UserModel.fromSnap(snap);
  }


  Future<String>signUpUser({required String email, required String password, required String name})async{
    String res="Some error occurred";
    try{
      if(email.isNotEmpty || password.isNotEmpty || name.isNotEmpty){
        // register user
        UserCredential cred=await _auth.createUserWithEmailAndPassword(email: email, password: password);

        // add to user our database
        UserModel user=UserModel(
            name:name,
            uid:cred.user!.uid,
            email:email,
            myPostList:[],
            myContentList: [],

        );



        await _firestore.collection("users").doc(cred.user!.uid).set(user.toJson());
         res = "success";
      }else {
        res = "Lütfen tüm alanları doldurunuz.";
      }

    }catch(err){
      res=err.toString();
    }
    return res;
  }





    // logging in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } catch (err) {
      return err.toString();
    }
    return res;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<bool> isUserLoggedIn() async {
  final User? user = FirebaseAuth.instance.currentUser;
  print("user:${user}");
  return user != null;
}


}