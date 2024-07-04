import 'package:kikwadmin/controllers/orders_controller.dart';

import '../const/consts.dart';
import 'package:get/get.dart';

import '../widgets/normal_test.dart';
import '../widgets/ourButton.dart';
import 'components/order_place.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.put(OrdersController());
  @override
  void initState() {
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.delivered.value = widget.data['order_delivered'];
    controller.onDelivery.value = widget.data['order_on_delivery'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: darkGrey,
              )),
          title: boldText(text: "Order details", color: fontGrey),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
              width: context.screenWidth,
              child: ourButton(
                  color: green,
                  onPress: () {
                    controller.confirmed(true);
                    controller.changeStatus(
                        title: "order_confirmed",
                        status: true,
                        docID: widget.data.id);
                  },
                  title: "Confirm Order")),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              //order delivery section
              Visibility(
                visible: !controller.confirmed.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    boldText(text: "Order status", color: fontGrey, size: 16.0),
                    SwitchListTile(
                      value: true,
                      onChanged: (value) {},
                      title: boldText(text: "Placed", color: fontGrey),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: controller.confirmed.value,
                      onChanged: (value) {
                        controller.confirmed.value = value;
                        controller.changeStatus(
                            title: "order_confirmed",
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: "Confirmed", color: fontGrey),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: controller.onDelivery.value,
                      onChanged: (value) {
                        controller.onDelivery.value = value;
                        controller.changeStatus(
                            title: "order_on_delivery",
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: "On delivery", color: fontGrey),
                      activeColor: green,
                    ),
                    SwitchListTile(
                      value: controller.delivered.value,
                      onChanged: (value) {
                        controller.delivered.value = value;
                        controller.changeStatus(
                            title: "order_delivered",
                            status: value,
                            docID: widget.data.id);
                      },
                      title: boldText(text: "Delivered", color: fontGrey),
                      activeColor: green,
                    ),
                  ],
                )
                    .box
                    .outerShadowMd
                    .white
                    .padding(const EdgeInsets.all(8))
                    .border(color: lightGrey)
                    .roundedSM
                    .make(),
              ),

              //order details section
              Column(
                children: [
                  orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: "Order code",
                      title2: "Shipping Method"),
                  orderPlaceDetails(
                      d1: intl.DateFormat.yMd()
                          .format(widget.data['order_date'].toDate()),
                      d2: "${widget.data['payment_method']}",
                      title1: "Order date",
                      title2: "Payment Method"),
                  orderPlaceDetails(
                      d1: "Unpaid",
                      d2: "Order placed",
                      title1: "Payment status",
                      title2: "Delivery status"),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            boldText(
                                text: "Shipping Address", color: purpleColor),
                            //"Shipping Address".text.fontFamily(semibold).make(),
                            "${widget.data['order_by_name']}".text.make(),
                            "${widget.data['order_by_email']}".text.make(),
                            "${widget.data['order_by_address']}".text.make(),
                            "${widget.data['order_by_city']}".text.make(),
                            "${widget.data['order_by_state']}".text.make(),
                            "${widget.data['order_by_phone']}".text.make(),
                            "${widget.data['order_by_postalcode']}".text.make(),
                          ],
                        ),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Total Amount", color: purpleColor),
                              boldText(
                                  text: "\$${widget.data['total_amount']}",
                                  color: red),
                              // "Total Amount".text.fontFamily(semibold).make(),
                              //"${data['total_amount']}".text.color(redColor).fontFamily(bold).make(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
                  .box
                  .outerShadowMd
                  .white
                  .border(color: lightGrey)
                  .roundedSM
                  .make(),
              const Divider(),
              10.heightBox,
              boldText(text: "Ordered Products", color: purpleColor),
              10.heightBox,
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(controller.orders.length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      orderPlaceDetails(
                        title1: "${controller.orders[index]['title']}",
                        title2: "${controller.orders[index]['tprice']}",
                        d1: "${controller.orders[index]['qty']}x",
                        d2: "Refundable",
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          width: 30,
                          height: 20,
                          color: purpleColor,
                        ),
                      ),
                      const Divider(),
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .white
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
              /*Row(
                  children: [
                    "SUB TOTAL:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                    "TAX:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                    "SHIPPING COAST:".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                    "DISCOUNT :".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                  ],
                ),*/
            ],
          ),
        ),
      ),
    );
  }
}
