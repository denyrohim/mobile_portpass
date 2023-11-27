import 'package:dio/dio.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/src/activity_management/data/datasources/activity_management_remote_data_source.dart';
import 'package:port_pass_app/src/activity_management/data/repositories/activity_management_repository_impl.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/add_activity.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/add_item.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/delete_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/delete_items.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/get_activities.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/update_activity.dart';
import 'package:port_pass_app/src/activity_management/domain/usecase/update_item.dart';
import 'package:port_pass_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:port_pass_app/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in_with_credential.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_out.dart';
import 'package:port_pass_app/src/auth/domain/usecases/update_user.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:port_pass_app/src/employee_management/data/datasources/employee_management_remote_data_source.dart';
import 'package:port_pass_app/src/employee_management/data/repositories/employee_management_repository_impl.dart';
import 'package:port_pass_app/src/employee_management/domain/repositories/employee_management_repository.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/add_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/cancel_check_box_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/delete_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/get_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/select_all_employees.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_check_box_employee.dart';
import 'package:port_pass_app/src/employee_management/domain/usecases/update_employee.dart';
import 'package:port_pass_app/src/employee_management/presentation/bloc/employee_management_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
