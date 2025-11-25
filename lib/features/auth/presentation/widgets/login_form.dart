import 'package:e_learning/core/extensions/num_extenstion.dart';
import 'package:e_learning/core/validator/validator_manager.dart';
import 'package:e_learning/features/auth/data/models/params/login_params.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final LoginInputParams loginInputParams;
  const LoginForm(
      {super.key, required this.formKey, required this.loginInputParams});
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: emailController,
            focusNode: emailFocusNode,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (_) {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            onChanged: (value) {
              context.read<LoginInputParams>().email = value;
            },
            decoration: InputDecoration(
              hintText: "email".tr(),
            ),
            validator: (value) => Validator.emailValidation(value),
          ),
          16.sizedH,
          TextFormField(
            controller: passwordController,
            focusNode: passwordFocusNode,
            obscureText: true,
            textInputAction: TextInputAction.done,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            onFieldSubmitted: (_) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              context.read<LoginInputParams>().password = value;
            },
            decoration: InputDecoration(
              hintText: "password".tr(),
            ),
            validator: (value) => Validator.validatePassword(value),
          ),
        ],
      ),
    );
  }
}
