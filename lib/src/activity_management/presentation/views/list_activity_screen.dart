import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';
import 'package:provider/provider.dart';
import '../../../employee_management/presentation/widgets/costum_search_bar.dart';

class ListActivityScreen extends StatefulWidget {
  const ListActivityScreen({super.key});

  static const routeName = '/list-employee';

  @override
  State<ListActivityScreen> createState() => _ListActivityScreenState();
}

class _ListActivityScreenState extends State<ListActivityScreen> {
  // final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // context.read<ActivityManagementBloc>().add(const GetActivitiesEvent());
    // context
    //     .read<ActivityManagementBloc>()
    //     .add(const GetActivityDivisionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        // if (state is ActivityManagementError) {
        //   CoreUtils.showSnackBar(context, state.message);
        // } else if (state is DataLoaded) {
        //   context.read<ActivitysProvider>().initActivitys(state.employees);
        // } else if (state is DataAdded) {
        //   debugPrint('Data Added');
        // } else if (state is DataUpdated) {
        //   debugPrint('Data Updated');
        // } else if (state is UpdateChecked) {
        //   debugPrint('Update Checked');
        //   context.read<ActivitysProvider>().initActivitys(state.employees);
        // } else if (state is UnshowChecked) {
        //   debugPrint('Cancel CheckBox');
        //   context.read<ActivitysProvider>().initActivitys(state.employees);
        // } else if (state is SelectedAll) {
        //   debugPrint('Select All');
        //   context.read<ActivitysProvider>().initActivitys(state.employees);
        // }
        // if (state is ActivityDivisionLoaded) {
        //   context
        //       .read<ActivityDivisionProvider>()
        //       .initActivityDivision(state.employeeDivisions);
        // }
      },
      builder: (context, state) {
        return Consumer<ActivityProvider>(
          builder: (_, activityProvider, __) {
            final activities = activityProvider.filteredActivity;
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colours.secondaryColour,
              appBar: ActivityManagementAppBar(
                count: activities.length,
                activityProvider: activityProvider,
              ),
              body: Container(
                color: Colours.primaryColour,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 12),
                            child: const CustomSearchBar(),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 18),
                    Expanded(
                        child: Container(
                      decoration: const BoxDecoration(
                        color: Colours.secondaryColour,
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20),
                        ),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      height: MediaQuery.of(context).size.height * 0.7,
                      child:
                          // (state is ActivityManagementLoading)
                          //     ? const LoadingView(
                          //         color: Colours.primaryColour,
                          //       )
                          //     :
                          Stack(
                        children: [
                          if (activities.isEmpty)
                            const Center(
                              child: Text(
                                'Tidak ada data',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: Colours.primaryColour),
                              ),
                            ),
                          // ListView.builder(
                          //   itemCount: employees.length,
                          //   itemBuilder: (context, index) {
                          //     if (employees[index]
                          //         .name
                          //         .toLowerCase()
                          //         .contains(_searchController.text)) {
                          //       return ActivityItem(
                          //         context,

                          //         index: index,
                          //         employees: employees,
                          //       );
                          //     } else {
                          //       return const SizedBox.shrink();
                          //     }
                          //   },
                          // ),
                        ],
                      ),
                    ))
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}