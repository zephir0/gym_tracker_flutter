import 'package:flutter/cupertino.dart';

import 'custom_text_field.dart';

class AuthenticationForm extends StatelessWidget {
  final List<AuthField> fields;
  final Key formKey;

  AuthenticationForm({required this.fields, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: fields
            .map((field) => CustomTextField(
                  hintText: field.hintText,
                  controller: field.controller,
                  icon: field.icon,
                ))
            .toList(),
      ),
    );
  }
}

class AuthField {
  final String hintText;
  final TextEditingController controller;
  final IconData icon;

  AuthField(
      {required this.hintText, required this.controller, required this.icon});
}
