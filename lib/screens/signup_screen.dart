import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/screens/login_screen.dart';
import 'package:chatapp/screens/show_screen.dart';
import 'package:chatapp/screens/custom_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignupTestscreen extends StatefulWidget {
  const SignupTestscreen({super.key});

  @override
  State<SignupTestscreen> createState() => _SignupTestscreenState();
}

class _SignupTestscreenState extends State<SignupTestscreen> {
  TextEditingController emailc = TextEditingController();
  TextEditingController passwordc = TextEditingController();
  bool isscure = true;
  String state = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 19, 3, 87),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: NormalTextField(
                      text: 'Email', icon: Icons.email, controller: emailc),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: PasswordTextField(
                    icon: Icons.password,
                    controller: passwordc,
                    text: 'Password',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: state == 'loading'
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 255, 0, 85),
                        ))
                      : MaterialButton(
                          color: Color.fromARGB(255, 255, 0, 85),
                          shape: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide.none),
                          minWidth: double.infinity,
                          textColor: Colors.white,
                          onPressed: () async {
                            try {
                              setState(() {
                                state = 'loading';
                              });
                              UserCredential userCredentialSignin =
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: emailc.text,
                                          password: passwordc.text);

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Sign up success',
                                desc: '',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                              setState(() {
                                state = 'success';
                              });
                              user = userCredentialSignin.user;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()));
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Sign up fail',
                                desc: '',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                              print(e.toString());
                              setState(() {
                                state = 'failed';
                              });
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                              'Sign Up',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                ),
                SizedBox(
                  height: 350,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      'Already have an account ?',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginTestscreen()));
                        },
                        child: Text(
                          'Log in',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 55),
                              fontSize: 15),
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
