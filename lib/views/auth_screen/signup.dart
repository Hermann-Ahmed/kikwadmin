import 'package:get/get.dart';
import 'package:kikwadmin/views/widgets/ourButton.dart';

import '../../controllers/auth_controller.dart';
import '../const/consts.dart';
import '../home_screen/home.dart';
import '../widgets/applogo_widget.dart';
import '../widgets/custom_textfield2.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogoWidget(),
            10.heightBox,
            "Rejoignez $appname".text.fontFamily("sans_bold").white.size(18).make(),
            15.heightBox,
            Obx(
                  () => Column(
                children: [
                  customTextField2(
                      title: name,
                      hint: nameHint,
                      isPass: false,
                      controller: nameController),
                  customTextField2(
                      title: email,
                      hint: emailHint,
                      isPass: false,
                      controller: emailController),
                  customTextField2(
                      title: password,
                      hint: passwordHint,
                      isPass: true,
                      controller: passwordController),
                  customTextField2(
                      title: retypePassword,
                      hint: passwordHint,
                      isPass: true,
                      controller: passwordRetypeController),

                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                        activeColor: purpleColor,
                        value: isCheck,
                        onChanged: (newValue) {
                          setState(() {
                            isCheck = newValue;
                          });
                        },
                        checkColor: white,
                      ),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                              TextSpan(
                                  text: "J'accepte ",
                                  style:
                                  TextStyle(fontFamily: "sans_bold", color: fontGrey)),
                              TextSpan(
                                  text: termAndCond,
                                  style:
                                  TextStyle(fontFamily: "sans_bold", color: purpleColor)),
                              TextSpan(
                                  text: " & ",
                                  style:
                                  TextStyle(fontFamily: "sans_bold", color: fontGrey)),
                              TextSpan(
                                  text: privacyPolicy,
                                  style:
                                  TextStyle(fontFamily: "sans_bold", color: purpleColor)),
                            ])),
                      ),
                    ],
                  ),
                  controller.isloading.value ? const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(red),
                  ) : ourButton(
                      color: isCheck == true ? purpleColor : lightGrey,
                      title: signup,
                      onPress: () async {
                        if(isCheck != false){
                          controller.isloading(true);
                          try {
                            await controller
                                .signupMethod(
                                context: context,
                                email: emailController.text, password: passwordController.text)
                                .then((value) {
                              return controller.storeUserData(
                                  email: emailController.text,
                                  password: passwordController.text,
                                  name: nameController.text);
                            }).then((value) {
                              VxToast.show(context, msg: "Inscription réussie");
                              Get.offAll(() => const Home());
                            });
                          } catch (e) {
                            auth.signOut();
                            VxToast.show(context, msg: "Deconnecter");
                            controller.isloading(false);
                          }
                        }
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                        TextSpan(
                            text: alreadyHaveAccount,
                            style: TextStyle(fontFamily: "sans_bold", color: fontGrey)),
                        TextSpan(
                            text: login,
                            style: TextStyle(fontFamily: "sans_bold", color: Colors.blue)),
                      ])).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowSm
                  .make(),
            )
          ],
        ),
      ),
    );
  }
}
