import 'package:chating/home/home_view.dart';
import 'package:chating/login/login_view.dart';
import 'package:chating/model/my_user.dart';
import 'package:chating/provider/user_provider.dart';
import 'package:chating/register/register_navigator.dart';
import 'package:chating/register/register_view_model.dart';
import 'package:chating/utils.dart';
import 'package:chating/widgets/custom_button_icon.dart';
import 'package:chating/widgets/custom_spacer.dart';
import 'package:chating/widgets/custom_text_form_field.dart';
import 'package:chating/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);
  static const String routeName = 'Register';
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView>
    implements RegisterNavigator {
  var fromState = GlobalKey<FormState>();
  var firstName = TextEditingController();
  var lastName = TextEditingController();
  var userName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  RegisterViewModel viewModel = RegisterViewModel();
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
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text('Create Account'),
          ),
          body: Form(
            key: fromState,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      CustomSpacer(
                        height: MediaQuery.of(context).size.height * .1,
                      ),
                      CustomTextFormField(
                        hintText: 'First Name',
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter First Name';
                          }
                          return null;
                        },
                        controller: firstName,
                      ),
                      CustomSpacer(),
                      CustomTextFormField(
                        hintText: 'Last Name',
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter Last Name';
                          }
                          return null;
                        },
                        controller: lastName,
                      ),
                      CustomSpacer(),
                      CustomTextFormField(
                        hintText: 'User Name',
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter User Name';
                          }
                          return null;
                        },
                        controller: userName,
                      ),
                      CustomSpacer(),
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
                        background: Colors.white,
                        foreground: Colors.black54,
                        onPress: () {
                          validForm();
                        },
                        text: 'Create Account',
                      ),
                      CustomSpacer(
                        height: 18,
                      ),
                      TextButton(
                        onPressed: () {
                          Utils.goToNext(context, LoginView.routeName);
                        },
                        child: const Text(
                          'Have An Account?',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validForm() {
    if (fromState.currentState!.validate()) {
      viewModel.createAccount(
        email: email.text,
        password: password.text,
        firstName: firstName.text,
        userName: userName.text,
        lastName: lastName.text,
      );
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
