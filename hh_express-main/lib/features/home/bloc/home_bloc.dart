import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/models/delivery_info/deliery_info_model.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/models/products/product_model.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc()
      : super(HomeState(
          state: ProductAPIState.init,
        ));

  final _repo = getIt<ProductRepo>();
  double lastPosition = 0;
  List<PropertyValue> _filters = List.empty();
  Future<void> init({bool forUpdate = false}) async {
    if (state.state != ProductAPIState.init &&
        state.state != ProductAPIState.error &&
        !forUpdate) {
      return;
    }
    emit(
      HomeState(
        deliveryInfo: state.deliveryInfo,
        state: ProductAPIState.loading,
      ),
    );
    final data = await _repo.getProducts(
      slugs: List.empty(),
      properties: _filters.map((e) => e.id).toList(),
      page: 0,
    );
    DeliveryInfoModel? deliveryInfo;
    if (state.deliveryInfo == null) {
      deliveryInfo = await _repo.getDeliveryInfo();
      
    } else {
      deliveryInfo = state.deliveryInfo;
    }
    if (data != null && deliveryInfo != null) {
      return emit(
        HomeState(
          state: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          prods: List.from(data[APIKeys.products]),
          deliveryInfo: deliveryInfo,
        ),
      );
    }
    return emit(HomeState(
        deliveryInfo: state.deliveryInfo, state: ProductAPIState.error));
  }

  Future<void> loadMore() async {
    emit(
      HomeState(
        deliveryInfo: state.deliveryInfo,
        state: ProductAPIState.loadingMore,
        pagination: state.pagination,
        prods: List.from(
          state.prods ?? List.empty(),
        ),
      ),
    );
    final data = await _repo.getProducts(
      slugs: List.empty(),
      properties: List.empty(),
      page: state.pagination!.currentPage + 1,
    );
    if (data != null) {
      return emit(
        HomeState(
          deliveryInfo: state.deliveryInfo,
          state: ProductAPIState.success,
          pagination: data[APIKeys.pagination],
          prods: List.from(state.prods ?? List.empty())
            ..addAll(data[APIKeys.products]),
        ),
      );
    }
    return emit(
      HomeState(
        deliveryInfo: state.deliveryInfo,
        state: ProductAPIState.loadingMoreError,
        pagination: state.pagination,
        prods: List.from(state.prods ?? List.empty()),
      ),
    );
  }

  void filter(List<PropertyValue> props) {
    _filters = List.from(props);
    lastPosition = 0;
    init(forUpdate: true);
  }
}
