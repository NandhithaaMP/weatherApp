import 'dart:collection';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../homeScreen.dart';
import '../otpScreen.dart';

class MainProvider extends ChangeNotifier{
  final FirebaseFirestore db=FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController RegisterNamecontroller=TextEditingController();
  TextEditingController RegisterPhonecontroller=TextEditingController();

  void AddRegistration() {
    String id = DateTime
        .now()
        .microsecondsSinceEpoch
        .toString();
    HashMap<String, dynamic>registermap = HashMap();
    registermap["STATUS"] = "Request";
    registermap["REGISTERID"] = id;
    registermap["REGISTERNAME"] = RegisterNamecontroller.text;
    registermap["REGISTERPHONE"] = RegisterPhonecontroller.text;

    db.collection("Registration").doc(id).set(registermap);
  }
TextEditingController otpverifycontroller=TextEditingController();
  String VerificationIdNew="";
  void verify(BuildContext context) async {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: VerificationIdNew, smsCode: otpverifycontroller.text);
    await auth.signInWithCredential(credential).then((value) {
      final user = value.user;
      if (user != null) {
        userAuthorized(user.phoneNumber, context);

      } else {
        if (kDebugMode) {
        }
      }
    });
  }

  Future<void> userAuthorized(String? phoneNumber, BuildContext context) async {

    MainProvider mainProvider = Provider.of<MainProvider>(context, listen: false);

    try {
      var phone = phoneNumber!;
      print(phone+"duudud");
      db.collection("Registration").where("REGISTERPHONE",isEqualTo:phone).get().then((value) async {
        if(value.docs.isNotEmpty){
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('phone_number', phone);
          print(prefs.getString("phone_number").toString()+'sakjjasjkaskllas');

          for(var element in value.docs) {

            Map<dynamic, dynamic> map = element.data();


                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));

          }

        }
        else {
          const snackBar = SnackBar(
              backgroundColor: Colors.white,
              duration: Duration(milliseconds: 3000),
              content: Text("Sorry , You don't have any access",
                textAlign: TextAlign.center,
                softWrap: true,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ));

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }

      });


    } catch (e) {


    }
  }
  TextEditingController phoneController=TextEditingController();
  Future<void> sendOTP(BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential){},
        verificationFailed: (FirebaseAuthException ex){},
        codeSent: (String verificationid, int? resentToken){
          VerificationIdNew=verificationid;

          Navigator.push(context, MaterialPageRoute(builder: (context) => OtpScreen(),));

        },
        codeAutoRetrievalTimeout: (String verificationId){},
        phoneNumber:phoneController.text.toString() );
  }

}