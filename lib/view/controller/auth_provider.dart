
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todo/services/auth_services.dart';

class AuthProvider extends ChangeNotifier {
  AuthServices authservices = AuthServices();

  TextEditingController registerEmailTextController = TextEditingController();
  TextEditingController registerPassWordTextController =
      TextEditingController();
  TextEditingController registerConformPasswordTextController =
      TextEditingController();
  TextEditingController LoginEmailTextController = TextEditingController();
  TextEditingController LoginPassWordTextController = TextEditingController();

  bool showLoginPage = true;
  final isGoogleLoading=false;
  //instance of auth

  User? _user;

  AuthProvider() {
    authservices.firebaseAuth.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }
  User? get user => _user;

  void togglepages() {
    showLoginPage = !showLoginPage;
    notifyListeners();
  }

//sign user out
  Future<void> signOut() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
     FirebaseAuth.instance.signOut();
    
  }
  

  Future<UserCredential> signInWithEmailandPassword(
      String email, String password) async {
    return  await authservices.signInWithEmailandPassword(email, password);
  }

//create a new user
  Future<UserCredential> signUpWithEmailandPassword(
      String email, password) async {
    return authservices.signUpWithEmailandPassword(email, password);
  }


   //google sign in
  Future<UserCredential> signInWithGoogle()async{
    return authservices.signInWithGoogle();
  }
}
