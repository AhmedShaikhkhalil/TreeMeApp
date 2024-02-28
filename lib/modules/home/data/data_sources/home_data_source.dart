import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/netwrok/failure.dart';

import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../../../../core/netwrok/web_connection.dart';
import '../../../../core/utils/connectivity_check/i_connectivity_checker.dart';
import '../models/home_model.dart';

abstract class IHomeDataSource {
  Future<Either<Failure, String>> postContact(String phones);
  Future<Either<Failure, HomeModel>> getHome();
  Future<Either<Failure, bool>> refeshToken(String firebase, String newToken);
}

class HomeDataSource implements IHomeDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  HomeDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, String>> postContact(String phones) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.contactTest,
          data: {
            'phones': phones,
          },
          showLoader: false,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              return Right(response.data['message']);
            } else {
              return Left(Failure(errorResponseModel.code ?? ResponseCode.DEFAULT,
                  errorResponseModel.message ?? ResponseMessage.DEFAULT));
            }

          default:
            // 3. return Failure with the desired exception
            return Left(Failure(response.statusCode ?? ResponseCode.DEFAULT,
                response.statusMessage ?? ResponseMessage.DEFAULT));
        }

        // return registerModel;
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, HomeModel>> getHome() async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: API.getHome,
          showLoader: false,
          useMyPath: false,
        );
        print(response.data.toString());
        print(response.statusCode);

        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              HomeModel homeModel = HomeModel.fromJson(response.data);
              log(homeModel.toString());
              return Right(homeModel);
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

  @override
  Future<Either<Failure, bool>> refeshToken(String firebase, String newToken) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
            path: '${API.UpdateFcm}/$firebase/$newToken',
            showLoader: false,
            useMyPath: true);
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            return const Right(true);

          default:
            // 3. return Failure with the desired exception
            return Left(Failure(response.statusCode ?? ResponseCode.DEFAULT,
                response.statusMessage ?? ResponseMessage.DEFAULT));
        }

        // return registerModel;
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
