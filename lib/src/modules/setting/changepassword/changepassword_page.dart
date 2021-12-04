import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/data/providers/storage_provider.dart';
import 'package:mobile_app/src/modules/login/login_signup_page.dart';
import 'package:settings_ui/settings_ui.dart';

import 'changepassword_controller.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  final ChangePasswordController controller = Get.put(ChangePasswordController());

  final _oldPasswordTextController = TextEditingController(text: "");
  final _newPasswordTextController = TextEditingController(text: "");
  final _reNewPasswordTextController = TextEditingController(text: "");

  var _oldPasswordVisible = false;
  var _newPasswordVisible = false;
  var _reNewPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff2d5f79),
        title: Text('Close'),
      ),
      backgroundColor: const Color(0xff88e8f2),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.blueGrey, Colors.lightBlueAccent]),
        ),
        child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32),
            child: Obx(() {
              return Form(
                  key: _formKey,
                  child: Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Text("Change Password",
                                style: TextStyle(
                                    color: Color(0xff88e8f2),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32)),
                            // const SizedBox(height: 8),
                            // TextFormField(
                            //   enabled: !controller.signupProcess.value,
                            //   controller: _emailTextController,
                            //   decoration: const InputDecoration(
                            //       icon: Icon(Icons.person), labelText: "Email"),
                            //   validator: (String? value) =>
                            //   EmailValidator.validate(value!)
                            //       ? null
                            //       : "Please enter a valid email",
                            // ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.changepasswordProcess.value,
                              controller: _oldPasswordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  labelText: "OldPassword",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _oldPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _oldPasswordVisible = !_oldPasswordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_oldPasswordVisible,
                              validator: (String? value) =>
                              value!.trim().isEmpty
                                  ? "Old password is required"
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.changepasswordProcess.value,
                              controller: _newPasswordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  labelText: "NewPassword",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _newPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _newPasswordVisible = !_newPasswordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_newPasswordVisible,
                              validator: (String? value) =>
                              value!.trim().isEmpty
                                  ? "New password is required"
                                  : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.changepasswordProcess.value,
                              controller: _reNewPasswordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  labelText: "ReNewpassword",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _reNewPasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _reNewPasswordVisible = !_reNewPasswordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_reNewPasswordVisible,
                              validator: (String? value) =>
                              value!.trim().isEmpty || value != _newPasswordTextController.text
                                  ? "ReNewpassword is required and must be similar to ..."
                                  : null,
                            ),
                            const SizedBox(height: 32),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: controller.changepasswordProcess.value
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).disabledColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String error = await controller.changepassword(
                                        oldPassword: _oldPasswordTextController.text,
                                        newPassword: _newPasswordTextController.text);
                                    if (error != "") {
                                      Get.defaultDialog(
                                          title: "Oop!", middleText: error);
                                    } else {
                                      Get.offAll(const LoginScreen());
                                    }
                                  }
                                },
                                child: const Text(
                                  "Change Password",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            //const OldTime(),
                          ]),
                    ),
                  ));
            })),
      ),
    );
  }
}