import 'package:chating/home/home_view.dart';
import 'package:chating/login/login_navigator.dart';
import 'package:chating/model/my_user.dart';
import 'package:chating/provider/user_provider.dart';
import 'package:chating/register/register_view.dart';
import 'package:chating/utils.dart';
import 'package:chating/widgets/custom_button_icon.dart';
import 'package:chating/widgets/custom_spacer.dart';
import 'package:chating/widgets/custom_text_form_field.dart';
import 'package:chating/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_view_model.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);
  static const String routeName = 'Login';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> implements LoginNavigator {
  var fromState = GlobalKey<FormState>();
  var email = TextEditingController();
  var password = TextEditingController();
  LoginViewModel viewModel = LoginViewModel();
  @override
  void initState() {
    viewModel.navigator = this;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => viewModel,
      child: MainWidget(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Create Account'),
          ),
          body: Form(
            key: fromState,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Welcome back!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  CustomSpacer(
                    height: MediaQuery.of(context).size.height * .01,
                  ),
                  CustomTextFormField(
                    hintText: 'Email',
                    validate: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter email';
                      } else if (!RegExp(r"""
^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+""")
                          .hasMatch(text)) {
                        return 'Please enter valid email';
                      }
                      return null;
                    },
                    controller: email,
                  ),
                  CustomSpacer(),
                  CustomTextFormField(
                    hintText: 'Password',
                    validate: (text) {
                      if (text == null || text.trim().isEmpty) {
                        return 'Please Enter Password';
                      } else if (text.length < 6) {
                        return 'Password must be at least 6 char.';
                      }
                      return null;
                    },
                    controller: password,
                  ),
                  CustomSpacer(
                    height: 18,
                  ),
                  CustomButtonIcon(
                    background: Colors.blue,
                    foreground: Colors.white,
                    onPress: () {
                      validForm();
                    },
                    text: 'Login'.toUpperCase(),
                  ),
                  CustomSpacer(
                    height: 18,
                  ),
                  TextButton(
                    onPressed: () {
                      Utils.goToNext(
                        context,
                        RegisterView.routeName,
                      );
                    },
                    child: const Text(
                      'Not have an Account?',
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validForm() {
    if (fromState.currentState!.validate()) {
      viewModel.loginWithEmailAndPassword(
          email: email.text, password: password.text);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage({required String message}) {
    Utils.showMessage(message: message, context: context);
  }

  @override
  void goToNext(MyUser myUser) {
    var provider = Provider.of<UserProvider>(context, listen: false);
    provider.user = myUser;
    Navigator.pushReplacementNamed(
      context,
      HomeView.routeName,
    );
  }
}
