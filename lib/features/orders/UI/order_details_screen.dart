import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/orders/UI/build_details_row.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
import 'package:tayaar/features/orders/logic/cubit/orders_cubit.dart';
import 'package:tayaar/generated/l10n.dart'; // Import localization

class OrderDetailsScreen extends StatelessWidget {
  final String hubName;
  final int todaysOrders;
  const OrderDetailsScreen({
    super.key, required this.hubName, required this.todaysOrders,
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
                S.of(context).currentOrderDetailsTitle, // Use localized string
                style: TextStyles.headings,
              ),
              backgroundColor: AppColors.prussianBlue,
            ),
            body: _buildOrderDetails(context, OrdersCubit.get(context)),
          );
        },
      ),
    );
  }

  Widget _buildOrderDetails(BuildContext context, OrdersCubit cubit) {
    if (cubit.currentOrder == null) {
      return const Center(child: CircularProgressIndicator());
    } else {
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
                    _buildDetailRow(Icons.location_on, S.of(context).addressLabel, // Use localized string
                        cubit.currentOrder!.deliveryAddress,context),
                    const Divider(),
                    _buildDetailRow(Icons.person, S.of(context).clientLabel, // Use localized string
                        cubit.currentOrder!.clientName,context),
                    const Divider(),
                    _buildDetailRow(Icons.business, S.of(context).branchLabel, // Use localized string
                        cubit.currentOrder!.branchName,context),
                    const Divider(),
                    _buildDetailRow(Icons.confirmation_number, S.of(context).orderIdLabel, // Use localized string
                        cubit.currentOrder!.id?.toString(),context),
                    const Divider(),
                    _buildDetailRow(Icons.calendar_today, S.of(context).dateLabel, // Use localized string
                        formatDate(cubit.currentOrder!.createdAt),context),
                    const Divider(),
                    _buildDetailRow(Icons.access_time, S.of(context).timeLabel, // Use localized string
                        formatTime(cubit.currentOrder!.createdAt),context),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 120,
            ),
            defaultButton(
                function: () {
                  context
                      .read<OrdersCubit>()
                      .closeOrder(context, cubit.currentOrder!.id!, hubName, todaysOrders);
                },
                context: context,
                text: S.of(context).finishButton // Use localized string
            )
          ],
        ),
      );
    }
  }

  Widget _buildDetailRow(IconData icon, String label, String? value,BuildContext context) {
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
                value ?? S.of(context).nA, // Use localized string
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