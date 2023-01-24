import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Stream<QuerySnapshot<Map<String, dynamic>>> streamProducts() async* {
    yield* firestore
        .collection("products")
        .orderBy(
          "code",
        )
        .snapshots();
  }
}
