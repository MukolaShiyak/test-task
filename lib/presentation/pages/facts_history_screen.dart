import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_taskk/logic/cat_fact_cubit/cat_fact_cubit.dart';
import 'package:test_taskk/presentation/shared_widgets/app_bar.dart';
import 'package:test_taskk/presentation/shared_widgets/page_layout.dart';

class FactsHistoryScreen extends StatelessWidget {
  static const routeName = '/history';
  const FactsHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: const AppBarWidget(title: 'Facts History'),
      child: ListView.builder(
        itemBuilder: (context, index) => Padding(
          padding: EdgeInsets.only(bottom: 10.h, left: 20.w, right: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (index == 0) SizedBox(height: 20.h),
              Text(
                '${context.read<CatFactCubit>().state.listOfCatFacts[index].factText}',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
              SizedBox(height: 10.h),
              Text(
                'Fact created - ${context.read<CatFactCubit>().state.listOfCatFacts[index].createdAt}',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (index + 1 !=
                  context.read<CatFactCubit>().state.listOfCatFacts.length) ...[
                SizedBox(height: 10.h),
                const Divider(
                  color: Colors.black,
                  thickness: 2,
                ),
              ],
            ],
          ),
        ),
        itemCount: context.read<CatFactCubit>().state.listOfCatFacts.length,
      ),
    );
  }
}
