import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:footware_admin/model/product/product.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productImgCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();

  String category = 'general';
  String brand = 'un branded';
  bool offer = false;
  List<Product> products=[];

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  void setCategory(String newCategory) {
    category = newCategory;
    update();
  }

  void setBrand(String newBrand) {
    brand = newBrand;
    update();
  }

  void toggleOffer(bool newOffer) {
    offer = newOffer;
    update();
  }

  void addProduct() {
    try {
      DocumentReference doc = productCollection.doc();
      Product product = Product(
        id: doc.id,
        name: productNameCtrl.text,
        category: category,
        description: productDescriptionCtrl.text,
        price: double.tryParse(productPriceCtrl.text) ?? 0.0,
        brand: brand,
        image: productImgCtrl.text,
        offer: offer,
      );

      final productJson = product.toJson();
      doc.set(productJson);

      Get.snackbar(
        'Success',
        'Product added successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      setValueDefault();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e);
    }
  }

  fetchProducts() async {
   try {
     QuerySnapshot productSnapshot= await productCollection.get();
     final List<Product> retrievedProducts = productSnapshot.docs.map((doc) =>
            Product.fromJson(doc.data() as Map<String, dynamic>)).toList();
     products.clear();
     products.assignAll(retrievedProducts);
     Get.snackbar('Success', 'Product fetch successfully',colorText: Colors.green);
   } catch (e) {
     Get.snackbar('Error', e.toString(),colorText: Colors.red);
     print(e);
   }
  }

  deleteProduct(String id ) async {
    try {
      await productCollection.doc(id).delete();
      fetchProducts();
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      print(e);
    }finally{
      update();
    }
  }

  setValueDefault(){
    productNameCtrl.clear();
    productPriceCtrl.clear();
    productDescriptionCtrl.clear();
    productImgCtrl.clear();
    category ='general';
    brand='un branded';
    offer=false;
    update();
  }
}
