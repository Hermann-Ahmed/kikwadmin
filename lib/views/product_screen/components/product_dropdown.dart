import 'package:get/get.dart';
import 'package:kikwadmin/views/widgets/normal_test.dart';

import '../../../controllers/products_controller.dart';
import '../../const/consts.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Obx(
      () => DropdownButtonHideUnderline(
        child: DropdownButton(
            hint: normalText(text: "$hint", color: fontGrey),
            value: dropvalue.value == '' ? null : dropvalue.value,
            isExpanded: true,
            items: list.map((e) {
              return DropdownMenuItem(
                value: e,
                child: e.toString().text.make(),
              );
            }).toList(),
            onChanged: (newValue) {
              if (hint == "Category") {
                controller.subcategoryvalue.value = '';
                controller.populateSubcategory(newValue.toString());
              }
              dropvalue.value = newValue.toString();
            }),
      )
          .box
          .white
          .padding(const EdgeInsets.symmetric(horizontal: 4))
          .roundedSM
          .make(),
  );
}
// productDropdown(
//     hint, List<String> list, dropvalue, ProductsController controller) {
//   return Obx(
//     () => DropdownButtonHideUnderline(
//       child: DropdownButton(
//           hint: normalText(text: "$hint", color: fontGrey),
//           value: dropvalue.value == '' ? null : dropvalue.value,
//           items: list.map((e) {
//             return DropdownMenuItem(
//               value: e,
//               child: e.toString().text.make(),
//             );
//           }).toList(),
//           onChanged: (newValue) {
//             if (hint == "Category") {
//               controller.populateSubcategory(newValue.toString());
//             }
//             dropvalue.value = newValue.toString();
//           }),
//     )
//         .box
//         .white
//         .padding(const EdgeInsets.symmetric(horizontal: 120))
//         .roundedSM
//         .make(),
//   );
// }
