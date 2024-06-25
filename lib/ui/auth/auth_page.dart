import 'package:flutter/material.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_bloc.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_event.dart';
import 'package:gym_tracker_flutter/data/bloc/authorization/auth_state.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/alternative_action.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/authentication_button.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/authentication_form.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/gym_diary_logo.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/logo_section.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/short_description.dart';
import 'package:gym_tracker_flutter/ui/auth/widgets/social_icons_field.dart';
import 'package:gym_tracker_flutter/core/constants/global_variables.dart';
import 'package:gym_tracker_flutter/ui/main_dashboard/home_page.dart';

import 'form_handler.dart';

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
  final GlobalKey<AnimatorWidgetState> _shakeKey = GlobalKey<AnimatorWidgetState>();
  final FormHandler _formHandler = FormHandler();

  FormType _formType = FormType.login;

  @override
  Widget build(BuildContext context) {
          print("first method context: $context");
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(gradient: GlobalVariables().primaryGradient),
      child: BlocProvider(
        create: (context) => AuthBloc(),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is AuthLoading) {
            } else if (state is AuthSuccess) {
               Navigator.pushNamed(context, '/navi-bar');
            } else if (state is AuthFailure) {
              _handleAuthFailure(state.error);
            }
          },
          builder: (context, state) {
            return Shake(
              key: _shakeKey,
              preferences: AnimationPreferences(
                offset: Duration.zero,
                autoPlay: AnimationPlayStates.None,
              ),
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
                    onButtonPressed: () => _onButtonPressed(context),
                  ),
                  if (_formType != FormType.forgotPassword) SocialIconsField(),
                  AlternativeAction(_formType, _onFormTypeChange),
                ],
              ),
            );
          },
        ),
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
        throw Exception("Unsupported form type");
    }
  }

  String _getButtonText() {
    switch (_formType) {
      case FormType.login:
        return "Log in";
      case FormType.forgotPassword:
        return "Send reset link";
      case FormType.signUp:
        return "Sign up";
      default:
        throw Exception("Unsupported form type");
    }
  }

  void _onButtonPressed(BuildContext context) {
    switch (_formType) {
      case FormType.login:
        if (_formKey.currentState!.validate()) {
          String username = _usernameController.text.trim();
          String password = _passwordController.text.trim();
          context.read<AuthBloc>().add(LoginAttempt(username: username, password: password));
        }
        break;
      case FormType.signUp:
        if (_formKey.currentState!.validate()) {
          String username = _usernameController.text.trim();
          String email = _emailController.text.trim();
          String password = _passwordController.text.trim();
          String confirmPassword = _confirmPasswordController.text.trim();
          if(password == confirmPassword){
          context.read<AuthBloc>().add(RegisterAttempt(username: username, email: email, password: password));
          } else {
            throw Exception("Password and confirm password must be the same");
          }
        }
        break;
      default:
        break;
    }
  }

  void _handleAuthFailure(String error) {
    _shakeKey.currentState?.forward();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Invalid credentials: $error'),
      backgroundColor: Colors.red,
    ));
  }

  void _onFormTypeChange(FormType newFormType) {
    setState(() {
      _formType = newFormType;
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _usernameController.dispose();
    super.dispose();
  }
}
