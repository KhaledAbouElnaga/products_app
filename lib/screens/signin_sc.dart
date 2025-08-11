import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:beggining/controllers/auth_controller.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:beggining/screens/signup_sc.dart';
import 'package:beggining/widgets/input_field_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SigninSc extends StatelessWidget {
  const SigninSc({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    _emailController.text = "john@mail.com";
    _passwordController.text = "changeme";
    return Scaffold(
      backgroundColor: ColorFactory.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: ColorFactory.textPrimary,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "It was popularised in the 1960s with the release of Letraset sheetscontaining Lorem Ipsum.",
                    style: const TextStyle(
                        color: ColorFactory.textSecondary, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  facebookAndGoogleAuthButtons(),
                  SizedBox(
                    height: 20,
                  ),
                  seperator(),
                  const SizedBox(
                    height: 20,
                  ),
                  InputFieldWidget(
                      hintText: "Email/Phone Number",
                      controller: _emailController,
                      backgroundColor: ColorFactory.textTertiary),
                  const SizedBox(
                    height: 20,
                  ),
                  InputFieldWidget(
                      hintText: "Password",
                      controller: _passwordController,
                      isPass: true,
                      backgroundColor: ColorFactory.textTertiary),
                  Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forget Password?",
                        style: TextStyle(
                          color: ColorFactory.textSecondary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // Sign In Button
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorFactory.primary.withValues(alpha: 0.5),
                          blurRadius: 40,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        try {
                          await authController.logIn(
                            _emailController.text,
                            _passwordController.text,
                          );
                          ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                              type: ArtSweetAlertType.success,
                              title: "Loged In",
                              confirmButtonColor: ColorFactory.primary,
                              onConfirm: () => Get.offAllNamed("/bottonNB"),
                            ),
                          );
                        } catch (e) {
                          print('Error Whil Loginig In $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorFactory.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Log In',
                        style: TextStyle(
                          color: ColorFactory.textWhite,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    // width: double.infinity,
                    padding: EdgeInsets.only(left: 16),
                    child: RichText(
                      text: TextSpan(
                        text: 'Don’t have account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign Up',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAllNamed("/signup");
                              },
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
