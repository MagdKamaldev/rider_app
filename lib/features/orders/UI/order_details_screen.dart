import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/orders/UI/build_details_row.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
import 'package:tayaar/features/orders/logic/cubit/orders_cubit.dart';

class OrderDetailsScreen extends StatelessWidget {
  const OrderDetailsScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit(getIt<OrdersRepoImpl>())..getOrder(),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Current Order Details',
                style: TextStyles.headings,
              ),
              backgroundColor: AppColors.prussianBlue,
            ),
            body: _buildOrderDetails(context,OrdersCubit.get(context)),
          );
        },
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context,OrdersCubit cubit) {
    if(cubit.currentOrder ==null){
      return const Center(child: CircularProgressIndicator());
    }else{
 return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 35.0, horizontal: 20),
      child: Column(
        children: [
          Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(
                      Icons.location_on, 'Address', cubit.currentOrder!.deliveryAddress),
                  const Divider(),
                  _buildDetailRow(Icons.person, 'Client', cubit.currentOrder!.clientName),
                  const Divider(),
                  _buildDetailRow(Icons.business, 'Branch', cubit.currentOrder!.branchName),
                  const Divider(),
                  _buildDetailRow(Icons.confirmation_number, 'Order ID',
                      cubit.currentOrder!.id?.toString()),
                  const Divider(),
                  _buildDetailRow(Icons.calendar_today, 'Date',
                      formatDate(cubit.currentOrder!.createdAt)),
                  const Divider(),
                  _buildDetailRow(
                      Icons.access_time, 'Time', formatTime(cubit.currentOrder!.createdAt)),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 120,
          ),
          defaultButton(function: () {
            context.read<OrdersCubit>().closeOrder(context, cubit.currentOrder!.id!);
          }, context: context, text: "Finish")
        ],
      ),
    );
    }
   
  }

  Widget _buildDetailRow(IconData icon, String label, String? value) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.prussianBlue,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.prussianBlue,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value ?? 'N/A',
                style: const TextStyle(
                  color: AppColors.prussianBlue,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
