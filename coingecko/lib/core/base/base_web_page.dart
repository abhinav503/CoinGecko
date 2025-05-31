import 'package:flutter/material.dart';

abstract class BaseWebPage extends StatefulWidget {
  const BaseWebPage({super.key});

  @override
  State<BaseWebPage> createState();
}

abstract class BaseWebPageState<T extends BaseWebPage> extends State<T> {
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
      appBar: appBar(),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: body(context)),
    );
  }

  Widget body(BuildContext context);

  PreferredSizeWidget? appBar();
}
