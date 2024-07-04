import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:kikwadmin/controllers/products_controller.dart';
import 'package:kikwadmin/services/store_services.dart';
import 'package:kikwadmin/views/const/consts.dart';
import 'package:kikwadmin/views/product_screen/add_product.dart';
import 'package:kikwadmin/views/widgets/loadoing_indicator.dart';

import '../widgets/appbar_widget.dart';
import '../widgets/normal_test.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());
    return Scaffold(
      backgroundColor: white,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => const AddProduct());
          },
          backgroundColor: purpleColor,
          child: const Icon(Icons.add, color: white,),
        ),
        appBar: appbarWidget(products),
        body: StreamBuilder(
            stream: StoreServices.getProducts(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                        children: List.generate(
                            data.length,
                            (index) => Card(
                                  child: ListTile(
                                    onTap: () {},
                                    leading: Image.network(
                                      data[index]['p_imgs'][0],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    title: boldText(
                                        text: "${data[index]['p_name']}",
                                        color: fontGrey),
                                    subtitle: Row(
                                      children: [
                                        normalText(
                                            text: "${data[index]['p_price']} Fcfa",
                                            color: darkGrey),
                                        10.widthBox,
                                        boldText(
                                            text: data[index]['is_featured'] ==
                                                    true
                                                ? "Featured"
                                                : '',
                                            color: green)
                                      ],
                                    ),
                                    trailing: VxPopupMenu(
                                      arrowSize: 0.0,
                                      menuBuilder: () => Column(
                                          children: List.generate(
                                        popMenuTitles.length,
                                        (i) => Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            children: [
                                              Icon(
                                                popupMenuIcons[i],
                                                color:
                                                    data[index]['featured_id'] ==
                                                                currentUser!
                                                                    .uid &&
                                                            i == 0
                                                        ? green
                                                        : darkGrey,
                                              ),
                                              10.widthBox,
                                              normalText(
                                                  text:
                                                      data[index]['featured_id'] ==
                                                                  currentUser!
                                                                      .uid &&
                                                              i == 0
                                                          ? 'Remove Featured'
                                                          : popMenuTitles[i],
                                                  color: darkGrey)
                                            ],
                                          ).onTap(() {
                                            switch (i) {
                                              case 0:
                                                if (data[index]
                                                        ['is_featured'] ==
                                                    true) {
                                                  controller.removeFutured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Removed");
                                                } else {
                                                  controller.addFutured(
                                                      data[index].id);
                                                  VxToast.show(context,
                                                      msg: "Added");
                                                }
                                                break;

                                              case 1:
                                                break;
                                              case 2:
                                                controller.removeProduct(
                                                    data[index].id);
                                                VxToast.show(context,
                                                    msg: 'Product removed');
                                                break;
                                              default:
                                            }
                                          }),
                                        ),
                                      )).box.white.rounded.width(200).make(),
                                      clickType: VxClickType.singleClick,
                                      child:
                                          const Icon(Icons.more_vert_rounded),
                                    ),
                                  ),
                                ))),
                  ),
                );
              }
            })
        // return Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: SingleChildScrollView(
        //     physics: const BouncingScrollPhysics(),
        //     child: Column(
        //       children:
        //         List.generate(data.length, (index) => Card(
        //           child: ListTile(
        //             onTap: (){
        //               Get.to(() => ProductDetails(
        //                 data: data[index],
        //               ));
        //             },
        //             leading: Image.network(
        //               data[index]['p_imgs'][0],
        //               width: 100,
        //               height: 100,
        //               fit: BoxFit.cover,
        //             ),
        //             title: boldText(
        //                 text: "${data[index]['p_name']}",
        //                 color: fontGrey),
        //             subtitle: Row(
        //               children: [
        //                 normalText(
        //                     text: "\$${data[index]['p_price']}",
        //                     color: darkGrey),
        //                 10.widthBox,
        //                 boldText(
        //                     text:
        //                     data[index]['is_featured'] == true
        //                         ? "Featured"
        //                         : '',
        //                     color: green),
        //               ],
        //             ),
        //             trailing: VxPopupMenu(
        //               arrowSize: 0.0,
        //               menuBuilder: () => Column(
        //                   children: List.generate(
        //                     popMenuTitles.length,
        //                         (index) => Padding(
        //                       padding: const EdgeInsets.all(12.0),
        //                       child: Row(
        //                         children: [
        //                           Icon(popupMenuIcons[index]),
        //                           10.widthBox,
        //                           normalText(
        //                               text: popMenuTitles[index],
        //                               color: darkGrey)
        //                         ],
        //                       ).onTap(() {}),
        //                     ),
        //                   )).box.white.rounded.width(200).make(),
        //               clickType: VxClickType.singleClick,
        //               child: const Icon(Icons.more_vert_rounded),
        //             ),
        //           ),
        //         ))

        //     ),
        //   ),
        // );
        );
  }
}
