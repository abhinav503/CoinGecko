import 'package:flutter/material.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({super.key});

  @override
  State<BasePage> createState();
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  dynamic arguments;
  bool isInitialized = false;

  @override
  void didChangeDependencies() {
    if (!isInitialized) {
      arguments = ModalRoute.of(context)!.settings.arguments;
      isInitialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: body(context)),
    );
  }

  Widget body(BuildContext context);
}
