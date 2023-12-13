import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/views/loading_view.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_item.dart';
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
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ActivityManagementBloc>().add(const GetActivitiesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ActivityManagementBloc, ActivityManagementState>(
      listener: (context, state) {
        if (state is ActivityManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataLoaded) {
          context.read<ActivityProvider>().initActivities(state.activities);
        } else if (state is DataAdded) {
          debugPrint('Data Added');
        } else if (state is DataUpdated) {
          debugPrint('Data Updated');
        } else if (state is UpdateChecked) {
          debugPrint('Update Checked');
          context.read<ActivityProvider>().initActivities(state.activities);
        } else if (state is UnshowChecked) {
          debugPrint('Cancel CheckBox');
          context.read<ActivityProvider>().initActivities(state.activities);
        } else if (state is SelectedAll) {
          debugPrint('Select All');
          context.read<ActivityProvider>().initActivities(state.activities);
        }
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
                        padding: const EdgeInsets.only(
                          top: 10,
                        ),
                        height: MediaQuery.of(context).size.height * 0.69,
                        child: Stack(
                          children: [
                            Stack(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // context
                                        //     .read<ActivityManagementBloc>()
                                        //     .add(const GetActivitiesEvent());
                                        debugPrint('Aktivitas');
                                      },
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Aktivitas',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colours.primaryColour,
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: Colours.primaryColour,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // context
                                        //     .read<ActivityManagementBloc>()
                                        //     .add(const GetDraftsEvent());
                                        debugPrint('Draft');
                                      },
                                      child: Column(
                                        children: [
                                          const Text(
                                            'Draft',
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w700,
                                              color: Colours.primaryColour,
                                            ),
                                          ),
                                          Container(
                                            width: 120,
                                            height: 8,
                                            decoration: BoxDecoration(
                                              color: Colours.primaryColour,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 42),
                                  height: 1,
                                  width: double.infinity,
                                  color: Colours.primaryColour,
                                ),
                              ],
                            ),
                            (state is ActivityManagementLoading)
                                ? const LoadingView(
                                    color: Colours.primaryColour,
                                  )
                                : Container(
                                    margin: const EdgeInsets.only(top: 43),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    height: MediaQuery.of(context).size.height *
                                        0.60,
                                    child: Stack(
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
                                        ListView.builder(
                                          itemCount: activities.length,
                                          itemBuilder: (context, index) {
                                            if (activities[index]
                                                .name
                                                .toLowerCase()
                                                .contains(
                                                    _searchController.text)) {
                                              return ActivityItem(
                                                context,
                                                index: index,
                                                activities: activities,
                                                isShowCheckBox: activityProvider
                                                    .isShowChecked,
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    )
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
