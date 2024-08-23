import 'package:complaint_management_system/utils/widgets/custom_drawer.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home page'),
      ),
      drawer: CustomDrawer(),
      body: const Center(
        child: Text('Home page'),
      ),
    );
  }
}
