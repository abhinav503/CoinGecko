import 'package:coingecko/feature/home/presentation/bloc/home_bloc.dart';
import 'package:coingecko/feature/home/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coingecko/core/di/injection_container.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: const Key("HomeScaffoldGestureDetector"),
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: BlocProvider(
            create: (context) => HomeBloc(),
            child: const HomeScreen(),
          ),
        ),
      ),
    );
  }
}
