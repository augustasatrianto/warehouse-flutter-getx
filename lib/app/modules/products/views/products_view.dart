import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qr_code/app/data/models/product_model.dart';
import 'package:qr_code/app/routes/app_pages.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../controllers/products_controller.dart';

class ProductsView extends GetView<ProductsController> {
  const ProductsView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'List Products',
            style: GoogleFonts.nunito(
                color: Colors.white, fontWeight: FontWeight.w800),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFFFFCE38),
          elevation: 0,
        ),
        body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: controller.streamProducts(),
          builder: (context, snapProducts) {
            if (snapProducts.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapProducts.data!.docs.isEmpty) {
              return const Center(
                child: Text("No Products"),
              );
            }
            List<ProductModel> allProducts = [];
            for (var element in snapProducts.data!.docs) {
              allProducts.add(ProductModel.fromJson(element.data()));
            }

            return ListView.builder(
              itemCount: allProducts.length,
              padding: const EdgeInsets.all(20),
              itemBuilder: (context, index) {
                ProductModel product = allProducts[index];
                return Card(
                  elevation: 0,
                  color: const Color.fromARGB(255, 235, 235, 235),
                  margin: const EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(9)),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(9),
                    onTap: () {
                      Get.toNamed(Routes.detailProduct, arguments: product);
                    },
                    child: Container(
                      height: 104,
                      padding: const EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 32,
                                backgroundColor: Colors.white,
                                child: QrImage(
                                  data: product.code,
                                  // size: 200,
                                  version: QrVersions.auto,
                                ),
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.code,
                                    style: GoogleFonts.nunito(
                                      color: Color(0xff263238),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(product.name,
                                      style: GoogleFonts.nunito(
                                        color: Color(0xff263238),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                  Text("${product.qty} ${product.unit}",
                                      style: GoogleFonts.nunito(
                                        color: Color(0xff263238),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          const Icon(
                            Icons.keyboard_arrow_right,
                            size: 50,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ));
  }
}
