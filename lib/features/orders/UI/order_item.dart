import 'package:flutter/material.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/features/orders/UI/build_details_row.dart';
import 'package:tayaar/features/orders/UI/order_details_screen.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';

class OrderDetailsWidget extends StatefulWidget {
  final VoidCallback? acceptPressed;
  final VoidCallback? rejectPressed;
  final OrderModel order;
  const OrderDetailsWidget({
    super.key,
    required this.order,
    required this.acceptPressed,
    required this.rejectPressed,
  });

  @override
  _OrderDetailsWidgetState createState() => _OrderDetailsWidgetState();
}

class _OrderDetailsWidgetState extends State<OrderDetailsWidget> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          setState(() {
            isExpanded = !isExpanded;
          });
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: AnimatedContainer(
            decoration: BoxDecoration (
              color: AppColors.prussianBlue,
            borderRadius: BorderRadius.circular(13.0)
          ),
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            height: isExpanded ? 320 : 132,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isExpanded) ...[
                    // Expanded layout
                    buildDetailRow(
                      'Address:',
                      widget.order.deliveryAddress,
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Client:',
                      widget.order.clientName,
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Branch:',
                      widget.order.branchName,
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Order ID:',
                      widget.order.id?.toString(),
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Date:',
                      formatDate(widget.order.createdAt),
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Zone ID:',
                      widget.order.zoneId?.toString(),
                      isExpanded,
                    ),
                    buildDetailRow(
                      'Time:',
                      formatTime(widget.order.createdAt),
                      isExpanded,
                    ),
                  ] else ...[
                    // Compact layout
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.order.deliveryAddress ?? 'Unknown Address',
                            style: const TextStyle(
                              color: AppColors.ivory,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            widget.order.clientName ?? 'Unknown Client',
                            style: const TextStyle(
                              color: AppColors.ivory,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: Text(
                            widget.order.branchName ?? 'Unknown Branch',
                            style: const TextStyle(
                              color: AppColors.ivory,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailRow(
                                'Order ID:',
                                widget.order.id?.toString(),
                                isExpanded,
                              ),
                              buildDetailRow(
                                'Date:',
                                formatDate(widget.order.createdAt),
                                isExpanded,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 35),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              buildDetailRow(
                                'Zone ID:',
                                widget.order.zoneId?.toString(),
                                isExpanded,
                              ),
                              buildDetailRow(
                                'Time:',
                                formatTime(widget.order.createdAt),
                                isExpanded,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 20),
                  if (isExpanded) ...[
                    Container(
                      width: double.infinity,
                      height: 1,
                      color: AppColors.ivory,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: defaultButton(
                              function: () {
                                widget.acceptPressed!();
                              },
                              context: context,
                              text: "Accept",
                              color: AppColors.ivory,
                              textColor: AppColors.prussianBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: 50,
                            child: defaultButton(
                              function: () {
                                widget.rejectPressed!();
                              },
                              context: context,
                              text: "Reject",
                              color: Colors.red,
                              textColor: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


}