import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_cubit.dart';
import 'package:beauty_solution_seller_app/features/home_feature/cubites/home_cubit/home_state.dart';
import 'package:beauty_solution_seller_app/features/home_feature/views/widgets/add_service_provider_data.dart';
import 'package:beauty_solution_seller_app/widgets/custom_radio_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ServiceProviderType extends StatelessWidget {
  const ServiceProviderType({super.key});

  @override
  Widget build(BuildContext context) {
    HomeCubit cubit = context.read<HomeCubit>();

    return BlocSelector<HomeCubit, HomeState, bool>(
      selector: (state) => state.isSalon,
      builder: (_, isSalon) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //************  Radios Buttons *********** */
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  CustomRadioButton(
                    onChanged: () {
                      if (isSalon) return;
                      cubit.toggleSalon();
                    },
                    title: "صالون جديد",
                    value: isSalon,
                  ),
                  40.horizontalSpace,
                  CustomRadioButton(
                    onChanged: () {
                      if (!isSalon) return;
                      cubit.toggleSalon();
                    },
                    title: "خبيرة التجميل الجديدة",
                    value: !isSalon,
                  ),
                ],
              ),
            ),
            //************  Form *********** */
            AddServiceProviderData(isSalon: isSalon),
          ],
        );
      },
    );
  }
}
