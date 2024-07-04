import 'package:get/get.dart';
import 'package:kikwadmin/controllers/profile_controller.dart';
import 'package:kikwadmin/views/const/consts.dart';
import 'package:kikwadmin/views/widgets/loadoing_indicator.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/normal_test.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_ios_new, color: white,).onTap(() => Get.back(),),
        //automaticallyImplyLeading: false,
        title: boldText(text: shopSettings, size: 16.0),
        actions: [
          //IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
          controller.isloading.value
              ? loadingIndicator()
              : TextButton(
                  onPressed: () async {
                    controller.isloading(true);
                    await controller.updateShop(
                        shopaddress: controller.shopAdressController.text,
                        shopdesc: controller.shopDescController.text,
                        shopmobile: controller.shopMobileController.text,
                        shopname: controller.shopNameController.text,
                        shopwebsite: controller.shopWebsiteController.text);
                    VxToast.show(context, msg: "Shop updated");
                  },
                  child: normalText(text: save))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            customTextField(
                label: shopName,
                hint: nameHint,
                controller: controller.shopNameController),
            10.heightBox,
            customTextField(
                label: address,
                hint: shopAddressHint,
                controller: controller.shopAdressController),
            10.heightBox,
            customTextField(
                label: mobile,
                hint: shopMobileHint,
                controller: controller.shopMobileController),
            10.heightBox,
            customTextField(
                label: website,
                hint: shopWebsiteHint,
                controller: controller.shopWebsiteController),
            10.heightBox,
            customTextField(
                label: description,
                hint: shopDescHint,
                isDec: true,
                controller: controller.shopDescController),
          ],
        ),
      ),
    );
  }
}
