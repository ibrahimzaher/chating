import 'package:chating/model/my_user.dart';

abstract class RegisterNavigator {
  void showLoading();
  void hideLoading();
  void showMessage({required String message});
  void goToNext(MyUser myUser);
}
