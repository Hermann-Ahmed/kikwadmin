import 'package:get/get.dart';
import 'package:kikwadmin/views/auth_screen/signup.dart';

import '../../controllers/auth_controller.dart';
import '../const/consts.dart';
import '../home_screen/home.dart';
import '../widgets/loadoing_indicator.dart';
import '../widgets/normal_test.dart';
import '../widgets/ourButton.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return 
      Scaffold(
        backgroundColor: purpleColor,
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18.0),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(
                      icLogoKonguil,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                        .box
                        .white
                        .border(color: white)
                        .rounded
                        .padding(const EdgeInsets.all(8))
                        .make(),
                    10.widthBox,
                    boldText(text: appname, size: 20.0)
                  ],
                ),
                60.heightBox,
                normalText(text: loginTo, size: 18.0, color: lightGrey),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: textfieldGrey,
                            prefixIcon: Icon(
                              Icons.email,
                              color: purpleColor,
                            ),
                            border: InputBorder.none,
                            hintText: emailHint),
                      ),
                      20.heightBox,
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                            filled: true,
                            fillColor: textfieldGrey,
                            prefixIcon: Icon(
                              Icons.lock,
                              color: purpleColor,
                            ),
                            border: InputBorder.none,
                            hintText: passwordHint),
                      ),
                      10.heightBox,
                      Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: normalText(
                                  text: forgotPassword, color: purpleColor))),
                      20.heightBox,
                      SizedBox(
                        width: context.screenWidth - 50,
                        child: controller.isloading.value
                            ? loadingIndicator()
                            : ourButton(
                              color: purpleColor,
                                title: login,
                                onPress: () async {
                                  controller.isloading(true);
                                   await controller
                                       .loginMethod(context: context)
                                       .then((value) {
                                     if (value != null) {
                                       VxToast.show(context, msg: "loggedin");
                                       Get.offAll(() => const Home());
                                    } else {
                                       controller.isloading(false);
                                     }
                                   });
                                  /*try {
                                      await auth
                                        .signInWithEmailAndPassword(
                                            email:
                                                controller.emailController.text,
                                            password: controller
                                                .passwordController.text)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: "logged in");
                                        Get.offAll(() => const Home());
                                      }
                                    });
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      VxToast.show(context,
                                          msg: "User not found");
                                      controller.isloading(false);
                                    } else if (e.code == 'wrong-password') {
                                      VxToast.show(context,
                                          msg:
                                              "Wrong password provided for that user.");
                                      controller.isloading(false);
                                    }
                                  }*/
                                }),
                      ),
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .outerShadowMd
                      .padding(const EdgeInsets.all(8))
                      .make(),
                ),
                10.heightBox,
                createNewAccount.text.color(white).make(),
                10.heightBox,
                ourButton(
                  color: Colors.cyan,
                    title: signup,
                    onPress: () {
                      Get.to(() => const SignupScreen());
                    }).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                Center(
                  child: normalText(text: anyProblem),
                ),
                const Spacer(),
                Center(
                  child: boldText(text: credit),
                ),
                20.heightBox,
              ],
            ),
          ),
        ),
      )
    ;
  }
}
