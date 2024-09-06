import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/components/text_styles.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/checkingInfo/checking_info_screen.dart';
import 'package:tayaar/features/orders/UI/order_item.dart';
import 'package:tayaar/features/orders/data/repos/orders_repo_impl.dart';
import 'package:tayaar/features/orders/logic/cubit/orders_cubit.dart';
import 'package:tayaar/generated/l10n.dart'; // Import localization

class OrdersScreen extends StatefulWidget {
  final String hubName;
  final int todaysOrders;
  const OrdersScreen(
      {super.key, 
      required this.hubName, 
      required this.todaysOrders});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  @override
  void initState() {
    super.initState();
  //  _startBackgroundLocationTracking();
  }

  // Future<void> _startBackgroundLocationTracking() async {
  //   LocationPermission permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied ||
  //       permission == LocationPermission.deniedForever) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission != LocationPermission.whileInUse &&
  //         permission != LocationPermission.always) {
  //       // Handle the situation where the user denied the location permission
  //       return;
  //     }
  //   }

  //   // Start listening to the location in the background
  //   Geolocator.getPositionStream(
  //     locationSettings: const LocationSettings(
  //       accuracy: LocationAccuracy.high,
  //       distanceFilter: 10, // distance in meters
  //     ),
  //   ).listen((Position position) {
  //     // print("Current position: ${position.latitude}, ${position.longitude}");
  //     // Here, you can make API calls to update the rider's location on the server.
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrdersCubit(getIt<OrdersRepoImpl>())..startListeningToOrders(context),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColors.prussianBlue,
              centerTitle: true,
              title: Text(
                S.of(context).ordersTitle, // Use localized string
                style: TextStyles.headings.copyWith(color: AppColors.ivory),
              ),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: OrderSummaryCard(
                      hubName: widget.hubName,
                      todaysOrders: widget.todaysOrders,
                      queueNumber: OrdersCubit.get(context).queueNumber,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.prussianBlue,
                  ),
                  Flexible(
                    flex: 7,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: OrdersCubit.get(context).orders.length,
                      itemBuilder: (context, index) {
                        final order = OrdersCubit.get(context).orders[index];
                        return OrderDetailsWidget(
                          acceptPressed: () => context
                              .read<OrdersCubit>()
                              .claimOrder(context, order.id!, widget.hubName,
                                  widget.todaysOrders),
                          rejectPressed: () {
                            //TODO: Implement reject functionality
                          },
                          order: order,
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: AppColors.prussianBlue,
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: defaultButton(
                        function: () {
                          context.read<OrdersCubit>().closeShift(context);
                          navigateAndFinish(context, const CheckingInfo());
                        },
                        context: context,
                        text: S
                            .of(context)
                            .closeShiftButton, // Use localized string
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class OrderSummaryCard extends StatelessWidget {
  final String hubName;
  final int todaysOrders;
  final int? queueNumber;

  const OrderSummaryCard({
    super.key,
    required this.hubName,
    required this.todaysOrders,
    required this.queueNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Colors.white,
      shadowColor: Colors.black45,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: AppColors.prussianBlue),
                const SizedBox(width: 12),
                Text(
                  "${S.of(context).hubName}: $hubName", // Localized string for hub name
                  style: TextStyles.headings
                      .copyWith(color: AppColors.prussianBlue, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                const Icon(Icons.delivery_dining,
                    color: AppColors.prussianBlue),
                const SizedBox(width: 12),
                Text(
                  "${S.of(context).todayOrders}: $todaysOrders", // Localized string for today's orders
                  style: TextStyles.headings
                      .copyWith(color: AppColors.prussianBlue, fontSize: 16),
                ),
              ],
            ),
            if (queueNumber != null) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  const Icon(Icons.numbers, color: AppColors.prussianBlue),
                  const SizedBox(width: 12),
                  Text(
                    "${S.of(context).queueNumberText}: $queueNumber", // Localized string for queue number
                    style: TextStyles.headings
                        .copyWith(color: AppColors.prussianBlue, fontSize: 16),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
