import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/presentation/bloc/delete_todo_bloc/delete_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/save_todo_bloc/save_todo_bloc.dart';
import 'package:praktitask/home/presentation/bloc/search_todos_bloc/search_todos_bloc.dart';
import 'package:praktitask/home/presentation/bloc/update_todo_bloc/update_todo_bloc.dart';
import 'package:praktitask/utility/database.dart';
import 'package:praktitask/utility/notification_handler.dart';
import 'package:praktitask/utility/routes.dart';
import 'utility/injector.dart' as injector;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Inisialisasi database
  await DatabaseHelper.instance.database;
  injector.init();
  await NotificationHandler().init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => injector.locator<DeleteTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.locator<FetchAllTodosBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.locator<SaveTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.locator<UpdateTodoBloc>(),
        ),
        BlocProvider(
          create: (context) => injector.locator<SearchTodosBloc>(),
        )
      ],
      child: ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        child: MaterialApp.router(
          builder: FToastBuilder(),
          routeInformationParser: goRouter.routeInformationParser,
          routeInformationProvider: goRouter.routeInformationProvider,
          routerDelegate: goRouter.routerDelegate,
          title: 'PraktiTasks',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            scaffoldBackgroundColor: "#FCFCFC".toColor(),
            textTheme: GoogleFonts.plusJakartaSansTextTheme(),
            colorScheme:
                ColorScheme.fromSeed(seedColor: "#3C72EB".toColor(), primary: "#3C72EB".toColor()),
            useMaterial3: true,
          ),
        ),
      ),
    );
  }
}
