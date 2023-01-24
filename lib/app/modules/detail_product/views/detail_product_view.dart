import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/detail_product_controller.dart';

class DetailProductView extends GetView<DetailProductController> {
  DetailProductView({Key? key}) : super(key: key);
  final TextEditingController codeC = TextEditingController();
  final TextEditingController nameC = TextEditingController();
  final TextEditingController qtyC = TextEditingController();

  @override
  final ProductModel product = Get.arguments;
  Widget build(BuildContext context) {
    codeC.text = product.code;
    nameC.text = product.name;
    qtyC.text = "${product.qty}";
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Detail Product',
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFFCE38),
          elevation: 0,
        ),
        body: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 200,
                  width: 200,
                  child: QrImage(
                    data: product.code,
                    size: 200,
                    version: QrVersions.auto,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: codeC,
              keyboardType: TextInputType.number,
              readOnly: true,
              maxLength: 10,
              decoration: InputDecoration(
                  labelText: "Product Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: nameC,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  labelText: "Product Name",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              autocorrect: false,
              controller: qtyC,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: "Quantity",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9))),
            ),
            const SizedBox(
              height: 35,
            ),
            ElevatedButton(
              onPressed: () async {
                if (controller.isLoadingUpdate.isFalse) {
                  if (nameC.text.isNotEmpty && qtyC.text.isNotEmpty) {
                    controller.isLoadingUpdate(true);
                    Map<String, dynamic> hasil = await controller.editProduct({
                      "id": product.productId,
                      "name": nameC.text,
                      "qty": int.tryParse(qtyC.text) ?? 0,
                    });
                    controller.isLoadingUpdate(false);
                    Get.snackbar(hasil["error"] == true ? "Error" : "Success",
                        hasil["message"]);
                  } else {
                    Get.snackbar("Error", "Semua data wajib diisi",
                        duration: Duration(seconds: 2));
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
                    controller.isLoadingUpdate.isFalse
                        ? "UPDATE PRODUCT"
                        : "LOADING",
                    style: GoogleFonts.nunito(
                        fontSize: 16, fontWeight: FontWeight.w800)),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            OutlinedButton(
                style: OutlinedButton.styleFrom(
                  fixedSize: Size(MediaQuery.of(context).size.width, 60),
                  side: BorderSide(color: const Color(0xFFFFCE38), width: 1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                ),
                onPressed: () {
                  Get.defaultDialog(
                      title: "Delete Product",
                      middleText: "Are you sure to delete this product?",
                      actions: [
                        OutlinedButton(
                            onPressed: () => Get.back(),
                            child: const Text("Cancel")),
                        ElevatedButton(
                          onPressed: () async {
                            controller.isLoadingDelete(true);
                            Map<String, dynamic> hasil = await controller
                                .deleteProduct(product.productId);
                            controller.isLoadingDelete(false);
                            Get.back();
                            Get.back();
                            Get.snackbar(
                                hasil["error"] == true ? "Error" : "Success",
                                hasil["message"]);
                          },
                          child: Obx(() => controller.isLoadingDelete.isFalse
                              ? const Text("DELETE")
                              : Container(
                                  padding: const EdgeInsets.all(2),
                                  height: 15,
                                  width: 15,
                                  child: const CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 1,
                                  ),
                                )),
                        )
                      ]);
                },
                child: Text(
                  "Delete Product",
                  style: GoogleFonts.nunito(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFFFFCE38),
                  ),
                ))
          ],
        ));
  }
}
