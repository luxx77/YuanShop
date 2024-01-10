import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:hh_express/app/setup.dart';
import 'package:hh_express/models/categories/category_model.dart';
import 'package:hh_express/repositories/categories/categories_repository.dart';
import 'package:hh_express/settings/consts.dart';
import 'package:hh_express/settings/enums.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final repo = getIt<CategoryRepo>();

  CategoryBloc() : super(CategoryState(state: CategoryAPIState.init)) {
    on<InitCategories>(
      (event, emit) async {
        //
        emit(
          CategoryState(state: CategoryAPIState.loading),
        );
        final data = await repo.getAll();
        if (data != null) {
          final mains = data[APIKeys.mainCategories]!;
          final subs = data[APIKeys.subCategories]!;
          return emit(
            CategoryState(
              state: CategoryAPIState.success,
              activIndex: 0,
              mains: List<CategoryModel>.from(mains),
              subs: {
                mains.first.slug: subs,
              },
            ),
          );
        }
        emit(
          CategoryState(
            state: CategoryAPIState.error,
          ),
        );
        return;
      },
    );
    //
    on<ChangeCategory>((event, emit) async {
      final index =
          state.mains!.map((e) => e.slug).toList().indexOf(event.slug);
      if (state.state == CategoryAPIState.loadingSubs) {
        state.cancelToken?.cancel();
      }
      await _checkSubExisting(event.slug, emit, index);
    });
  }

  Future<void> _checkSubExisting(
      String slug, Emitter<CategoryState> emit, int index) async {
    final theSubs = state.subs![slug];
    if (theSubs == null) {
      await _getAddSubs(slug, emit, index);
      return;
    }
    return emit(
      CategoryState(
        state: CategoryAPIState.success,
        activIndex: index,
        mains: List<CategoryModel>.from(state.mains!),
        subs: Map<String, List<CategoryModel>>.from(state.subs!),
      ),
    );
  }

  Future<void> _getAddSubs(
      String slug, Emitter<CategoryState> emit, int index) async {
    final newCancelToken = CancelToken();
    emit(
      CategoryState(
        state: CategoryAPIState.loadingSubs,
        activIndex: index,
        cancelToken: newCancelToken,
        mains: List<CategoryModel>.from(state.mains!),
        subs: Map<String, List<CategoryModel>>.from(state.subs!),
      ),
    );

    final data = await repo.getSubsBySlug(slug, newCancelToken);
    if (data == null) {
      if (newCancelToken.isCancelled) return;
      return emit(
        CategoryState(
          state: CategoryAPIState.errorSubs,
          activIndex: index,
          mains: List<CategoryModel>.from(state.mains!),
          subs: Map<String, List<CategoryModel>>.from(state.subs!),
        ),
      );
    }
    emit(
      CategoryState(
        state: CategoryAPIState.success,
        activIndex: index,
        cancelToken: newCancelToken,
        mains: List<CategoryModel>.from(state.mains!),
        subs: Map<String, List<CategoryModel>>.from(state.subs!)..addAll(data),
      ),
    );
  }
}
