import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwadmin/services/store_services.dart';
import 'package:kikwadmin/views/widgets/loadoing_indicator.dart';
import '../../controllers/orders_controller.dart';
import '../const/consts.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/normal_test.dart';
import 'package:intl/intl.dart' as intl;
import 'package:get/get.dart';

import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
      appBar: appbarWidget(orders),
      body: StreamBuilder(
          stream: StoreServices.getOrders(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return 
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      children: List.generate(data.length, (index) {
                    var time = data[index]['order_date'].toDate();
                    return ListTile(
                      onTap: () {
                        Get.to(() => OrderDetails(
                              data: data[index],
                            ));
                      },
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: textfieldGrey,
                      title: boldText(
                          text: "${data[index]['order_code']}",
                          color: fontGrey),
                      subtitle: Column(
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.calendar_month,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              normalText(
                                  text:
                                      intl.DateFormat().add_yMd().format(time),
                                  color: fontGrey),
                            ],
                          ),
                          Row(
                            children: [
                              const Icon(
                                Icons.payment,
                                color: fontGrey,
                              ),
                              10.widthBox,
                              normalText(text: "Unpaid", color: red),
                            ],
                          ),
                        ],
                      ),
                      trailing: boldText(
                          text: "${data[index]['total_amount']}",
                          color: purpleColor,
                          size: 16.0),
                    ).box.margin(const EdgeInsets.only(bottom: 4)).make();
                  })),
                ),
              );
            }
          }),
    );
  }
}
