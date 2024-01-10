// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:hh_express/repositories/address/address_repo.dart' as _i3;
import 'package:hh_express/repositories/address/address_repo_impl.dart' as _i4;
import 'package:hh_express/repositories/auth/auth_repositori.dart' as _i5;
import 'package:hh_express/repositories/auth/auth_repositori_impl.dart' as _i6;
import 'package:hh_express/repositories/cart/cart_repository.dart' as _i7;
import 'package:hh_express/repositories/cart/cart_repository_impl.dart' as _i8;
import 'package:hh_express/repositories/categories/categories_repository.dart'
    as _i9;
import 'package:hh_express/repositories/categories/categories_repository_impl.dart'
    as _i10;
import 'package:hh_express/repositories/chat/chat_repository.dart' as _i11;
import 'package:hh_express/repositories/chat/chat_repository_impl.dart' as _i12;
import 'package:hh_express/repositories/filters/filters_repository.dart'
    as _i15;
import 'package:hh_express/repositories/filters/filters_repository_impl.dart'
    as _i16;
import 'package:hh_express/repositories/notifications/notifications_repo.dart'
    as _i17;
import 'package:hh_express/repositories/notifications/notifications_repo_impl.dart'
    as _i18;
import 'package:hh_express/repositories/order/order_repo.dart' as _i19;
import 'package:hh_express/repositories/order/order_repo_impl.dart' as _i20;
import 'package:hh_express/repositories/products/product_repo.dart' as _i21;
import 'package:hh_express/repositories/products/product_repo_impl.dart'
    as _i22;
import 'package:hh_express/repositories/profile/favorites/favorites_repository.dart'
    as _i13;
import 'package:hh_express/repositories/profile/favorites/favorites_repository_impl.dart'
    as _i14;
import 'package:hh_express/repositories/video/video_repo.dart' as _i23;
import 'package:hh_express/repositories/video/video_repo_impl.dart' as _i24;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.AddressRepo>(() => _i4.AddressRepoImpl());
    gh.factory<_i5.AuthRepo>(() => _i6.AuthRepoImpl());
    gh.factory<_i7.CartRepo>(() => _i8.CartRepoImpl());
    gh.factory<_i9.CategoryRepo>(() => _i10.CategoryRepoIMpl());
    gh.factory<_i11.ChatRepo>(() => _i12.ChatRepoIMpl());
    gh.factory<_i13.FavorsRepo>(() => _i14.FavorsRepoImpl());
    gh.factory<_i15.FilterRepo>(() => _i16.FilterRepoImpl());
    gh.factory<_i17.NotificationsRepo>(() => _i18.NotificationsRepoImpl());
    gh.factory<_i19.OrderRepo>(() => _i20.OrderRepoImpl());
    gh.factory<_i21.ProductRepo>(() => _i22.ProductRepoImpl());
    gh.factory<_i23.VideoRepo>(() => _i24.VideoRepoImpl());
    return this;
  }
}
