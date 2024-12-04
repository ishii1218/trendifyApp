import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/providers/cart_provider.dart';
import 'package:shopsmart_users_en/providers/products_provider.dart';
import 'package:shopsmart_users_en/providers/user_provider.dart';
import 'package:shopsmart_users_en/providers/wishlist_provider.dart';
import 'package:shopsmart_users_en/screens/cart/cart_screen.dart';
import 'package:shopsmart_users_en/screens/home_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/dashboard_screen.dart';
import 'package:shopsmart_users_en/screens/profile_screen.dart';
import 'package:shopsmart_users_en/screens/search_screen.dart';

class RootScreen extends StatefulWidget {
  static const routeName = '/RootScreen';
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  late List<Widget> screens;
  int currentScreen = 0;
  late PageController controller;
  bool isLoadingProd = true;
  bool isAdmin = false; // New flag to check admin status

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: currentScreen);
    screens = _getScreens(); // Initialize screens based on the role
  }

  Future<void> fetchFCT() async {
    final productsProvider =
        Provider.of<ProductsProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final wishlistsProvider =
        Provider.of<WishlistProvider>(context, listen: false);

    try {
      await Future.wait([
        productsProvider.fetchProducts(),
        cartProvider.fetchCart(),
        wishlistsProvider.fetchWishlist(),
        _checkAdminStatus(userProvider), // Check if the user is an admin
      ]);
    } catch (error) {
      log(error.toString());
    }
  }

  Future<void> _checkAdminStatus(UserProvider userProvider) async {
    try {
      final user = await userProvider.fetchUserInfo();
      setState(() {
        isAdmin = user?.userEmail == "admin@gmail.com";
        screens = _getScreens();
      });
    } catch (error) {
      log(error.toString());
    }
  }

  List<Widget> _getScreens() {
    return [
      const HomeScreen(),
      const SearchScreen(),
      if (isAdmin) const DashboardScreen() else const CartScreen(),
      const ProfileScreen(),
    ];
  }

  @override
  void didChangeDependencies() {
    if (isLoadingProd) {
      fetchFCT();
      setState(() {
        isLoadingProd = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentScreen,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 10,
        height: kBottomNavigationBarHeight,
        onDestinationSelected: (index) {
          setState(() {
            currentScreen = index;
          });
          controller.jumpToPage(currentScreen);
        },
        destinations: [
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.home),
            icon: Icon(IconlyLight.home),
            label: "Home",
          ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.search),
            icon: Icon(IconlyLight.search),
            label: "Search",
          ),
          if (isAdmin)
            const NavigationDestination(
              selectedIcon: Icon(Icons.dashboard),
              icon: Icon(Icons.dashboard_outlined),
              label: "Dashboard",
            )
          else
            NavigationDestination(
              selectedIcon: const Icon(IconlyBold.bag2),
              icon: Badge(
                backgroundColor: Colors.blue,
                textColor: Colors.white,
                label: Text(cartProvider.getCartitems.length.toString()),
                child: const Icon(IconlyLight.bag2),
              ),
              label: "Cart",
            ),
          const NavigationDestination(
            selectedIcon: Icon(IconlyBold.profile),
            icon: Icon(IconlyLight.profile),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}
