import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:chatapp/screens/chat_screen.dart';
import 'package:chatapp/screens/custom_widget.dart';
import 'package:chatapp/screens/signup_testscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginTestscreen extends StatefulWidget {
  const LoginTestscreen({super.key});

  @override
  State<LoginTestscreen> createState() => _LoginTestscreenState();
}

class _LoginTestscreenState extends State<LoginTestscreen> {
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
                    'Log In',
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
                      text: 'Password',
                      icon: Icons.password,
                      controller: passwordc),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: state == 'loading'
                      ? Center(
                          child: CircularProgressIndicator(
                          color: Color.fromARGB(255, 255, 0, 76),
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
                              UserCredential userCredentialLogin =
                                  await FirebaseAuth.instance
                                      .signInWithEmailAndPassword(
                                          email: emailc.text,
                                          password: passwordc.text);

                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.success,
                                animType: AnimType.rightSlide,
                                title: 'Login success',
                                desc: '',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                              setState(() {
                                state = 'success';
                              });
                              user = userCredentialLogin.user;
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen()));
                            } catch (e) {
                              AwesomeDialog(
                                context: context,
                                dialogType: DialogType.error,
                                animType: AnimType.rightSlide,
                                title: 'Login fail',
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
                              'Log in',
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
                      'Don\'t have an account ?',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignupTestscreen()));
                        },
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 0, 43),
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
