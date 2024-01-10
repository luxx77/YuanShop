import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/auth/view/auth_screen.dart' as auth;
import 'package:hh_express/features/chat/screens/chat/chat.dart';
import 'package:hh_express/features/filter/details/view/filter_details.dart';
import 'package:hh_express/features/filter/selected_details/selected_filter_details.dart';
import 'package:hh_express/features/more_simmilar_products/view/more_sim_prods.dart';
import 'package:hh_express/features/products_by_category/view/products_by_category.dart';
import 'package:hh_express/features/mainScreen/view/main_screen.dart';
import 'package:hh_express/features/notifications/view/notification_screen.dart';
import 'package:hh_express/features/orders/view/details/orders_screen.dart';
import 'package:hh_express/features/product_details/view/product_details.dart';
import 'package:hh_express/features/search/view/search_screen.dart';
import 'package:hh_express/features/video/view/details/video_details.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/splash_screen.dart';
import 'package:hh_express/models/categories/category_model.dart';
import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/models/videos/video_model.dart';
import 'package:hh_express/settings/consts.dart';

enum EnumNavRoutes { home, video, category, cart, profile }

class AppRoutes {
  // static List<String> navBar = [
  //   '/${EnumNavRoutes.home.name}',
  //   '/${EnumNavRoutes.video.name}',
  //   '/${EnumNavRoutes.category.name}',
  //   '/${EnumNavRoutes.cart.name}',
  //   '/${EnumNavRoutes.profile.name}',
  // ];

  static const mainScreen = '/mainScreen';
  static const search = '/search';
  static const splashScreen = '/splashScreen';
  static const filterDetails = '/filterDetails';
  static const auth = '/auth';
  static const orderDetails = '/orderDetails';
  static const productByCategory = '/productByCategory';
  static const notifications = '/notifications';
  static const prodDetails = '/prodDetails';
  static const videoDetails = '/videoDetails';
  static const chat = '/chat';
  static const moreSimmilarProducts = '/moreSimmilarProducts';
  static const filterSelecteds = '/filterSelecteds';
}

final appRouter = GoRouter(
  initialLocation: AppRoutes.splashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.mainScreen,
      name: AppRoutes.mainScreen.toRouteName,
      builder: (context, state) {
        return MainScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.splashScreen,
      name: AppRoutes.splashScreen.toRouteName,
      builder: (context, state) {
        return SplashScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.chat,
      name: AppRoutes.chat.toRouteName,
      builder: (context, state) {
        return ChatScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.search,
      name: AppRoutes.search.toRouteName,
      pageBuilder: (context, state) {
        return CustomTransitionPage(
          transitionDuration: AppDurations.duration_250ms,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: SearchScreen(),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.auth,
      name: AppRoutes.auth.toRouteName,
      pageBuilder: (context, state) {
        final extra = state.extra as bool?;
        return CustomTransitionPage(
          child: auth.AuthScreen(
            forSingUp: extra ?? true,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              CupertinoPageTransition(
            linearTransition: true,
            primaryRouteAnimation: animation,
            secondaryRouteAnimation: secondaryAnimation,
            child: child,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.moreSimmilarProducts,
      name: AppRoutes.moreSimmilarProducts.toRouteName,
      builder: (context, state) {
        final slug = state.queryParameters['slug'];
        return MoreSimProdsScreen(slug!);
      },
    ),
    GoRoute(
      path: AppRoutes.orderDetails,
      name: AppRoutes.orderDetails.toRouteName,
      builder: (context, state) {
        final uuid = state.queryParameters['uuid'];
        final orderLength = state.queryParameters['order_length']!.toInt;
        return OrderDetailsScreen(
          ordersLength: orderLength,
          uuid: uuid!,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.productByCategory,
      name: AppRoutes.productByCategory.toRouteName,
      builder: (context, state) {
        return ProductsByCategory(
          category: state.extra as CategoryModel,
        );
      },
    ),
    GoRoute(
      path: AppRoutes.notifications,
      name: AppRoutes.notifications.toRouteName,
      builder: (context, state) {
        return const NotificationScreen();
      },
    ),
    GoRoute(
      path: AppRoutes.prodDetails,
      name: AppRoutes.prodDetails.toRouteName,
      pageBuilder: (context, state) {
        final id = state.extra as int;
        return CupertinoPage(
          child: ProductDetails(id: id),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.videoDetails,
      name: AppRoutes.videoDetails.toRouteName,
      pageBuilder: (context, state) {
        final data = state.extra as HomeVideoModel;
        final index = (state.queryParameters['index'] as String).toInt;
        return CustomTransitionPage(
          child: VideoDetails(
            index: index,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0.0, 1.0),
              end: Offset.zero,
            ).animate(animation),
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset.zero,
                end: const Offset(0.0, -1.0),
              ).animate(secondaryAnimation),
              child: child,
            ),
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.filterDetails,
      name: AppRoutes.filterDetails.toRouteName,
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: FilterDetailsScreen(
            model: state.extra as PropertyModel,
          ),
        );
      },
    ),
    GoRoute(
      path: AppRoutes.filterSelecteds,
      name: AppRoutes.filterSelecteds.toRouteName,
      pageBuilder: (context, state) {
        return CupertinoPage(
          child: SelectedFilterDetails(),
        );
      },
    )
  ],
);
