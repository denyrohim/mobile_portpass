import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:port_pass_app/core/common/app/providers/employee_division_provider.dart';
import 'package:port_pass_app/core/common/app/providers/employees_provider.dart';
import 'package:port_pass_app/core/common/views/loading_view.dart';
import 'package:port_pass_app/core/res/colours.dart';
import 'package:port_pass_app/core/utils/core_utils.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_item.dart';
import 'package:port_pass_app/src/employee_management/presentation/widgets/employee_management_app_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/costum_search_bar.dart';

class ListEmployeeScreen extends StatefulWidget {
  const ListEmployeeScreen({super.key});

  static const routeName = '/list-employee';

  @override
  State<ListEmployeeScreen> createState() => _ListEmployeeScreenState();
}

class _ListEmployeeScreenState extends State<ListEmployeeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeManagementBloc>().add(const GetEmployeesEvent());
    context
        .read<EmployeeManagementBloc>()
        .add(const GetEmployeeDivisionEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EmployeeManagementBloc, EmployeeManagementState>(
      listener: (context, state) {
        if (state is EmployeeManagementError) {
          CoreUtils.showSnackBar(context, state.message);
        } else if (state is DataLoaded) {
          debugPrint('Data Loaded');
          context.read<EmployeesProvider>().initEmployees(state.employees);
        } else if (state is DataAdded) {
          debugPrint('Data Added');
        } else if (state is DataUpdated) {
          debugPrint('Data Updated');
        } else if (state is UpdateChecked) {
          debugPrint('Update Checked');
          context.read<EmployeesProvider>().initEmployees(state.employees);
        } else if (state is UnshowChecked) {
          debugPrint('Cancel CheckBox');
          context.read<EmployeesProvider>().initEmployees(state.employees);
        } else if (state is SelectedAll) {
          debugPrint('Select All');
          context.read<EmployeesProvider>().initEmployees(state.employees);
        }
        if (state is EmployeeDivisionLoaded) {
          context
              .read<EmployeeDivisionProvider>()
              .initEmployeeDivision(state.employeeDivisions);
        }
      },
      builder: (context, state) {
        return Consumer<EmployeesProvider>(
          builder: (_, employeesProvider, __) {
            final employees = employeesProvider.filteredEmployees;
            return Scaffold(
              resizeToAvoidBottomInset: true,
              backgroundColor: Colours.secondaryColour,
              appBar: EmployeeManagementAppBar(
                  count: employees.length,
                  employeesProvider: employeesProvider),
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
                      child: (state is EmployeeManagementLoading)
                          ? const LoadingView(
                              color: Colours.primaryColour,
                            )
                          : Stack(
                              children: [
                                if (employees.isEmpty)
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
                                  itemCount: employees.length,
                                  itemBuilder: (context, index) {
                                    if (employees[index]
                                        .name
                                        .toLowerCase()
                                        .contains(_searchController.text)) {
                                      return EmployeeItem(
                                        context,
                                        isShowCheckBox:
                                            employeesProvider.isShowChecked,
                                        index: index,
                                        employees: employees,
                                      );
                                    } else {
                                      return const SizedBox.shrink();
                                    }
                                  },
                                ),
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
