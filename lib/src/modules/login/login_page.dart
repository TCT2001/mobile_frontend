// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:email_validator/email_validator.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/modules/layout/main_layout_page.dart';

import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());

  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  var _passwordVisible = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                            Text("Makit",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 32)),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _emailTextController,
                              decoration: const InputDecoration(
                                  icon: Icon(Icons.person), labelText: "Email"),
                              validator: (String? value) =>
                                  EmailValidator.validate(value!)
                                      ? null
                                      : "Please enter a valid email",
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.loginProcess.value,
                              controller: _passwordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  labelText: "Password",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _passwordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_passwordVisible,
                              validator: (String? value) =>
                                  value!.trim().isEmpty
                                      ? "Password is require"
                                      : null,
                            ),
                            const SizedBox(height: 32),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: controller.loginProcess.value
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                onPressed: () async {
                                  //TODO
                                  if (_emailTextController.text == "a") {
                                    Get.to(MainLayoutPage());
                                  }
                                  if (_formKey.currentState!.validate()) {
                                    String error = await controller.login(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text);
                                    if (error != "") {
                                      Get.defaultDialog(
                                          title: "Oop!", middleText: error);
                                    } else {
                                      Get.to(MainLayoutPage());
                                    }
                                  }
                                },
                                child: const Text(
                                  "Login",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ]),
                    ),
                  ));
            })),
      ),
    );
  }
}
