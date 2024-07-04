import 'package:get/get.dart';
import 'package:kikwadmin/views/const/consts.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
  }

  var navIndex = 0.obs;
  var username = "";

  getUsername() async {
    var n = await firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: currentUser!.uid)
        .get()
        .then((value) {
      return value.docs.single['vendor_name'];
    });

    username = n;
  }
}
