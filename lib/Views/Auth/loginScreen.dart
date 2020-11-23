import 'package:client/Services/AuthService.dart';
import 'package:client/Views/HomeScreen/LandingScreen.dart';
import 'package:client/Views/components/txtfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var firebaseAuth = FirebaseAuth.instance;
  final formkey = GlobalKey<FormState>();
  bool codeSent = false;
  bool phoneVerified = false;
  final scaffkey = new GlobalKey<ScaffoldState>();
  String verificationId, smsCode;
  String phone = '';
  TextEditingController phoneNo = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> verifyPhone(phoneNo) async {
    final PhoneVerificationCompleted verified = (AuthCredential authResult) {
      AuthService().signIn(authResult, phoneNo);
    };

    final PhoneVerificationFailed verificationfailed =
        (FirebaseAuthException authException) {
      print('${authException.message}');
    };

    final PhoneCodeSent smsSent = (String verId, [int forceResend]) {
      this.verificationId = verId;
      setState(() {
        this.codeSent = true;
      });
    };

    final PhoneCodeAutoRetrievalTimeout autoTimeout = (String verId) {
      this.verificationId = verId;
    };

    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91' + phoneNo,
        timeout: const Duration(seconds: 5),
        verificationCompleted: verified,
        verificationFailed: verificationfailed,
        codeSent: smsSent,
        codeAutoRetrievalTimeout: autoTimeout);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffkey,
      body: Container(
        height: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(1),
          image: DecorationImage(
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.7), BlendMode.dstATop),
            image: AssetImage('assets/loginbg.png'),
          ),
        ),
        child: Form(
          key: formkey,
          child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.only(top:30),
                child: Column(
                  children: [
                    CircleAvatar(backgroundImage: AssetImage("assets/logo.png"),radius: 50,),
                    Center(
                      child: Text(
                        'Tandoor Hut',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 52,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(25.0),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        style: TextStyle(color: Colors.white),
                        validator: (text) {
                          if (text == null ||
                              text.isEmpty ||
                              text.length < 10) {
                            return 'Phone is empty\n or less than 10';
                          }
                          return null;
                        },
                        decoration:
                            TextFieldDec.inputDec("Phone Number").copyWith(
                          prefixText: "+91 ",
                          prefixStyle: TextStyle(color: Colors.white),
                        ),
                        controller: phoneNo,
                      ),
                    ),
                    codeSent
                        ? Padding(
                            padding: EdgeInsets.all(25.0),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              style: TextStyle(color: Colors.white),
                              onChanged: (val) {
                                setState(() {
                                  this.smsCode = val;
                                });
                              },
                              decoration: TextFieldDec.inputDec("Enter OTP")
                                  .copyWith(
                                      prefixStyle:
                                          TextStyle(color: Colors.white),
                                      hintText: 'Enter OTP'),
                            ),
                          )
                        : Container(),
                    Padding(
                      padding:
                          EdgeInsets.only(left: 25.0, right: 25.0, bottom: 40),
                      child: MaterialButton(
                        height: 44,
                        minWidth: 157,
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(38.0),
                          side: BorderSide(color: Colors.orange),
                        ),
                        color: Colors.orange,
                        child: Center(
                          child: codeSent
                              ? Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              : Text(
                                  'Verify',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        onPressed: () {
                          codeSent
                              ? AuthService().signInWithOTP(
                                  smsCode, verificationId, phoneNo.text)
                              : verifyPhone(phoneNo.text);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
