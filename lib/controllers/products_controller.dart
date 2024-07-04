import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kikwadmin/controllers/home_controller.dart';
import 'package:kikwadmin/views/const/consts.dart';
import 'package:path/path.dart';

import '../models/category_model.dart';

class ProductsController extends GetxController {
  var isloading = false.obs;

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var paddressController = TextEditingController();
  var pvilleController = TextEditingController();
  var pcontactController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  var pImagesLinks = [];
  List<Category> category = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIdex = 0.obs;

  @override
  void onInit() {
    getCategories();
    populateCategoryList();
    super.onInit();
  }

  getCategories() async {
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubcategory(cat) {
    subcategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();
    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index, context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = item;
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference reference = FirebaseStorage.instance.ref().child(destination);
        await reference.putFile(item);
        var n = await reference.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productsCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryvalue.value,
      'p_subcategory': subcategoryvalue.value,
      // 'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_imgs': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_desc': pdescController.text,
      'p_address': paddressController.text,
      'p_city': pvilleController.text,
      'p_contact': pcontactController.text,
      'p_price': ppriceController.text,
      'p_name': pnameController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': "5.0",
      'vendor_id': currentUser!.uid,
      'featured_id': ""
    });
    isloading(false);

    VxToast.show(context, msg: "Produit ajouté");
  }

  addFutured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'featured_id': currentUser!.uid, 'is_featured': true},
        SetOptions(merge: true));
  }

  removeFutured(docId) async {
    await firestore.collection(productsCollection).doc(docId).set(
        {'featured_id': "", 'is_featured': false}, SetOptions(merge: true));
  }

  removeProduct(docId) async {
    await firestore.collection(productsCollection).doc(docId).delete();
  }
}
