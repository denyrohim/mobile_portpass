import 'package:dio/dio.dart';
import 'package:port_pass_app/core/services/api.dart';
import 'package:port_pass_app/src/auth/data/datasources/auth_remote_data_source.dart';
import 'package:port_pass_app/src/auth/data/repositories/auth_repository_impl.dart';
import 'package:port_pass_app/src/auth/domain/repositories/auth_repository.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in.dart';
import 'package:port_pass_app/src/auth/domain/usecases/sign_in_with_credential.dart';
import 'package:port_pass_app/src/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import '../../src/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import '../../src/on_boarding/data/repositories/on_boarding_repository_impl.dart';
import '../../src/on_boarding/domain/repositories/on_boarding_repository.dart';
import '../../src/on_boarding/domain/usecases/cache_first_timer.dart';
import '../../src/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import '../../src/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'injection_container.main.dart';
