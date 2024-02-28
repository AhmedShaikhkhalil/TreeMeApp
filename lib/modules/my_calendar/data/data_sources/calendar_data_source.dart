import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/modules/my_calendar/data/models/event_data_model.dart';

import '../../../../core/config/apis/config_api.dart';
import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../../../../core/netwrok/failure.dart';
import '../../../../core/netwrok/web_connection.dart';
import '../../../../core/utils/connectivity_check/i_connectivity_checker.dart';

abstract class ICalendarDataSource {
  Future<Either<Failure, EventDataModel>> getCalendar();
}

class CalendarDataSource implements ICalendarDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  CalendarDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, EventDataModel>> getCalendar() async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: API.getCalendar,
          showLoader: false,
          useMyPath: false,
        );
        print(response.data.toString());
        print(response.statusCode);

        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              EventDataModel eventDataModel = EventDataModel.fromJson(response.data);
              log(eventDataModel.toString());
              return Right(eventDataModel);
            } else {
              print(errorResponseModel.code.toString());
              print('return Failure with the desired exception');
              return Left(Failure(errorResponseModel.code ?? ResponseCode.DEFAULT,
                  errorResponseModel.message ?? ResponseMessage.DEFAULT));
            }

          default:
            // 3.
            print('return Failure with the desired exception');

            return Left(Failure(response.statusCode ?? ResponseCode.DEFAULT,
                response.statusMessage ?? ResponseMessage.DEFAULT));
        }

        // return registerModel;
      } catch (error) {
        print('return Failure $error');

        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
