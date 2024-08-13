import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/orders/UI/order_item.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
import 'package:tayaar/features/orders/logic/cubit/orders_cubit.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrdersCubit(getIt<OrdersRepoImpl>())..openSocket(context),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.prussianBlue,
              title:  Text('Orders',style: TextStyles.headings.copyWith(color: AppColors.ivory),),
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 20,),
                    Flexible(
                      flex: 7,
                      child: ListView.separated(
                        itemCount: OrdersCubit.get(context).orders.length,
                        itemBuilder: (context, index) => OrderDetailsWidget(
                          order: OrdersCubit.get(context).orders[index],
                        ),
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(height: 10),
                      ),
                    ),
                    // Button occupies the remaining space
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: defaultButton(function: (){}, context: context, text: "Close Shift")
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}