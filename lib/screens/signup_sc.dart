import 'package:art_sweetalert/art_sweetalert.dart';
import 'package:beggining/controllers/auth_controller.dart';
import 'package:beggining/factory/assets_factory.dart';
import 'package:beggining/factory/color_factory.dart';
import 'package:beggining/widgets/circular_progress_indicator.dart';
import 'package:beggining/widgets/input_field_widget.dart';
import 'package:dim_loading_dialog/dim_loading_dialog.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignupSc extends StatelessWidget {
  const SignupSc({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find<AuthController>();
    TextEditingController _emailController = TextEditingController();
    TextEditingController _passwordController = TextEditingController();
    TextEditingController _nameController = TextEditingController();

    // Loading Dilog code
    DimLoadingDialog loadingDialog = DimLoadingDialog(
      context,
      loadingWidget: CircularProgressIndicatorClass(
        circularProgressIndicator: CircularProgressIndicator(),
      ).cPI(),
      blur: 2,
      backgroundColor: const Color(0x33000000),
      animationDuration: const Duration(milliseconds: 5000),
    );

    return Scaffold(
      backgroundColor: ColorFactory.background,
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      "Sign Up",
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
                    hintText: "Name",
                    controller: _nameController,
                    backgroundColor: ColorFactory.textTertiary,
                  ),
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
                  const SizedBox(
                    height: 20,
                  ),
                  //Sign Up Button
                  Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: ColorFactory.primary.withValues(alpha: 0.4),
                          blurRadius: 40,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        loadingDialog.show();
                        try {
                          await authController.signUp(
                            _nameController.text,
                            _emailController.text,
                            _passwordController.text,
                          );
                          loadingDialog.dismiss();
                          _nameController.clear();
                          _passwordController.clear();
                          _emailController.clear();
                          ArtSweetAlert.show(
                            context: context,
                            artDialogArgs: ArtDialogArgs(
                              type: ArtSweetAlertType.success,
                              title: "User Created",
                              text: "${_nameController.text} has been created",
                              confirmButtonColor: ColorFactory.primary,
                              onConfirm: () => Get.offAllNamed("/signin"),
                            ),
                          );
                        } catch (e) {
                          print('error creating user $e');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorFactory.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Text(
                        'Creat Account',
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
                        text: 'Do you have account? ',
                        style: TextStyle(
                          color: Colors.black,
                        ),
                        children: [
                          TextSpan(
                            text: 'Sign In',
                            style: TextStyle(
                              color: Colors.blue,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed(("/signin"));
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

Widget facebookAndGoogleAuthButtons() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      //Facebook Button
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: Get.width * 0.42,
        height: 55,
        decoration: BoxDecoration(
          color: ColorFactory.textTertiary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                AssetsFactory.facebook,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Facebook",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),

      //Google Button
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        width: Get.width * 0.42,
        height: 55,
        decoration: BoxDecoration(
          color: ColorFactory.textTertiary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            SizedBox(
              height: 24,
              width: 24,
              child: SvgPicture.asset(
                AssetsFactory.google,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              "Google",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    ],
  );
}

Widget seperator() {
  return Row(
    children: [
      Expanded(
        child: Container(
          height: 1,
          color: ColorFactory.seperatorColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.only(left: 8, right: 8),
        child: Text(
          'Or',
          style: TextStyle(
            color: ColorFactory.textSecondary,
            fontSize: 16,
          ),
        ),
      ),
      Expanded(
        child: Container(
          height: 1,
          color: ColorFactory.seperatorColor,
        ),
      ),
    ],
  );
}
