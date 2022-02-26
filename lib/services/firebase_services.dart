import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:donor_app/screens/main/dash_board_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../const/auth_exception_handler.dart';
import '../const/auth_result_status_enum.dart';
import '../const/constants.dart';
import '../screens/auth/register_screen.dart';
import '../screens/main/donation_question_records_screen.dart';
import '../screens/main/home_screen.dart';

class FirebaseServices {
  AuthResultStatus? _status;
  String? errorMsg;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future signupDonor(
      BuildContext context, String email, String password) async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.trim(), password: password.trim())
          .then((value) async {
        HttpsCallable callable = FirebaseFunctions.instance.httpsCallable(
            "addUserRole",
            options: HttpsCallableOptions(timeout: const Duration(seconds: 5)));
        var result = await callable({"email": value.user?.email});
        print("------------custom claim ${result.data.toString()}");
      });

      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (ctx) => const RegisterScreen()));
        print("register");
      }
    } catch (error) {
      _status = AuthExceptionHandler.handleException(error);
      errorMsg = AuthExceptionHandler.generateExceptionMessage(_status);
      Constants().showToast(errorMsg!);
    }
  }

  Future donorLogin(String email, String password, BuildContext context) async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then((auth) {
        auth.user?.getIdTokenResult().then((idTokenResult) {
          print(idTokenResult.claims?['donor']);
          if (idTokenResult.claims?['donor']) {
            Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const HomeScreen()));
          } else {
            Constants().showToast("Invalid User name or password");
          }
        });
      });
    } catch (error) {
      _status = AuthExceptionHandler.handleException(error);
      errorMsg = AuthExceptionHandler.generateExceptionMessage(_status);
      Constants().showToast(errorMsg!);
    }
  }

  void registerNewDonor(
      BuildContext context,
      String donorId,
      String imgUrl,
      String name,
      String nic,
      String address,
      String phone,
      String dob,
      String gender,
      String duration,
      String termsAgree) async {
    Map<String, dynamic> userData = {
      'donorId': donorId,
      'profileUrl': imgUrl,
      'fullName': name,
      'nic': nic,
      'address': address,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'nextDonation': duration,
      'agreement': termsAgree
    };

    try {
      firestore
          .collection("donors")
          .doc(auth.currentUser?.uid)
          .set(userData)
          .then((value) => Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => DashBoardScreen())));
    } catch (e) {
      Constants().showToast(e.toString());
    }
  }

  void isValidCampaign(BuildContext context, String campaignId) {
    print("-------------------->campaignId $campaignId");

    firestore
        .collection("campaigns")
        .where("campaignId", isEqualTo: campaignId)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.length == 1) {
        var date = querySnapshot.docs[0]["date"];
        var startTime = querySnapshot.docs[0]["startTime"];
        var endTime = querySnapshot.docs[0]["endTime"];

        var modifiedStartTime = date + " $startTime:00:00";
        var modifiedEndTime = date + " $endTime:00:00";

        DateTime formattedStartDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(modifiedStartTime);
        DateTime formattedEndDate =
            DateFormat("yyyy-MM-dd hh:mm:ss").parse(modifiedEndTime);

        DateTime now = DateTime.now();
        print("start : $formattedStartDate");
        print("end : $formattedEndDate");
        print("now : $now");
        print(formattedStartDate.isAfter(now));
        print(formattedEndDate.isBefore(now));

        if (!formattedStartDate.isBefore(now)) {
          Constants().showToast("Campaign will be started soon");
        } else if (!formattedEndDate.isAfter(now)) {
          Constants().showToast("Campaign has been ended");
        } else {
          Constants().showToast("donate");

          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (_) => DonationQuestionRecordsScreen()));
        }
      } else {
        Constants().showToast("Invalid QR Code");
      }
    });
  }
}
