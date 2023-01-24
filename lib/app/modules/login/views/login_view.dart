import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code/app/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final TextEditingController emailC = TextEditingController();
  final TextEditingController passC = TextEditingController();

  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          Image.asset("assets/images/Illustration.png"),
          const SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Login account",
                  style: GoogleFonts.nunito(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFFFFCE38)),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  autocorrect: false,
                  controller: emailC,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(9))),
                ),
                const SizedBox(
                  height: 20,
                ),
                Obx(() => TextField(
                      autocorrect: false,
                      controller: passC,
                      keyboardType: TextInputType.text,
                      obscureText: controller.isHidden.value,
                      decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: IconButton(
                              onPressed: (() {
                                controller.isHidden.toggle();
                              }),
                              icon: Icon(controller.isHidden.isFalse
                                  ? Icons.remove_red_eye
                                  : Icons.visibility_off)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(9))),
                    )),
                const SizedBox(
                  height: 35,
                ),
                ElevatedButton(
                  onPressed: () async {
                    if (controller.isLoading.isFalse) {
                      if (emailC.text.isNotEmpty && passC.text.isNotEmpty) {
                        controller.isLoading(true);
                        Map<String, dynamic> hasil =
                            await authC.login(emailC.text, passC.text);
                        controller.isLoading(false);
                        if (hasil["error"] == true) {
                          Get.snackbar("Error", hasil["message"]);
                        } else {
                          Get.offAllNamed(Routes.home);
                        }
                      } else {
                        Get.snackbar("Error", "Email dan password wajib diisi");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: Size(MediaQuery.of(context).size.width, 60),
                      backgroundColor: const Color(0xFFFFCE38),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9)),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 20)),
                  child: Obx(
                    () => Text(
                      controller.isLoading.isFalse ? "Login" : "Loading",
                      style: GoogleFonts.nunito(
                          fontSize: 16, fontWeight: FontWeight.w800),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
