import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:test_taskk/cubit/cat_fact_cubit.dart';
import 'package:test_taskk/models/cat_model/cats_model.dart';
import 'package:test_taskk/pages/facts_history_screen.dart';
import 'package:test_taskk/repository/hive_repository.dart';
import 'package:test_taskk/shared_widgets/app_bar.dart';
import 'package:test_taskk/shared_widgets/page_layout.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  const MainScreen({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget? _image;
  String? _text;
  String? _factCreated;

  @override
  void initState() {
    List<CatModel>? list = [
      ...?context.read<HiveRepository>().getFactsFromHive()
    ];

    context.read<CatFactCubit>().loadStateFromHive(list);

    _updateImgWidget(context);

    super.initState();
  }

  _updateImgWidget(BuildContext ctx) async {
    _text = null;

    setState(() {
      _image = const SizedBox();
    });

    await ctx.read<CatFactCubit>().getCatFact();

    CatModel? catFact = ctx.read<CatFactCubit>().state.catFact;
    Uint8List? imageBytes = ctx.read<CatFactCubit>().state.image;

    if (catFact != null) {
      _text = catFact.factText;
      _factCreated = catFact.createdAt;
    }

    setState(() {
      _image = Image.memory(
        imageBytes!,
        fit: BoxFit.contain,
        height: 350.h,
        width: 300.w,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageLayout(
      appBar: AppBarWidget(
        title: widget.title,
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.of(context).pushNamed(FactsHistoryScreen.routeName),
            child: const Text(
              'Fact history',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          _updateImgWidget(context);
          setState(() {});
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'Another fact!',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(width: 5.w),
            const Icon(
              Icons.arrow_forward,
              color: Colors.redAccent,
            ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_image != null) _image!,
            if (_text != null) ...[
              Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _text!,
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Text(
                      'Created: $_factCreated',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
