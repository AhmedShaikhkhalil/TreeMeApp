import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/netwrok/failure.dart';
import 'package:treeme/core/netwrok/web_connection.dart';
import 'package:treeme/core/utils/connectivity_check/i_connectivity_checker.dart';
import 'package:treeme/modules/auth/data/models/login_model.dart';
import 'package:treeme/modules/auth/data/models/reset_password_model.dart';

import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../models/RegisterModel.dart';

abstract class IAuthDataSource {
  Future<Either<Failure, RegisterModel>> register(
      String name, String password, String confirmPassword, String phone);
  Future<Either<Failure, LoginModel>> login(
      String phone, String password, String fcmToken);
  Future<Either<Failure, ResetPasswordModel>> sendOtp(String phone);
  Future<Either<Failure, String>> resetPassword(String otp, String newPass, String phone);
}

class AuthDataSource implements IAuthDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  AuthDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, RegisterModel>> register(
      String name, String password, String confirmPassword, String phone) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.register,
          data: {
            'password': password,
            'name': name,
            'confirm_password': confirmPassword,
            'phone': phone,
          },
          showLoader: true,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              RegisterModel registerModel = RegisterModel.fromJson(response.data);

              return Right(registerModel);
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
  Future<Either<Failure, LoginModel>> login(
      String phone, String password, String fcmToken) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.login,
          data: {'password': password, 'phone': phone, 'fcm_token': fcmToken},
          showLoader: false,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              LoginModel loginModel = LoginModel.fromJson(response.data);

              return Right(loginModel);
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
  Future<Either<Failure, ResetPasswordModel>> sendOtp(String phone) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.verifyOtp,
          data: {
            'phone': phone,
          },
          showLoader: true,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              ResetPasswordModel resetPasswordModel =
                  ResetPasswordModel.fromJson(response.data);

              return Right(resetPasswordModel);
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
  Future<Either<Failure, String>> resetPassword(
      String otp, String newPass, String phone) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.verifyOtpAndResetPassword,
          data: {'phone': phone, 'otp': otp, 'new_password': newPass},
          showLoader: true,
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
}
