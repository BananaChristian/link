import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;
  Future<String?> registerUser({required String username, required String email,required String password}) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("Users").doc(userCredential.user!.uid).set({
        'uid':userCredential.user!.uid,
        'username':username,
        'email':email
      });
      return 'Success';
    }on FirebaseAuthException catch(e){
      if(e.code=='weak-password'){
        return 'The password is too weak';
      }else if (e.code== 'email-already-in-use'){
        return 'The account is already in use';
      }else{
        return e.message;
      }
    }catch(e){
      return e.toString();
    }
  }

  Future<String?> loginUser ({required String username,required String email,required String password}) async {
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      await _firestore.collection("Users").doc(userCredential.user!.uid).set(
        {
          'uid':userCredential.user!.uid,
          'username':username,
          'email':email
        }
      );
      return 'Success';
    }on FirebaseAuthException catch(e){
      if(e.code=="user-not-found"){
        return 'No user found under that email';
      }else if(e.code=="wrong-password"){
        return 'Wrong password provided by the user';
      }else{
        return e.message;
      }
    }catch (e){
      return e.toString();
    }
  }

  Future<String?> logOut() async{
    try{
      await FirebaseAuth.instance.signOut();
      return 'Success';
    }on FirebaseAuthException catch(e){
      return e.message;
    }catch (e){
      return e.toString();
    }
  }

  Future <User?> getCurrentUser() async{
    try{
      return FirebaseAuth.instance.currentUser;
    }catch (e){
      throw Exception('Error fetching current user $e');
    }
  }
}