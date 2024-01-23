import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port_pass_app/core/errors/exceptions.dart';
import 'package:port_pass_app/core/errors/failure.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:dartz/dartz.dart';
import 'package:port_pass_app/src/gate_report/data/datasources/gate_report_remote_data_source.dart';
import 'package:port_pass_app/src/gate_report/data/models/report_model.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/activity.dart';
import 'package:port_pass_app/src/gate_report/domain/entities/report.dart';
import 'package:port_pass_app/src/gate_report/domain/repositories/gate_report_repository.dart';

class GateReportRepositoryImpl implements GateReportRepository {
  const GateReportRepositoryImpl(this._remoteDataSource);

  final GateReportRemoteDataSource _remoteDataSource;

  @override
  ResultFuture<Activity> addReport({
    required int activityId,
    required Report reportData,
  }) async {
    try {
      final reportModel = ReportModel(
        name: reportData.name,
        urgentLetter: reportData.urgentLetter,
        documentation: reportData.documentation,
      );

      final ships = await _remoteDataSource.getShips();

      final result = await _remoteDataSource.addReport(
        activityId: activityId,
        reportData: reportModel,
        ships: ships,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> getActivity({required String activityCode}) async {
    try {
      final ships = await _remoteDataSource.getShips();
      final result = await _remoteDataSource.getActivity(
        activityCode: activityCode,
        ships: ships,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<bool> getLocation({
    required double? longitude,
    required double? latitude,
  }) async {
    try {
      final result = await _remoteDataSource.getLocation(
        longitude: longitude,
        latitude: latitude,
      );

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<String> scanQRActivity({required List<Barcode> barcodes}) async {
    try {
      dynamic result = barcodes.first.displayValue;

      if (result == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture addDocumentation() async {
    try {
      final result = await _remoteDataSource.addDocumentation();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture addUrgentLetter() async {
    try {
      final result = await _remoteDataSource.addUrgentLetter();
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}
