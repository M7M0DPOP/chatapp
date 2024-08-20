// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PasswordTextField extends StatefulWidget {
  bool isscure = true;
  final String text;
  final IconData? icon;
  TextEditingController controller;
  PasswordTextField(
      {super.key,
      required this.text,
      required this.icon,
      this.isscure = true,
      required this.controller});

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      obscureText: widget.isscure,
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          labelText: widget.text,
          prefixIcon: Icon(widget.icon),
          prefixIconColor: Colors.white,
          suffixIcon: TextButton(
              onPressed: () {
                setState(() {
                  widget.isscure = !widget.isscure;
                });
              },
              child: Text(
                'show',
                style: TextStyle(color: Colors.white),
              )),
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 85)),
              borderRadius: BorderRadius.circular(40))),
      controller: widget.controller,
    );
  }
}

class NormalTextField extends StatelessWidget {
  final String text;
  final IconData? icon;
  TextEditingController controller;
  NormalTextField(
      {super.key,
      required this.text,
      required this.icon,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          labelStyle: TextStyle(color: Colors.white),
          labelText: text,
          prefixIcon: Icon(icon),
          prefixIconColor: Colors.white,
          border: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 255, 0, 85)),
              borderRadius: BorderRadius.circular(40))),
      controller: controller,
    );
  }
}

class CustomButton extends StatefulWidget {
  final String text;
  Future<User?>? onTap;
  CustomButton({super.key, required this.text, required this.onTap});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: Color.fromARGB(255, 255, 0, 85),
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), borderSide: BorderSide.none),
      minWidth: double.infinity,
      textColor: Colors.white,
      onPressed: () {
        widget.onTap;
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          widget.text,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String text;
  void Function()? function;
  CustomTextButton({super.key, required this.text, required this.function});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: function,
        child: Text(
          'Log in',
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 85)),
        ));
  }
}

class CustomIconButton extends StatelessWidget {
  final IconData icon;
  const CustomIconButton({super.key, required this.icon});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {},
      icon: FaIcon(icon),
      color: Colors.white,
    );
  }
}
