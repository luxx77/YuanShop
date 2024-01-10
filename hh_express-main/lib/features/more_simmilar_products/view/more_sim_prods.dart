import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hh_express/features/more_simmilar_products/cubit/more_sim_prods_cubit.dart';
import 'package:hh_express/features/more_simmilar_products/view/more_sim_prods_body.dart';
import 'package:hh_express/helpers/extentions.dart';

class MoreSimProdsScreen extends StatelessWidget {
  const MoreSimProdsScreen(this.slug);
  final String slug;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocProvider(
      create: (context) => MoreSimProdsCubit(slug)..init(),
      child: Scaffold(
        
        appBar: AppBar(
          title: Text(context.l10n.moreSimProds),
          leading: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Container(
              height: double.infinity,
              width: 24.sp,
              alignment: Alignment.center,
              child: FittedBox(
                child: Icon(
                  Icons.arrow_back_rounded,
                  color: theme.iconTheme.color,
                ),
              ),
            ),
          ),
        ),
        body: MoreSimProdsBody(),
      ),
    );
  }
}
