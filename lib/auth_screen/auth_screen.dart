import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/api/auth_service.dart';
import 'package:gym_tracker_flutter/auth_screen/form_handler.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/authentication_button.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/authentication_form.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/error_dialog.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/gym_diary_logo.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/logo_section.dart';
import 'package:gym_tracker_flutter/auth_screen/widgets/social_icons_field.dart';

enum FormType { login, forgotPassword, signUp }

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();

  FormType _formType = FormType.login;

  var boxDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [Color.fromARGB(255, 48, 47, 47), Color(0xff000000)],
      stops: [0, 1],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: boxDecoration,
        child: ListView(
          children: [
            LogoSection(),
            GymDiaryLogo(),
            _buildShortDescritpion(),
            _buildForm(),
            AuthenticationButton(
              formKey: _formKey,
              buttonText: _getButtonText(),
              onButtonPressed: _onButtonPressed,
            ),
            _formType != FormType.forgotPassword
                ? SocialIconsField()
                : Container(),
            _buildAlternativeAction(),
          ],
        ),
      ),
    );
  }

  Padding _buildShortDescritpion() {
    String text = "";
    switch (_formType) {
      case FormType.login:
        text = "LOGIN";
        break;
      case FormType.forgotPassword:
        text = "RECOVER PASSWORD";
        break;
      case FormType.signUp:
        text = "SIGN UP";
        break;
    }

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
        child: Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontFamily: 'Roboto',
              ),
            ),
            Text(
              "Please enter your details to continue.",
              style: TextStyle(
                color: Color.fromRGBO(126, 120, 120, 100),
                fontSize: 16,
                fontFamily: 'Roboto',
              ),
            ),
          ],
          crossAxisAlignment: CrossAxisAlignment.start,
        ),
      ),
    );
  }

  Widget _buildForm() {
    switch (_formType) {
      case FormType.login:
        return AuthenticationForm(
          formKey: _formKey,
          fields: [
            AuthField(
                hintText: "Enter your email",
                controller: _emailController,
                icon: Icons.email),
            AuthField(
                hintText: "Enter your password",
                controller: _passwordController,
                icon: Icons.lock),
          ],
        );
      case FormType.forgotPassword:
        return AuthenticationForm(
          formKey: _formKey,
          fields: [
            AuthField(
                hintText: "Enter your email",
                controller: _emailController,
                icon: Icons.email),
          ],
        );
      case FormType.signUp:
        return AuthenticationForm(
          formKey: _formKey,
          fields: [
            AuthField(
                hintText: "Enter your username",
                controller: _usernameController,
                icon: Icons.person),
            AuthField(
                hintText: "Enter your email",
                controller: _emailController,
                icon: Icons.email),
            AuthField(
                hintText: "Enter your password",
                controller: _passwordController,
                icon: Icons.lock),
            AuthField(
                hintText: "Confirm your password",
                controller: _confirmPasswordController,
                icon: Icons.lock),
          ],
        );
      default:
        return Container();
    }
  }

  String _getButtonText() {
    switch (_formType) {
      case FormType.login:
        return "LOGIN";
      case FormType.forgotPassword:
        return "SEND";
      case FormType.signUp:
        return "SIGN UP";
      default:
        return "";
    }
  }

  void _onButtonPressed() {
    switch (_formType) {
      case FormType.login:
        FormHandler().handleLogin(
            _emailController.text, _passwordController.text, context);
        break;

      case FormType.forgotPassword:
        FormHandler().handleForgotPassword(_emailController.text, context);
        break;

      case FormType.signUp:
        FormHandler().handleSignUp(
            _usernameController.text,
            _emailController.text,
            _passwordController.text,
            _confirmPasswordController.text,
            context);
        break;

      default:
        print("FormType not recognized");
    }
  }

  Widget _buildAlternativeAction() {
    switch (_formType) {
      case FormType.login:
        return Column(
          children: [
            _buildForgotPasswordField(),
            _buildSignUpField(),
          ],
        );
      case FormType.forgotPassword:
        return _buildBackToLoginFormField();
      case FormType.signUp:
        return _buildBackToLoginFormField();
      default:
        return Container();
    }
  }

  Padding _buildForgotPasswordField() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
          onPressed: () => setState(() {
            _formType = FormType.forgotPassword;
          }),
          child: Text(
            "Forgot password?",
            style: TextStyle(
              color: Color.fromRGBO(43, 138, 132, 100),
              fontSize: 22,
              fontFamily: 'Roboto',
            ),
          ),
        ),
      ),
    );
  }

  Padding _buildSignUpField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don't you have an account? ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontFamily: 'Roboto',
              ),
            ),
            TextButton(
                onPressed: (() => setState(() {
                      _formType = FormType.signUp;
                    })),
                child: Text("Signup here",
                    style: TextStyle(
                        color: Color.fromRGBO(43, 138, 132, 100),
                        fontSize: 17,
                        fontFamily: 'Roboto'))),
          ],
        ),
      ),
    );
  }

  Padding _buildBackToLoginFormField() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Align(
        alignment: Alignment.center,
        child: TextButton(
            onPressed: (() => setState(() {
                  _formType = FormType.login;
                })),
            child: Text("Back to Login",
                style: TextStyle(
                    color: Color.fromRGBO(43, 138, 132, 100),
                    fontSize: 17,
                    fontFamily: 'Roboto'))),
      ),
    );
  }
}
