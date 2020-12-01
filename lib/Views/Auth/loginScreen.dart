import 'package:client/LandingScreen.dart';
import 'package:client/Services/AuthService.dart';
import 'package:client/Views/components/txtfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../ui_constants.dart';

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

  retryverif() async {
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: smsCode,
      ),
    );
    if (userCredential.user.phoneNumber != null) {
      setState(() {
        phoneVerified = true;
        codeSent = false;
      });
    }
  }
   bool showOTP = false;

  Future<void> verifyPhone(phoneNo) async {
    setState(() {
      showOTP = false;
    });
    final PhoneVerificationCompleted verified =
        (AuthCredential authResult) async {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(authResult);
      if (userCredential.user.phoneNumber != null) {
        setState(() {
          phoneVerified = true;
          codeSent = false;
          showOTP = false;
        });
      }
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
  Widget _input(
      int leftPadding,
      int rightPadding,
      int textWidth,
      String validation,
      bool,
      String label,
      String hint,
      IconData icon,
      TextInputType type,
      save) {
    return Padding(
      padding: EdgeInsets.only(
          left: UIConstants.fitToWidth(leftPadding, context),
          right: UIConstants.fitToWidth(rightPadding, context),
          bottom: UIConstants.fitToHeight(17, context)),
      child: SizedBox(
        width: UIConstants.fitToWidth(textWidth, context),
        child: TextFormField(
          keyboardType: type,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15.0, color: Colors.black),
            prefixIcon: Icon(icon),
            contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0)),
          ),
          obscureText: bool,
          validator: (value) => value.isEmpty ? validation : null,
          onChanged: save,
        ),
      ),
    );
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
                padding: EdgeInsets.only(top: 30),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/logo.png"),
                      radius: 50,
                    ),
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
                     Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _input(
                    40,
                    0,
                    180,
                    'Please enter Mobile Number',
                    false,
                    'Mobile Number',
                    'Mobile Number',
                    Icons.phone,
                    TextInputType.phone, (value) {
                  setState(() {
                    if (value.length == 10) {
                      setState(() {
                        phone = value;
                      });
                    } else {
                      // scaffkey.currentState.showSnackBar(new SnackBar(
                      //   content: new Text("Enter valid phone No"),
                      // ));
                    }
                  });
                }),
                !(codeSent)
                    ? Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.transparent)),
                            color: Color(0xff25354E),
                            elevation: 2.0,
                            onPressed: () {
                              verifyPhone(phone);
                              setState(() {
                                showOTP = true;
                              });
                            },
                            child: Text(
                              phoneVerified ? 'Verified' : 'Verify',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      )
                    : Container(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                Color(0xff25354E))))
              ],
            ),
                    showOTP
                ? Row(
                    children: [
                      _input(
                          40,
                          0,
                          180,
                          'Enter correct OTP',
                          false,
                          'Enter OTP',
                          'Enter OTP',
                          Icons.security,
                          TextInputType.streetAddress, (value) {
                        setState(() {
                          this.smsCode = value;
                        });
                      }),
                      Padding(
                        padding: EdgeInsets.only(left: 20, bottom: 20),
                        child: MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.transparent)),
                            color: Color(0xff25354E),
                            elevation: 2.0,
                            onPressed: phoneVerified
                                ? () {}
                                : () {
                                    codeSent
                                        ? retryverif()
                                        : verifyPhone(phone);
                                  },
                            child: Text(
                              phoneVerified ? 'Verified' : 'Verify',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      ),
                    ],
                  )
                : Container(), MaterialButton(
                            height: 50,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                side: BorderSide(color: Colors.transparent)),
                            color: Color(0xff25354E),
                            elevation: 2.0,
                            onPressed:() {
                                  if( phoneVerified ){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LandingScreen()));
                                  }
                                  },
                            child: Text(
                              phoneVerified ? 'Verified' : 'Verify',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
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
