import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hh_express/features/categories/view/body.dart';
import 'package:hh_express/features/home/view/components/product_builder.dart';
import 'package:hh_express/features/product_details/view/product_details_body.dart';
import 'package:hh_express/features/search/cubit/search_cubit.dart';
import 'package:hh_express/helpers/extentions.dart';
import 'package:hh_express/settings/enums.dart';

class SearchBody extends StatefulWidget {
  const SearchBody({super.key});

  @override
  State<SearchBody> createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              (scrollController.position.maxScrollExtent - 30.h) &&
          scrollController.position.isScrollingNotifier.value) {
        final state = cubit.state;
        if (state.apiState != SearchAPIState.success ||
            state.pagination!.currentPage == state.pagination!.lastPage) {
          return;
        }
        cubit.loadMore();
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  late final cubit = context.read<SearchCubit>();
  final scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: cubit,
      builder: (context, state) {
        final apiState = state.apiState;
        if (apiState == SearchAPIState.init) return SizedBox();
        if (apiState == SearchAPIState.error)
          return CategoryErrorBody(
            onTap: () {
              cubit.search(immediately: true);
            },
          );
        if (apiState == SearchAPIState.success && state.models!.isEmpty) {
          return Center(
              child: Text(
          
            context.l10n.nothingFound,
          ));
        }
        return RefreshIndicator(
          onRefresh: () async {
            cubit.search(immediately: true);
          },
          child: ScrollConfiguration(
            behavior: MyBehavior(),
            child: CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              controller: scrollController,
              physics: AlwaysScrollableScrollPhysics(),
              slivers: [
                HomeProdBuilder(
                  prods: state.models,
                ),
                if (apiState == SearchAPIState.loadingMore)
                  CenterLoading().toSliverBox,
                if (apiState == SearchAPIState.errorMore)
                  CategoryErrorBody(
                    onTap: () => cubit.loadMore(),
                  ).toSliverBox
              ],
            ),
          ),
        );
        
      },
    );
  }
}
