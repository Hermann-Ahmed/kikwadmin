import 'package:get/get.dart';
import 'package:kikwadmin/controllers/products_controller.dart';
import 'package:kikwadmin/views/const/consts.dart';
import 'package:kikwadmin/views/product_screen/components/product_dropdown.dart';
import 'package:kikwadmin/views/widgets/loadoing_indicator.dart';

import '../widgets/custom_textfield.dart';
import '../widgets/normal_test.dart';
import 'components/product_images.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();
    return Obx(() => Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: purpleColor,
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: white,
              ),
            ),
            title: boldText(text: "Ajout produit", size: 16.0),
            actions: [
              controller.isloading.value
                  ? loadingIndicator(circleColor: white)
                  : TextButton(
                      onPressed: () async {
                        controller.isloading(true);
                        await controller.uploadImages();
                        await controller.uploadProduct(context);
                        // VxToast.show(context, msg: "Added");
                        Get.back();
                      },
                      child: boldText(text: save, color: white)),
            ],
          ),
          body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customTextField(
                            hint: "ex Une chambre, Boutique, Hôtel Radisson....",
                            label: "Nom du produit",
                            controller: controller.pnameController),
                        10.heightBox,
                        customTextField(
                            hint: "Description du produit",
                            label: "Description",
                            isDec: true,
                            controller: controller.pdescController),
                        10.heightBox,
                        customTextField(
                            hint: "Av Kondol Béaloum, Moursal",
                          label: "Adresse",
                            controller: controller.paddressController),
                        10.heightBox,
                        customTextField(
                            hint: "N'Djamena",
                          label: "Ville",
                            controller: controller.pvilleController),
                        10.heightBox,
                        /*customTextField(hint: "ex BMW", label: "Product name"),
                10.heightBox,*/
                        customTextField(
                            hint: "62****78",
                            label: "Contact",
                            controller: controller.pcontactController),
                        10.heightBox,
                        customTextField(
                            hint: "25000",
                            label: "Prix",
                            controller: controller.ppriceController),
                        10.heightBox,
                        /*customTextField(hint: "ex BMW", label: "Product name"),
                10.heightBox,*/
                        // productDropdown("Category", controller.categoryList,
                        //     controller.categoryvalue, controller),
                        10.heightBox,
                        productDropdown("Category", controller.categoryList,
                            controller.categoryvalue, controller),
                        10.heightBox,
                        productDropdown(
                            "Subcategory",
                            controller.subcategoryList,
                            controller.subcategoryvalue,
                            controller),

                        // productDropdown("Subcategory", controller.subcategoryList,
                        //     controller.subcategoryvalue, controller),
                        10.heightBox,
                        const Divider(
                          color: white,
                        ),
                        boldText(text: "Ajouter les images du produit"),
                        10.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: List.generate(
                              3,
                              (index) => controller.pImagesList[index] != null
                                  ? Image.file(
                                      controller.pImagesList[index],
                                      width: 100,
                                    ).onTap(() {
                                      controller.pickImage(index, context);
                                    })
                                  : productImages(
                                      label: "${index + 1}",
                                    ).onTap(() {
                                      controller.pickImage(index, context);
                                    })),
                        ),

                        5.heightBox,
                        const Divider(
                          color: white,
                        ),
                        normalText(
                            text: "La première image sera votre image d’affichage"),
                        10.heightBox,
                        // boldText(text: "Choose product colors"),
                        // 10.heightBox,
                        // Wrap(
                        //   spacing: 8.0,
                        //   runSpacing: 8.0,
                        //   children: List.generate(
                        //       9,
                        //       (index) => Stack(
                        //             alignment: Alignment.center,
                        //             children: [
                        //               VxBox()
                        //                   .color(Vx.randomPrimaryColor)
                        //                   .roundedFull
                        //                   .size(65, 65)
                        //                   .make()
                        //                   .onTap(() {
                        //                 controller.selectedColorIdex.value =
                        //                     index;
                        //               }),
                        //               controller.selectedColorIdex.value ==
                        //                       index
                        //                   ? const Icon(
                        //                       Icons.done,
                        //                       color: white,
                        //                     )
                        //                   : const SizedBox()
                        //             ],
                        //           )),
                        // )
                      ]))),
        ));
  }
}

// class AddProduct extends StatelessWidget {
//   const AddProduct({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProductsController());
//     return Obx(
//       () => Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: purpleColor,
//         appBar: AppBar(
//           leading: IconButton(
//               onPressed: () {
//                 Get.back();
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: darkGrey,
//               )),
//           title: boldText(text: "Add your product", size: 16.0),
//           actions: [
//             controller.isloading.value
//                 ? loadingIndicator(circleColor: white)
//                 : TextButton(
//                     onPressed: () async {
//                       controller.isloading(true);
//                       await controller.uploadImages();
//                       await controller.uploadProduct(context);
//                       });
//                       VxToast.show(context, msg: "Added");
//                       Get.back();
//                     },
//                     child: boldText(text: save, color: white)),
//           ],
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: SingleChildScrollView(
//             physics: const BouncingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 customTextField(
//                     hint: "ex BMW",
//                     label: "Product name",
//                     controller: controller.pnameController),
//                 10.heightBox,
//                 customTextField(
//                     hint: "Description of your product",
//                     label: "Description",
//                     isDec: true,
//                     controller: controller.pdescController),
//                 10.heightBox,
//                 customTextField(
//                     hint: "\$100",
//                     label: "Price",
//                     controller: controller.ppriceController),
//                 10.heightBox,
//                 /*customTextField(hint: "ex BMW", label: "Product name"),
//                 10.heightBox,*/
//                 customTextField(
//                     hint: "ex 20",
//                     label: "Quantity",
//                     controller: controller.pquantityController),
//                 10.heightBox,
//                 /*customTextField(hint: "ex BMW", label: "Product name"),
//                 10.heightBox,*/
//                 // productDropdown("Category", controller.categoryList,
//                 //     controller.categoryvalue, controller),
//                 10.heightBox,
//                 productDropdown("Category", controller.categoryList,
//                     controller.categoryvalue, controller),
//                 10.heightBox,
//                 productDropdown("Subcategory", controller.subcategoryList,
//                     controller.subcategoryvalue, controller),
//                 // productDropdown("Subcategory", controller.subcategoryList,
//                 //     controller.subcategoryvalue, controller),
//                 // 10.heightBox,
//                 const Divider(
//                   color: white,
//                 ),
//                 boldText(text: "Choose product images"),
//                 10.heightBox,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   children: List.generate(
//                       3,
//                       (index) => controller.pImagesList[index] != null
//                           ? Image.file(
//                               controller.pImagesList[index],
//                               width: 100,
//                             ).onTap(() {
//                               controller.pickImage(index, context);
//                             })
//                           : productImages(
//                               label: "${index + 1}",
//                             ).onTap(() {
//                               controller.pickImage(index, context);
//                             })),
//                 ),

//                 5.heightBox,
//                 const Divider(
//                   color: white,
//                 ),
//                 normalText(text: "First image will be your display image"),
//                 10.heightBox,
//                 boldText(text: "Choose product colors"),
//                 10.heightBox,
//                 Wrap(
//                   spacing: 8.0,
//                   runSpacing: 8.0,
//                   children: List.generate(
//                       9,
//                       (index) => Stack(
//                             alignment: Alignment.center,
//                             children: [
//                               VxBox()
//                                   .color(Vx.randomPrimaryColor)
//                                   .roundedFull
//                                   .size(65, 65)
//                                   .make()
//                                   .onTap(() {
//                                 controller.selectedColorIdex.value = index;
//                               }),
//                               controller.selectedColorIdex.value == index
//                                   ? const Icon(
//                                       Icons.done,
//                                       color: white,
//                                     )
//                                   : const SizedBox()
//                             ],
//                           )),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
