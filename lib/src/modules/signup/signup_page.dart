import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_app/src/global_widgets/button_new_user.dart';
import 'package:mobile_app/src/global_widgets/input_field.dart';
import 'package:mobile_app/src/modules/login/login_page.dart';
import 'package:mobile_app/src/modules/signup/signup_controller.dart';
import 'package:mobile_app/src/routes/app_routes.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final SignupController controller = Get.put(SignupController());

  final _emailTextController = TextEditingController(text: "");
  final _passwordTextController = TextEditingController(text: "");
  final _rePasswordTextController = TextEditingController(text: "");

  var _passwordVisible = false;
  var _rePasswordVisible = false;
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
                              enabled: !controller.signupProcess.value,
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
                              enabled: !controller.signupProcess.value,
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
                                      ? "Password is required"
                                      : null,
                            ),
                            const SizedBox(height: 8),
                            TextFormField(
                              enabled: !controller.signupProcess.value,
                              controller: _rePasswordTextController,
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.lock),
                                  labelText: "Repassword",
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _rePasswordVisible
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: Theme.of(context).primaryColorDark,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _rePasswordVisible = !_rePasswordVisible;
                                      });
                                    },
                                  )),
                              obscureText: !_rePasswordVisible,
                              validator: (String? value) =>
                                  value!.trim().isEmpty || value != _passwordTextController.text
                                      ? "Repassword is required and must be similar to ..."
                                      : null,
                            ),
                            const SizedBox(height: 32),
                            Material(
                              elevation: 5.0,
                              borderRadius: BorderRadius.circular(30),
                              color: controller.signupProcess.value
                                  ? Theme.of(context).disabledColor
                                  : Theme.of(context).primaryColor,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                padding:
                                    const EdgeInsets.fromLTRB(20, 15, 20, 15),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    String error = await controller.signup(
                                        email: _emailTextController.text,
                                        password: _passwordTextController.text);
                                    if (error != "") {
                                      Get.defaultDialog(
                                          title: "Oop!", middleText: error);
                                    } else {
                                      Get.to(const LoginPage());
                                    }
                                  }
                                },
                                child: const Text(
                                  "Sign Up",
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