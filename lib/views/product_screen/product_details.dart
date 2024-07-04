import 'package:get/get.dart';

import '../const/consts.dart';
import '../widgets/normal_test.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkGrey,
            )),
        title: boldText(text: "${data['p_name']}", color: fontGrey),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VxSwiper.builder(
              autoPlay: true,
              height: 350,
              aspectRatio: 16 / 9,
              viewportFraction: 1.0,
              itemCount: data['p_imgs'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_imgs'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                );
              }),
          10.heightBox,
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                boldText(
                    text: "${data['p_name']}", color: fontGrey, size: 16.0),
                10.heightBox,
                Row(
                  children: [
                    boldText(
                        text: "${data['p_category']}",
                        color: fontGrey,
                        size: 16.0),
                    10.widthBox,
                    normalText(
                        text: "${data['p_subcategory']}",
                        color: fontGrey,
                        size: 16.0),
                  ],
                ),
                10.heightBox,
                VxRating(
                  isSelectable: false,
                  value: double.parse(data['p_rating']),
                  onRatingUpdate: (value) {},
                  normalColor: textfieldGrey,
                  selectionColor: golden,
                  count: 5,
                  maxRating: 5,
                  size: 25,
                ),
                10.heightBox,
                boldText(text: "\$${data['p_price']}", color: red, size: 18.0),
                /*"${data['p_price']}"
                    .numCurrency
                    .text
                    .color(redColor)
                    .fontFamily(bold)
                    .size(18)
                    .make(),*/
                20.heightBox,
                Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: boldText(text: "color", color: fontGrey),
                          //"Color: ".text.color(textfieldGrey).make(),
                        ),
                        Row(
                          children: List.generate(
                              data['p_colors'].length,
                              (index) => VxBox()
                                      .size(40, 40)
                                      .roundedFull
                                      //.color(Vx.randomPrimaryColor)
                                      .color(Color(data['p_colors'][index])
                                          .withOpacity(1.0))
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .make()
                                      .onTap(() {
                                    VxToast.show(context,
                                        msg:
                                            "couleur à l'index $index cliquée ");
                                    // controller.changeColorIndex(index);
                                  })),
                        ),
                      ],
                    ),
                    10.heightBox,
                    Row(
                      children: [
                        SizedBox(
                          width: 100,
                          child: boldText(text: "Quantity", color: fontGrey),
                        ),
                        normalText(
                            text: "${data['p_quantity']} items",
                            color: fontGrey)
                      ],
                    ),
                  ],
                ).box.white.padding(const EdgeInsets.all(8)).make(),
                const Divider(),
                15.heightBox,
                boldText(text: "Description", color: fontGrey),
                10.heightBox,
                normalText(text: "${data['p_desc']}", color: fontGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
