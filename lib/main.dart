import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:provider/provider.dart';
import 'package:shopsmart_users_en/providers/admin/admin_order_provider.dart';
import 'package:shopsmart_users_en/providers/admin/admin_product_provider.dart';
import 'package:shopsmart_users_en/providers/order_provider.dart';
import 'package:shopsmart_users_en/providers/products_provider.dart';
import 'package:shopsmart_users_en/providers/address_provider.dart';

import 'package:shopsmart_users_en/providers/theme_provider.dart';
import 'package:shopsmart_users_en/root_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/admin_search_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/dashboard_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/admin/edit_upload_product_form.dart';
import 'package:shopsmart_users_en/screens/inner_screen/orders/admin/admin_orders_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/orders/admin/payment_screen.dart';
import 'package:shopsmart_users_en/screens/inner_screen/orders/checkout_page.dart';
import 'package:shopsmart_users_en/screens/inner_screen/product_details.dart';
import 'package:shopsmart_users_en/screens/inner_screen/viewed_recently.dart';

import 'consts/theme_data.dart';
import 'providers/cart_provider.dart';
import 'providers/user_provider.dart';
import 'providers/viewed_recently_provider.dart';
import 'providers/wishlist_provider.dart';
import 'screens/auth/forgot_password.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/inner_screen/orders/orders_screen.dart';
import 'screens/inner_screen/wishlist.dart';
import 'screens/search_screen.dart';
import 'splashscreen.dart';
import 'splashscreen2.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey =
      'pk_test_51PRWiNP2j6GyuA7Txuu5OLDVqCbhkBHJS1vsZmIqs8ruadbfnYftQTUd6xYtr1Y5NtfY1MzKwYu5poX50SwFcb9s00qRJ4Ftu6';
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: "AIzaSyCtYTs3UnxZ1tM-E_DlZanKytQ10WjzjRA",
            authDomain: "trendify-fdbf0.firebaseapp.com",
            projectId: "trendify-fdbf0",
            storageBucket: "trendify-fdbf0.firebasestorage.app",
            messagingSenderId: "970044811034",
            appId: "1:970044811034:web:7ea7484fb5a84882406ea3"));
  } else {
    await Firebase.initializeApp();
  }

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: Center(
                  child: SelectableText(snapshot.error.toString()),
                ),
              ),
            );
          }
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) {
                return ThemeProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ProductsProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return CartProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return WishlistProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return ViewedProdProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return UserProvider();
              }),
              ChangeNotifierProvider(create: (_) {
                return OrderProvider();
              }),
              ChangeNotifierProvider(
                create: (_) => AdminProductProvider(),
              ),
              ChangeNotifierProvider(
                create: (_) => AdminOrderProvider(),
              ),
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'Trendify Shopping',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                // home: const RootScreen(),
                // home: const LoginScreen(),
                home: const SplashScreen(),
                onGenerateRoute: (settings) {
                  if (settings.name == CheckoutPage.routeName) {
                    final args = settings.arguments as Map<String, dynamic>;
                    return MaterialPageRoute(
                      builder: (context) => CheckoutPage(
                        orderItems:
                            args['orderItems'] as List<Map<String, dynamic>>,
                        totalPrice: args['totalPrice'] as double,
                      ),
                    );
                  }

                  // Add more routes here if needed.
                  return null;
                },

                routes: {
                  AddressFormPage.routeName: (context) => AddressFormPage(),
                  RootScreen.routeName: (context) => const RootScreen(),
                  SplashScreen2.routeName: (context) => const SplashScreen2(),
                  SplashScreen.routeName: (context) => const SplashScreen(),
                  ProductDetailsScreen.routName: (context) =>
                      const ProductDetailsScreen(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  DashboardScreen.routeName: (context) =>
                      const DashboardScreen(),

                  EditOrUploadProductScreen.routeName: (context) =>
                      const EditOrUploadProductScreen(),
                  // ignore: equal_keys_in_map
                  AdminSearchScreen.routeName: (context) =>
                      const AdminSearchScreen(),
                  AdminOrdersScreenFree.routeName: (context) =>
                      const AdminOrdersScreenFree(),
                  PaymentScreen.routeName: (context) => const PaymentScreen(),

                  // CheckoutPage.routeName: (context) => const CheckoutPage(),
                  // SearchScreen.routeName: (context) => const SearchScreen(),
                  // OrdersScreenFree.routeName: (context) => const OrdersScreenFree(),
                },
              );
            }),
          );
        });
  }
}
