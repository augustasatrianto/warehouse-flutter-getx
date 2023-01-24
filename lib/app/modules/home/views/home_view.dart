import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code/app/controllers/auth_controller.dart';
import 'package:qr_code/app/routes/app_pages.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);
  final AuthController authC = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "My Warehouse",
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w800),
          ),
          backgroundColor: const Color(0xFFFFCE38),
          toolbarHeight: 60,
          elevation: 0.0,
          centerTitle: true,
          leadingWidth: 80,
          leading: const CircleAvatar(
            backgroundColor: Color(0xFFFFCE38),
            child: CircleAvatar(
              backgroundColor: Color(0xffE6E6E6),
              backgroundImage: AssetImage('assets/images/me.jpg'),
              radius: 24,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.logout_outlined),
              color: Colors.white,
              iconSize: 28.0,
              onPressed: () async {
                Map<String, dynamic> hasil = await authC.logout();
                if (hasil["error"] == false) {
                  Get.offAllNamed(Routes.login);
                } else {
                  Get.snackbar("Error", hasil["error"]);
                }
              },
            ),
          ],
          systemOverlayStyle: const SystemUiOverlayStyle(
            // Status bar color
            statusBarColor: Colors.transparent,

            // Status bar brightness (optional)
            statusBarIconBrightness:
                Brightness.light, // For Android (dark icons)
          )),
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
            ),
            Image.asset("assets/images/Illustration.png"),
            Container(
              height: 450,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  // color: Colors.red,
                  borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              )),
              margin: const EdgeInsets.only(top: 300),
              padding: const EdgeInsets.all(20),
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    late String title;
                    late IconData icon;
                    late VoidCallback onTap;
                    switch (index) {
                      case 0:
                        title = "Add Product";
                        icon = Icons.post_add_rounded;
                        onTap = () => Get.toNamed(Routes.addProduct);
                        break;
                      case 1:
                        title = "Products";
                        icon = Icons.list_alt_outlined;
                        onTap = () => Get.toNamed(Routes.products);
                        break;
                      case 2:
                        title = "QR Code";
                        icon = Icons.qr_code;
                        onTap = () async {
                          String barcode =
                              await FlutterBarcodeScanner.scanBarcode(
                                  "#000000", "CANCEL", true, ScanMode.QR);

                          Map<String, dynamic> hasil =
                              await controller.getProductById(barcode);
                          if (hasil["error"] == false) {
                            Get.toNamed(Routes.detailProduct,
                                arguments: hasil["data"]);
                          } else {
                            Get.snackbar(
                              "Error",
                              hasil["message"],
                              duration: const Duration(seconds: 2),
                            );
                          }
                        };

                        break;
                      case 3:
                        title = "Catalog";
                        icon = Icons.document_scanner_outlined;
                        onTap = () {
                          controller.downloadCatalog();
                        };
                        break;
                      default:
                    }
                    return Material(
                      color: Colors.white,
                      shadowColor: const Color(0x284e4e4e),
                      elevation: 16,
                      borderRadius: BorderRadius.circular(9),
                      child: InkWell(
                        onTap: onTap,
                        borderRadius: BorderRadius.circular(9),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 50,
                              child: Icon(
                                icon,
                                size: 60,
                                color: const Color(0xFF828282),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              title,
                              style: GoogleFonts.nunito(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: const Color(0xFF828282)),
                            )
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
