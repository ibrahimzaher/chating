import 'package:chating/add_room/add_room_navigator.dart';
import 'package:chating/add_room/add_room_view_model.dart';
import 'package:chating/model/category.dart';
import 'package:chating/utils.dart';
import 'package:chating/widgets/custom_text_form_field.dart';
import 'package:chating/widgets/main_widget.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class AddRoomView extends StatefulWidget {
  const AddRoomView({Key? key}) : super(key: key);
  static const String routeName = 'room';

  @override
  State<AddRoomView> createState() => _AddRoomViewState();
}

class _AddRoomViewState extends State<AddRoomView> implements AddRoomNavigator {
  AddRoomViewModel viewModel = AddRoomViewModel();
  TextEditingController roomTitle = TextEditingController();

  TextEditingController roomDescription = TextEditingController();

  var formKey = GlobalKey<FormState>();
  List<Category> categories = Category.getCategories();
  late Category selectedItem;
  @override
  void initState() {
    super.initState();
    viewModel.navigator = this;
    selectedItem = categories[0];
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddRoomViewModel>(
      create: (context) => viewModel,
      child: MainWidget(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              'Add Room',
            ),
          ),
          body: Form(
            key: formKey,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  15,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              padding: const EdgeInsets.all(
                14,
              ),
              margin: const EdgeInsets.symmetric(
                horizontal: 18,
                vertical: 32,
              ),
              child: SingleChildScrollView(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Create New Room',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Image.asset(
                      'assets/images/group.png',
                    ),
                    CustomTextFormField(
                        hintText: 'Room Title',
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter room title';
                          }
                          return null;
                        },
                        controller: roomTitle),
                    DropdownButton<Category>(
                      value: selectedItem,
                      onChanged: (newCategory) {
                        if (newCategory == null) return;
                        selectedItem = newCategory;
                        setState(() {});
                      },
                      items: categories
                          .map(
                            (e) => DropdownMenuItem<Category>(
                              value: e,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    e.title,
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * .1,
                                  ),
                                  Image.asset(
                                    e.image,
                                    width: 50,
                                    height: 30,
                                  ),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    CustomTextFormField(
                        hintText: 'Room Description',
                        validate: (text) {
                          if (text == null || text.trim().isEmpty) {
                            return 'Please Enter room Description';
                          }
                          return null;
                        },
                        maxLength: 3,
                        minLength: 3,
                        controller: roomDescription),
                    ElevatedButton(
                      onPressed: () {
                        validateForm();
                      },
                      child: const Text(
                        'Create',
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void validateForm() {
    if (formKey.currentState!.validate()) {
      viewModel.addRoom(
          roomTitle: roomTitle.text,
          roomDescription: roomDescription.text,
          categoryId: selectedItem.id);
    }
  }

  @override
  void hideLoading() {
    Utils.hideLoading(context);
  }

  @override
  void navigateToHome() {
    Navigator.of(context).pop();
  }

  @override
  void showLoading() {
    Utils.showLoading(context);
  }

  @override
  void showMessage(String message) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              if (await InternetConnectionChecker().hasConnection) {
                navigateToHome();
              }
            },
            child: const Text(
              'Ok',
            ),
          ),
        ],
      ),
    );
  }
}
