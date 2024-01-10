import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/features/home/bloc/home_bloc.dart';
import 'package:hh_express/features/products_by_category/bloc/products_by_category_bloc.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/helpers/routes.dart';
import 'package:hh_express/models/pagination/pagination_model.dart';
import 'package:hh_express/models/property/property_model.dart';
import 'package:hh_express/models/property/values/property_value_model.dart';
import 'package:hh_express/repositories/filters/filters_repository.dart';
import 'package:hh_express/repositories/products/product_repo.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

part 'filter_event.dart';
part 'filter_state.dart';

final class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(FilterState.empty(FilterAPIState.init)) {
    final repo = getIt<FilterRepo>();

    on<AddFilterProperty>(
      (event, emit) {
        final theProp = event.model;
        if (isSelected(theProp.id)) return;
        final newState = FilterState.update(state);

        if (forHome) {
          newState.homeSelecteds.add(theProp);
        } else {
          newState.prodByCatselecteds.add(theProp);
        }
        emit(newState);
        switchProdCount();
      },
    );
    on<RemoveFilterProperty>(
      (event, Emitter emit) {
        final theProp = event.model;
        final newState = FilterState.update(state);
        if (forHome) {
          newState.homeSelecteds.remove(theProp);
        } else {
          newState.prodByCatselecteds.remove(theProp);
        }
        emit(newState);
        switchProdCount();
      },
    );
    on<ClearFilter>(
      (event, Emitter emit) {
        final newState = FilterState.update(state);
        if (forHome) {
          newState.homeSelecteds.clear();
        } else {
          newState.prodByCatselecteds.clear();
        }
        emit(newState);
        switchProdCount();
      },
    );
    on<FilterInit>((event, emit) async {
      if (state.properties!.isNotEmpty) return;
      emit(FilterState.empty(FilterAPIState.loading));
      final data = await repo.getProps();
      if (data != null) {
        return emit(
          FilterState(
            filterByNews: false,
            properties: data,
            prodByCatselecteds: List.empty(growable: true),
            homeSelecteds: List.empty(growable: true),
            state: FilterAPIState.success,
          ),
        );
      }
      return emit(FilterState.empty(FilterAPIState.error));
    });
  }
  bool forHome = false;

  bool isSelected(int id) {
    final selecteds = forHome ? state.homeSelecteds : state.prodByCatselecteds;
    final num = selecteds.map((e) => e.id).toList().indexOf(id);
    return num != -1;
  }

  void switchProp(PropertyValue model) {
    if (isSelected(model.id)) {
      add(RemoveFilterProperty(model: model));
      return;
    }
    add(AddFilterProperty(model: model));
  }

  late final List<int> _productCount = [getHomeTotal, getProdByCategoryTotal];

  /// state mannager for count text of products after filter in bottom button of modal sheet
  final productCountNotifier = ValueNotifier<APIState>(APIState.init);

  final productRepo = getIt<ProductRepo>();
  void switchProdCount() async {
    final propList = forHome ? state.homeSelecteds : state.prodByCatselecteds;
    final slugs = forHome
        ? List<String>.empty()
        : [
            appRouter.currentContext
                    .read<ProductsByCategoryBloc>()
                    .state
                    .category
                    ?.slug ??
                ''
          ];
    productCountNotifier.value = APIState.loading;
    final data = await productRepo.getProducts(
      slugs: slugs,
      properties: propList.map((e) => e.id).toList(),
      page: 0,
    );
    if (data != null) {
      final count = (data[APIKeys.pagination] as PaginationModel).total;
      _productCount[forHome ? 0 : 1] = count;
    }

    productCountNotifier.value = APIState.success;
  }

  int get getProdCount => _productCount[forHome ? 0 : 1];
  int get getProdByCategoryTotal {
    final prodByCatBloc =
        appRouter.currentContext.read<ProductsByCategoryBloc>();
    return prodByCatBloc.state.pagination?.total ?? 0;
  }

  int get getHomeTotal {
    final homeBloc = appRouter.currentContext.read<HomeBloc>();
    return homeBloc.state.pagination?.total ?? 0;
  }
}
