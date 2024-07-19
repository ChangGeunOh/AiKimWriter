import 'package:flutter/material.dart';

class UnderScreen extends StatelessWidget {
  static String get routeName => 'under';

  const UnderScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Coming Soon'),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 64),
            child: Image.asset('assets/images/img_underconstruction.png'),
          ),
        ),
      ),
    );
  }
}
