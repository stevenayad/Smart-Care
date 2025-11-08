import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smartcare/features/home/presentation/cubits/category/catergory_cubit.dart';
import 'package:smartcare/features/home/presentation/views/widget/home_body.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: const Padding(padding: EdgeInsets.all(4.0), child: HomeBody()),
        ),
      ),
    );
  }
}
