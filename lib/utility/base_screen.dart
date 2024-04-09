import 'package:flutter/material.dart';
import 'package:os_basecode/os_basecode.dart';
import 'package:praktitask/home/presentation/bloc/fetch_all_todos_bloc/fetch_all_todos_bloc.dart';

class BaseScreen extends StatefulWidget {
  final Widget child;
  final int selectedMenu;
  const BaseScreen({super.key, required this.child, required this.selectedMenu});

  @override
  State<BaseScreen> createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  ValueNotifier<String> usernameListener = ValueNotifier("Guest");
  @override
  void initState() {
    fetchUsername();
    super.initState();
  }

  fetchUsername() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    usernameListener.value = pref.getString("username") ?? "Guest";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: ValueListenableBuilder(
              valueListenable: usernameListener,
              builder: (context, value, child) => Text("Welcome $value,")),
          actions: [
            IconButton(
                onPressed: () async {
                  final DateTime? picked = await showDatePicker(
                      context: context,
                      currentDate: DateTime.now(),
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2024),
                      lastDate: DateTime(3000));
                  if (picked != null) {
                    if (!mounted) return;
                    context.read<FetchAllTodosBloc>().add(DoFetchAllTodos(date: picked));
                  }
                },
                icon: const Icon(Icons.date_range_outlined)),
          ],
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (value) {
            switch (value) {
              case 0:
                context.go("/home");
                break;
              case 1:
                context.go("/search");
                break;
            }
          },
          elevation: 1,
          selectedIndex: widget.selectedMenu,
          labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
          indicatorShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          destinations: const [
            NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home_filled),
                label: "Home"),
            NavigationDestination(
                icon: Icon(Icons.search_outlined),
                selectedIcon: Icon(Icons.search_rounded),
                label: "Search")
          ],
        ),
        body: widget.child);
  }
}
