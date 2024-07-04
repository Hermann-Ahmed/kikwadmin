
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';
import '../const/consts.dart';
import '../order_screen/orders_screen.dart';
import '../product_screen/product_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'home_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const HomeScreen(),
      const ProductsScreen(),
      const OrdersScreen(),
      const ProfileScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            color: darkGrey,
            width: 24,
          ),
          label: products),
      BottomNavigationBarItem(
        icon: Image.asset(
          icOrders,
          color: darkGrey,
          width: 24,
        ),
        label: orders,
      ),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSettings,
            color: darkGrey,
            width: 24,
          ),
          label: settings),
    ];

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: fontGrey,
          items: bottomNavBar),
      body: Obx(
        () => Column(
          children: [
            Expanded(child: navScreens.elementAt(controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
