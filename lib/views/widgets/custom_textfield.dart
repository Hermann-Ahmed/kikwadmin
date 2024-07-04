import 'package:kikwadmin/views/const/consts.dart';

import 'normal_test.dart';

Widget customTextField({label, hint, controller, isDec = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDec ? 4 : 1,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        /* enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: white)
      ),*/
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey)),
  );
}
