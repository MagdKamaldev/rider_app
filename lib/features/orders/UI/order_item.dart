import 'package:flutter/material.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/features/orders/UI/build_details_row.dart';
import 'package:tayaar/features/orders/data/models/order_model.dart';
import 'package:tayaar/generated/l10n.dart'; // Import localization

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
  OrderDetailsWidgetState createState() => OrderDetailsWidgetState();
}

class OrderDetailsWidgetState extends State<OrderDetailsWidget> {
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
            decoration: BoxDecoration(
                color: AppColors.prussianBlue,
                borderRadius: BorderRadius.circular(13.0)),
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            height: isExpanded ? 350 : 132,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment:  CrossAxisAlignment.start,
                children: [
                  if (isExpanded) ...[
                    // Expanded layout
                    buildDetailRow(
                      S.of(context).addressLabel, // Use localized string
                      widget.order.deliveryAddress,
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).clientLabel, // Use localized string
                      widget.order.clientName,
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).branchLabel, // Use localized string
                      widget.order.branchName,
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).orderIdLabel, // Use localized string
                      widget.order.id?.toString(),
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).dateLabel, // Use localized string
                      formatDate(widget.order.createdAt),
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).zoneIdLabel, // Use localized string
                      widget.order.zoneId?.toString(),
                      isExpanded,
                    ),
                    buildDetailRow(
                      S.of(context).timeLabel, // Use localized string
                      formatTime(widget.order.createdAt),
                      isExpanded,
                    ),
                  ] else ...[
                    // Compact layout
                    Row(
                      children: [                      
                        Expanded(
                          child: Text(
                            widget.order.deliveryAddress ?? S.of(context).unknownAddress, // Use localized string
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
                            widget.order.clientName ?? S.of(context).unknownClient, // Use localized string
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
                            widget.order.branchName ?? S.of(context).unknownBranch, // Use localized string
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
                                S.of(context).orderIdLabel, // Use localized string
                                widget.order.id?.toString(),
                                isExpanded,
                              ),
                              buildDetailRow(
                                S.of(context).dateLabel, // Use localized string
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
                                S.of(context).zoneIdLabel, // Use localized string
                                widget.order.zoneId?.toString(),
                                isExpanded,
                              ),
                              buildDetailRow(
                                S.of(context).timeLabel, // Use localized string
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
                              function: (){widget.acceptPressed!();},
                              context: context,
                              text: S.of(context).acceptButton, // Use localized string
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
                              function: (){
                                widget.rejectPressed!();
                                },
                              context: context,
                              text: S.of(context).rejectButton, // Use localized string
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