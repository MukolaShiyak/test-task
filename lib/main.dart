import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_taskk/api/cats_fact_api/cats_fact_api.dart';
import 'package:test_taskk/cubit/cat_fact_cubit.dart';
import 'package:test_taskk/cubit/loader_cubit.dart';
import 'package:test_taskk/models/cat_model/cats_model.dart';
import 'package:test_taskk/pages/facts_history_screen.dart';
import 'package:test_taskk/pages/main_screen.dart';
import 'package:test_taskk/repository/cat_fact_repository.dart';
import 'package:test_taskk/repository/hive_repository.dart';

const String dataBoxName = "data";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final document = await getApplicationDocumentsDirectory();
  Hive.init(document.path);
  Hive.registerAdapter(CatModelAdapter());
  var box = await Hive.openBox<List<dynamic>?>(dataBoxName);
  runApp(MyApp(hiveDB: box));
}

class MyApp extends StatelessWidget {
  final Box<List<dynamic>?> hiveDB;
  const MyApp({
    super.key,
    required this.hiveDB,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => HiveRepository(hiveDB),
        ),
        RepositoryProvider(
          create: (context) => RestClient(
              Dio(BaseOptions(contentType: "application/json")),
              baseUrl: 'https://catfact.ninja'),
        ),
        RepositoryProvider(
          create: (context) => CatRepository(context.read<RestClient>()),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<LoaderCubit>(
            create: (context) => LoaderCubit(),
          ),
          BlocProvider<CatFactCubit>(
            create: (context) => CatFactCubit(
              catRepository: context.read<CatRepository>(),
              hiveRepository: context.read<HiveRepository>(),
              loaderCubit: context.read<LoaderCubit>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(360, 812),
          minTextAdapt: true,
          builder: (context, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Test-task Cat App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            initialRoute: MainScreen.routeName,
            routes: {
              MainScreen.routeName: (context) => const MainScreen(
                    title: 'Test-task Cat App',
                  ),
              FactsHistoryScreen.routeName: (context) =>
                  const FactsHistoryScreen(),
            },
          ),
        ),
      ),
    );
  }
}
