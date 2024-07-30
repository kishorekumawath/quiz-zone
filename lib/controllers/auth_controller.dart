import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_zone/Screens/home/home_screen.dart';
import 'package:quiz_zone/Screens/login/login_screen.dart';
import 'package:quiz_zone/firebase_ref/References.dart';
import 'package:quiz_zone/widgets/dialogs/dialogue_widget.dart';

class AuthController extends GetxController{
  @override
  void onReady() {
    initAuth();
    super.onReady();

  }
  late FirebaseAuth _auth;
  final _user = Rxn<User>();
  late Stream<User?>_authStateChange;

  void initAuth() async{
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChange = _auth.authStateChanges();
    _authStateChange.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  String? get userMail =>_auth.currentUser!.email;

  signInWithGoogle() async{
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try{
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if(account!=null){
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
          idToken: _authAccount.idToken,
          accessToken: _authAccount.accessToken,
        );

        await _auth.signInWithCredential(_credential);

        await saveUser(account);

        navigateToHomeScreen();

      }
    }on Exception catch(e){
      print("------------- Error at auth controller file $e");
    }
  }

  User? getUser(){
    _user.value = _auth.currentUser;
    return _user.value;
  }

  saveUser(GoogleSignInAccount account){
    userRf.doc(account.email).set(
      {
        "email":account.email,
        "name":account.displayName,
        "profilepic":account.photoUrl,
      }
    );

  }
  void navigateToIntroduction(){
    Get.offAllNamed("/introduction");
  }

  void showLoginAlertDialog(){
    Get.dialog(Dialogs.questionStartDialogue(onTap: (){
      Get.back();
      navigateToLoginPage();
    }),barrierDismissible: false);
  }

  bool isLoggedIn(){
    return _auth.currentUser != null;
  }

  signOut(){
    try{
      _auth.signOut();
      navigateToHomeScreen();
    }on FirebaseAuthException catch(e){
      print("-----> error while logging out $e");
    }
  }

  void navigateToLoginPage() {
    Get.toNamed(LoginScreen.routeName);
  }

  void navigateToHomeScreen() {
    Get.offAllNamed(HomeScreen.routeName);
  }
}