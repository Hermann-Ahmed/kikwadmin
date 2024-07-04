import 'package:kikwadmin/views/const/consts.dart';

import 'normal_test.dart';
import 'package:intl/intl.dart' as intl;

AppBar appbarWidget(title) {
  return AppBar(
    backgroundColor: white,
    automaticallyImplyLeading: false,
    title: boldText(text: title, color: fontGrey, size: 16.0),
    actions: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: normalText(
                text:
                    intl.DateFormat('EEE, MMM d, ' 'yy').format(DateTime.now()),
                color: purpleColor)),
      ),
      10.heightBox,
    ],
  );
}
