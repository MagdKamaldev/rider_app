// ignore_for_file: library_private_types_in_public_api

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tayaar/core/components/colors.dart';
import 'package:tayaar/core/components/constants.dart';
import 'package:tayaar/core/components/shared_components.dart';
import 'package:tayaar/core/service_locator.dart/service_locator.dart';
import 'package:tayaar/features/home/data/models/info_model/info_model.dart';
import 'package:tayaar/features/home/data/repos/zone_repos_impl.dart';
import 'package:tayaar/features/home/logic/cubit/zones_cubit.dart';
import 'package:tayaar/features/login/UI/login_screen.dart';
import 'package:tayaar/generated/l10n.dart';
import 'package:tayaar/main.dart'; // Import localization

class HomeScreen extends StatefulWidget {
  final int id;
  final Position position;
  final String hubName;
  final int todaysOrders;
  const HomeScreen({super.key, required this.id, required this.position, required this.hubName, required this.todaysOrders});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  InfoModel? selectedZone;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          S.of(context).selectZoneTitle, // Use localized string
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              navigateAndFinish(context, const LoginScreen());
              token = null;
              kTokenBox.delete(kTokenBoxString);
            },
            icon: const Icon(
              Icons.logout,
            ),
            color: AppColors.ivory,
          )
        ],
        centerTitle: true,
        backgroundColor: AppColors.prussianBlue,
      ),
      body: BlocProvider(
        create: (context) =>
            ZonesCubit(getIt<ZonesRepoImpl>())..getZones(context),
        child: BlocBuilder<ZonesCubit, ZonesState>(
          builder: (context, state) {
            if (state is ZonesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ZonesSuccess) {
              selectedZone = state.zones[0];
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).selectZoneLabel, // Use localized string
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 10),
                    DropdownSearch<InfoModel>(
                      items: state.zones,
                      dropdownBuilder: (context, selectedItem) {
                        return Text("    ${selectedItem!.name.toString()}     ");
                      },
                      itemAsString: (item) => item.name.toString(),
                      onChanged: (item) {
                        selectedZone = item;
                      },
                      selectedItem: selectedZone,
                    ),
                    SizedBox(
                      height: size.height * 0.2,
                    ),
                    defaultButton(
                        function: () {
                          context
                              .read<ZonesCubit>()
                              .openShift(context, selectedZone!.id!, widget.position,widget.hubName,widget.todaysOrders);
                        },
                        context: context,
                        text: S.of(context).openShiftButton // Use localized string
                    )
                  ],
                ),
              );
            } else {
              return Center(child: Text(S.of(context).errorFetchingZones)); // Use localized string
            }
          },
        ),
      ),
    );
  }
}