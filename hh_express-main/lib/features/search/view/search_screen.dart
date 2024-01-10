import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hh_express/features/search/cubit/search_cubit.dart';
import 'package:hh_express/features/search/view/search_app_bar.dart';
import 'package:hh_express/features/search/view/search_body.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: SearchAppbar(),
        body: SearchBody(),
      ),
    );
  }
}
