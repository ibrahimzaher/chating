import 'package:chating/model/my_user.dart';

abstract class LoginNavigator {
  void showLoading();
  void hideLoading();
  void showMessage({required String message});
  void goToNext(MyUser myUser);
}
