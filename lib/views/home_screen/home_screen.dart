import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kikwadmin/services/store_services.dart';
import 'package:kikwadmin/views/product_screen/product_details.dart';
import 'package:kikwadmin/views/widgets/loadoing_indicator.dart';

import '../const/consts.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/dashboard_button.dart';
import '../widgets/normal_test.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbarWidget(dashboard),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator(circleColor: white);
              } else {
                var data = snapshot.data!.docs;
                data = data.sortedBy(
                  (a, b) =>
                      b['p_wishlist'].length.compareTo(a['p_wishlist'].length),
                );

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: products,
                              count: "${data.length}",
                              icon: icProducts),
                          dashboardButton(context,
                              title: orders, count: "15", icon: icOrders),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardButton(context,
                              title: rating, count: "60", icon: icStar),
                          dashboardButton(context,
                              title: totalSales, count: "15", icon: icVendus),
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(text: popular, color: fontGrey, size: 16.0),
                      20.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,
                            (index) => data[index]['p_wishlist'] == 0
                                ? const SizedBox()
                                : ListTile(
                                    onTap: () {
                                      Get.to(() => ProductDetails(
                                            data: data[index],
                                          ));
                                    },
                                    leading: Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                        text: "${data[index]['p_name']}",
                                        color: fontGrey),
                                    subtitle: normalText(
                                        text: "${data[index]['p_price']} Fcfa",
                                        color: red),
                                  )),
                      ),
                    ],
                  ),
                );
              }
            })));
  }
}
