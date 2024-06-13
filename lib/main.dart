import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:user_zeebe_app/consts/app_constants.dart';
import 'package:user_zeebe_app/consts/theme_data.dart';
import 'package:user_zeebe_app/providers/cart_provider.dart';
import 'package:user_zeebe_app/providers/order_provider.dart';
import 'package:user_zeebe_app/providers/product_provider.dart';
import 'package:user_zeebe_app/providers/theme_provider.dart';
import 'package:user_zeebe_app/providers/user_provider.dart';
import 'package:user_zeebe_app/providers/viewed_prod_provider.dart';
import 'package:user_zeebe_app/providers/wishlist_provider.dart';
import 'package:user_zeebe_app/root_screen.dart';

import 'package:user_zeebe_app/screens/auth/forgot_password.dart';
import 'package:user_zeebe_app/screens/auth/login.dart';
import 'package:user_zeebe_app/screens/auth/register.dart';

import 'package:user_zeebe_app/screens/inner_screens/address_details.dart';
import 'package:user_zeebe_app/screens/inner_screens/orders/order_screen.dart';
import 'package:user_zeebe_app/screens/inner_screens/products_details.dart';
import 'package:user_zeebe_app/screens/inner_screens/viewed_recently.dart';
import 'package:user_zeebe_app/screens/inner_screens/wishlist_screen.dart';
import 'package:user_zeebe_app/screens/onboard/onbord.dart';
import 'package:user_zeebe_app/screens/search_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
        future: Firebase.initializeApp(
          options: FirebaseOptions(
            apiKey: AppConstants.apiKey,
            appId: AppConstants.appId,
            messagingSenderId: AppConstants.messagingSenderId,
            projectId: AppConstants.projectId,
            storageBucket: AppConstants.storagebucket,
          ),
        ),
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
                return ProductProvider();
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
            ],
            child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'ZEEBE GOSS',
                theme: Styles.themeData(
                    isDarkTheme: themeProvider.getIsDarkTheme,
                    context: context),
                home: const OnboardingPage(),
                // home: const LoginScreen(),
                routes: {
                  RootScreen.routeName: (context) => const RootScreen(),
                  ProductDetailsScreen.routName: (context) =>
                      const ProductDetailsScreen(),
                  WishlistScreen.routName: (context) => const WishlistScreen(),
                  ViewedRecentlyScreen.routName: (context) =>
                      const ViewedRecentlyScreen(),
                  RegisterScreen.routeName: (context) => const RegisterScreen(),
                  LoginScreen.routeName: (context) => const LoginScreen(),
                  OrdersScreenFree.routeName: (context) =>
                      const OrdersScreenFree(),
                  ForgotPasswordScreen.routeName: (context) =>
                      const ForgotPasswordScreen(),
                  SearchScreen.routeName: (context) => const SearchScreen(),
                  AddDeliveryAddress.routeName: (ctx) => AddDeliveryAddress(
                        onOrderPlaced: () {},
                      ),
                  OnboardingPage.routeName: (context) => const OnboardingPage(),
                },
              );
            }),
          );
        });
  }
}
