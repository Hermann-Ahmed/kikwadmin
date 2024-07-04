import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kikwadmin/services/store_services.dart';

import '../const/consts.dart';
import '../widgets/loadoing_indicator.dart';
import '../widgets/normal_test.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart' as intl;
import 'chat_screen.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

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
        title: boldText(text: messages, size: 16.0, color: fontGrey),
      ),
      body: StreamBuilder(
          stream: StoreServices.getMessages(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else {
              var data = snapshot.data!.docs;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Column(
                        children: List.generate(data.length, (index) {
                  var t = data[index]['created_on'] == null
                      ? DateTime.now()
                      : data[index]['created_on'].toDate();
                  var time = intl.DateFormat("h:mma").format(t);
                  return ListTile(
                    onTap: () {
                      Get.to(() => const ChatScreen(), arguments: [
                        data[index]['sender_name'],
                        data[index]['toId'],
                      ]);
                    },
                    leading: const CircleAvatar(
                      backgroundColor: purpleColor,
                      child: Icon(
                        Icons.person,
                        color: white,
                      ),
                    ),
                    title: boldText(
                        text: "${data[index]['sender_name']}", color: fontGrey),
                    subtitle: normalText(
                        text: "${data[index]['last_msg']}", color: darkGrey),
                    trailing: normalText(text: time, color: darkGrey),
                  );
                }))),
              );
            }
          }),
    );
  }
}
