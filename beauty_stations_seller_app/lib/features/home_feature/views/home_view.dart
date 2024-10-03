import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_cubit.dart';
import 'package:beauty_solution_seller_app/features/home_feature/views/widgets/service_provider_type.dart';
import 'package:beauty_solution_seller_app/resource/color_manager.dart';
import 'package:beauty_solution_seller_app/utils/app_utils/extentions.dart';
import 'package:beauty_solution_seller_app/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: BlocProvider(
        create: (context) => HomeCubit(),
        child: Scaffold(
          appBar: const CustomAppBar(
            title: 'Beauty Solution V6',
            leadingIcon: SizedBox(),
            backgroundColor: ColorManager.neutral00,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [const ServiceProviderType().verticalPadding(20)],
            ).horizontalPadding(16),
          ),
        ),
      ),
    );
  }
}
