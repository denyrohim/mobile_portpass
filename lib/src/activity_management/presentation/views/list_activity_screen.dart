import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/activity_provider.dart';
import 'package:port_pass_app/core/common/views/loading_view.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/activity_management/presentation/bloc/activity_management_bloc.dart';
import 'package:port_pass_app/src/activity_management/presentation/views/activity_detail_activity_screen.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_item.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_management_app_bar.dart';
import 'package:port_pass_app/src/activity_management/presentation/widgets/activity_search_bar.dart';
import 'package:provider/provider.dart';

class ListActivityScreen extends StatefulWidget {
  const ListActivityScreen({super.key});

  static const routeName = '/list-employee';

  @override
  State<ListActivityScreen> createState() => _ListActivityScreenState();
}

class _ListActivityScreenState extends State<ListActivityScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _statusController = TextEditingController();
  final TextEditingController _countController = TextEditingController();
  bool deniedActivity = false;
  void changeListActivity(bool value) {
    setState(() {
      deniedActivity = value;
    });
  }

  void get initController {
    deniedActivity = false;
    _statusController.text = 'Aktivitas';
    _countController.text = '0';
    _countController.addListener(() {
      setState(() {});
    });
    _statusController.addListener(() {
      setState(() {});
    });
  }

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
          context
              .read<ActivityProvider>()
              .initDefaultActivities(state.activities);
          initController;
          context.read<ActivityManagementBloc>().add(
                ChangeStatusActivitiesEvent(
                  activities:
                      context.read<ActivityProvider>().defaultActivities,
                  status: _statusController.text,
                ),
              );
          debugPrint('Data Loaded');
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
        } else if (state is StatusChanged) {
          debugPrint('Status Changed');
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
                statusController: _statusController,
                activitiesDefault:
                    context.read<ActivityProvider>().defaultActivities,
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
                            child: const ActivitySearchBar(),
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
                                Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            changeListActivity(false);
                                            activityProvider
                                                .setShowChecked(false);
                                            context
                                                .read<ActivityManagementBloc>()
                                                .add(
                                                  ChangeStatusActivitiesEvent(
                                                    activities: context
                                                        .read<
                                                            ActivityProvider>()
                                                        .defaultActivities,
                                                    status: "Aktivitas",
                                                  ),
                                                );
                                            _statusController.text =
                                                'Aktivitas';
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
                                                  color: (!deniedActivity)
                                                      ? Colours.primaryColour
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            changeListActivity(true);
                                            context
                                                .read<ActivityManagementBloc>()
                                                .add(
                                                  ChangeStatusActivitiesEvent(
                                                    activities: context
                                                        .read<
                                                            ActivityProvider>()
                                                        .defaultActivities,
                                                    status: "Draft",
                                                  ),
                                                );
                                            _statusController.text = 'Draft';
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
                                                  color: (deniedActivity)
                                                      ? Colours.primaryColour
                                                      : Colors.transparent,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
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
                                      horizontal: 20,
                                    ),
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
                                        RefreshIndicator(
                                          onRefresh: () async {
                                            context
                                                .read<ActivityManagementBloc>()
                                                .add(
                                                    const GetActivitiesEvent());
                                          },
                                          backgroundColor:
                                              Colours.secondaryColour,
                                          color: Colours.primaryColour,
                                          child: ListView.builder(
                                            itemCount: activities.length,
                                            itemBuilder: (context, index) {
                                              if (activities[index]
                                                  .name
                                                  .toLowerCase()
                                                  .contains(
                                                      _searchController.text)) {
                                                return GestureDetector(
                                                  onTap: () {
                                                    final navigator =
                                                        Navigator.of(context);
                                                    navigator.pushNamed(
                                                      ActivityDetailActivityScreen
                                                          .routeName,
                                                      arguments:
                                                          activities[index],
                                                    );
                                                  },
                                                  child: ActivityItem(
                                                    context,
                                                    index: index,
                                                    activities: activities,
                                                    status:
                                                        _statusController.text,
                                                    isShowCheckBox:
                                                        activityProvider
                                                            .isShowChecked,
                                                  ),
                                                );
                                              } else {
                                                return const SizedBox.shrink();
                                              }
                                            },
                                          ),
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
