import 'package:flutter/material.dart';
import 'package:gym_tracker_flutter/ui/auth/form_handler.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/alternative_action.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/authentication_button.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/authentication_form.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/gym_diary_logo.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/logo_section.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/short_description.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/social_icons_field.dart';
import 'package:gym_tracker_flutter/utills/color_pallete.dart';

enum FormType { login, forgotPassword, signUp }

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _usernameController = TextEditingController();

  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: ColorPalette.primaryThemeGradient),
      child: ListView(
        children: [
          LogoSection(),
          GymDiaryLogo(),
          ShortDescription(_formType),
          AuthenticationForm(
            formKey: _formKey,
            fields: _getAuthFields(),
          ),
          AuthenticationButton(
            formKey: _formKey,
            buttonText: _getButtonText(),
            onButtonPressed: _onButtonPressed,
          ),
          if (_formType != FormType.forgotPassword) SocialIconsField(),
          AlternativeAction(_formType, _onFormTypeChange),
        ],
      ),
    );
  }

  List<AuthField> _getAuthFields() {
    switch (_formType) {
      case FormType.login:
        return [
          AuthField(
              hintText: "Enter your username",
              controller: _usernameController,
              icon: Icons.person,
              isPasswordField: false),
          AuthField(
              hintText: "Enter your password",
              controller: _passwordController,
              icon: Icons.lock,
              isPasswordField: true),
        ];
      case FormType.forgotPassword:
        return [
          AuthField(
              hintText: "Enter your email",
              controller: _emailController,
              icon: Icons.email,
              isPasswordField: false),
        ];
      case FormType.signUp:
        return [
          AuthField(
              hintText: "Enter your username",
              controller: _usernameController,
              icon: Icons.person,
              isPasswordField: false),
          AuthField(
              hintText: "Enter your email",
              controller: _emailController,
              icon: Icons.email,
              isPasswordField: false),
          AuthField(
              hintText: "Enter your password",
              controller: _passwordController,
              icon: Icons.lock,
              isPasswordField: true),
          AuthField(
              hintText: "Confirm your password",
              controller: _confirmPasswordController,
              icon: Icons.lock,
              isPasswordField: true),
        ];
      default:
        return [];
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
            _usernameController.text, _passwordController.text, context);
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

  void _onFormTypeChange(FormType newFormType) {
    setState(() {
      _formType = newFormType;
    });
  }
}
