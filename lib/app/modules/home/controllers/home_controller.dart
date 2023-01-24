import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:qr_code/app/data/models/product_model.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  RxList<ProductModel> allProducts = List<ProductModel>.empty().obs;
  void downloadCatalog() async {
    final pdf = pw.Document();

    var getData = await firestore.collection("products").get();

    allProducts([]);

    for (var element in getData.docs) {
      allProducts.add(ProductModel.fromJson(element.data()));
    }
    // Jika 1 hal : pakai Page , Harus pakai Column di awal return
    // Jika lebih dari 1 hal : pakai MultiPage
    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return [
            pw.Center(
                child: pw.Text("CATALOG PRODUCT",
                    textAlign: pw.TextAlign.center,
                    style: const pw.TextStyle(fontSize: 24))),
            pw.SizedBox(height: 20),
            pw.Table(
                border: pw.TableBorder.all(
                    color: PdfColor.fromHex("#000000"), width: 2),
                children: [
                  pw.TableRow(children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text("No",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text("Product Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text("Product Name",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text("Quantity",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(20),
                      child: pw.Text("QR Code",
                          textAlign: pw.TextAlign.center,
                          style: pw.TextStyle(
                              fontSize: 10, fontWeight: pw.FontWeight.bold)),
                    ),
                  ]),
                  ...List.generate(allProducts.length, (index) {
                    ProductModel product = allProducts[index];
                    return pw.TableRow(children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text("${index + 1}",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            )),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(product.code,
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            )),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text(product.name,
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            )),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(20),
                        child: pw.Text("${product.qty}",
                            textAlign: pw.TextAlign.center,
                            style: const pw.TextStyle(
                              fontSize: 10,
                            )),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(20),
                        child: pw.BarcodeWidget(
                            color: PdfColor.fromHex("#000000"),
                            barcode: pw.Barcode.qrCode(),
                            data: product.code,
                            height: 50,
                            width: 50),
                      ),
                    ]);
                  })
                ])
          ];
        }));

    // simpan
    Uint8List bytes = await pdf.save();

    // buat file kosong di direktori
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/mydocument.pdf');

    // memasukkan data bytes ke file kosong
    await file.writeAsBytes(bytes);

    //open pdf
    await OpenFile.open(file.path);
  }

  Future getProductById(String codeBarang) async {
    try {
      var hasil = await firestore
          .collection("products")
          .where("code", isEqualTo: codeBarang)
          .get();
      if (hasil.docs.isEmpty) {
        return {"error": true, "message": "Tidak ada product ini di database"};
      }

      Map<String, dynamic> data = hasil.docs.first.data();

      return {
        "error": false,
        "message": "Berhasil mendapatkan detail product dari product code ini",
        "data": ProductModel.fromJson(data),
      };
    } catch (e) {
      return {
        "error": true,
        "message": "Tidak mendapatkan detail product dari product code ini"
      };
    }
  }
}
