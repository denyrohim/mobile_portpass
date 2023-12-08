import 'package:geolocator/geolocator.dart';
import 'package:latlng/latlng.dart';
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
        location: reportData.location,
        urgentLetter: reportData.urgentLetter,
        documentation: reportData.documentation,
        dateTime: reportData.dateTime,
      );

      final result = await _remoteDataSource.addReport(
        activityId: activityId,
        reportData: reportModel,
      );
      return Right(result as Activity);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<Activity> getActivity({required int activityId}) async {
    try {
      final result = await _remoteDataSource.getActivity(
        activityId: activityId,
      );
      return Right(result as Activity);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<LatLng> getLocation() async {
    try {
      final result = await Geolocator.getCurrentPosition()
          .then((value) => LatLng(value.latitude, value.longitude));
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<int> scanQRActivity() async {
    try {
      late dynamic result;
      MobileScanner(
        onDetect: (BarcodeCapture barcodes) {
          result = barcodes.barcodes.first.displayValue;
        },
      );
      if (result == null) {
        throw const ServerException(message: "Not SignedIn", statusCode: 400);
      }
      result = int.parse(result);
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
