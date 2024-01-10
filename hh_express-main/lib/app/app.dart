import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/features/address/cubit/address_cubit.dart';
import 'package:hh_express/features/auth/bloc/auth_bloc.dart';
import 'package:hh_express/features/cart/cubit/cart_cubit.dart';
import 'package:hh_express/features/categories/bloc/category_bloc.dart';
import 'package:hh_express/features/chat/bloc/chat_bloc.dart';
import 'package:hh_express/features/favors/bloc/favors_bloc.dart';
import 'package:hh_express/features/filter/bloc/filter_bloc.dart';
import 'package:hh_express/features/home/bloc/home_bloc.dart';
import 'package:hh_express/features/mainScreen/view/components/navBar/nav_bar.dart';
import 'package:hh_express/features/order_history/cubit/order_history_cubit.dart';
import 'package:hh_express/features/notifications/cubit/notification_cubit.dart';
import 'package:hh_express/features/product_details/bloc/product_details_bloc.dart';
import 'package:hh_express/features/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:hh_express/features/video/cubit/video_cubit.dart';
import 'package:hh_express/features/video/view/details/cubit/video_details_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/helpers/spacers.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/globals.dart';
import 'package:hh_express/settings/theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    bodyIndex.value = 0;
    super.initState();
  }

  final repo = getIt<ProductRepo>();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NotificationCubit()),
        BlocProvider(create: (context) => ChatBloc()),
        BlocProvider(create: (context) => HomeBloc()),
        BlocProvider(create: (context) => AuthBloc()),
        BlocProvider(create: (context) => CategoryBloc()),
        BlocProvider(create: (context) => ProductsByCategoryBloc()),
        BlocProvider(create: (context) => ProductDetailsBloc()),
        BlocProvider(create: (context) => FilterBloc()),
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => AddressCubit()),
        BlocProvider(create: (context) => OrderHistoryCubit()),
        BlocProvider(create: (context) => FavorsCubit()),
        BlocProvider(create: (context) => VideoCubit()),
        BlocProvider(create: (context) => VideoDetailsCubit()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(360, 800),
        builder: (context, child) {
          return ValueListenableBuilder(
            valueListenable: locale,
            builder: (context, locale, child) {
              locale.log();
              return MaterialApp.router(
                title: 'Yuan Shop',
                supportedLocales: AppLocalizations.supportedLocales,
                routerConfig: appRouter,
                locale: Locale(locale),
                theme: AppTheme.lightTheme,
                debugShowCheckedModeBanner: false,
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                builder: (context, child) {
                  AppSpacing.init(context);
                  return Navigator(
                    onGenerateRoute: (settings) => MaterialPageRoute(
                      builder: (context) {
                        return MediaQuery(
                          data: MediaQuery.of(context)
                              .copyWith(textScaleFactor: 1),
                          child: child!,
                        );
                      },
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
