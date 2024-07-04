import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwadmin/controllers/auth_controller.dart';
import 'package:kikwadmin/views/auth_screen/login.dart';
import 'package:kikwadmin/views/const/consts.dart';
import 'package:kikwadmin/views/order_screen/orders_screen.dart';
import 'package:kikwadmin/views/product_screen/product_screen.dart';

import '../../controllers/profile_controller.dart';
import '../../services/store_services.dart';
import 'package:get/get.dart';

import '../messages_screen/messages_screen.dart';
import '../shop_screen/shop_settings_screen.dart';

import '../widgets/loadoing_indicator.dart';
import '../widgets/normal_test.dart';
import 'edit_profilescreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: purpleColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: settings, size: 16.0),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signoutMethod(context);
                  Get.offAll(() => const LoginScreen());
                },
                child: normalText(text: logout))
          ],
        ),
        body: FutureBuilder(
            future: StoreServices.getProfile(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(circleColor: white);
              } else {
                controller.snapshotData = snapshot.data!.docs[0];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: controller.snapshotData['imageUrl'] == ''
                            ? Image.asset(icLogoApp)
                                .box
                                .white
                                .roundedFull
                                .clip(Clip.antiAlias)
                                .make()
                            : Image.network(
                                controller.snapshotData['imageUrl'],
                                width: 100,
                              ).box.roundedFull.clip(Clip.antiAlias).make(),
                        title: boldText(
                            text: "${controller.snapshotData['vendor_name']}"),
                        subtitle: normalText(
                            text: "${controller.snapshotData['email']}"),
                      ),
                      const Divider(),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: List.generate(
                              profileButtonsIcons.length,
                              (index) => ListTile(
                                    onTap: () {
                                      switch (index) {
                                        case 0:
                                          Get.to(() => const ShopSettings());
                                          break;

                                        case 1:
                                          Get.to(() => const OrdersScreen());
                                          break;

                                        case 2:
                                          Get.to(() => const ProductsScreen());
                                          break;

                                        default:
                                      }
                                    },
                                    leading: Icon(
                                      profileButtonsIcons[index],
                                      color: white,
                                    ),
                                    title: normalText(
                                        text: profileButtonsTitles[index]),
                                  )),
                        ),
                      )
                    ],
                  ),
                );
              }
            }));
  }
}
