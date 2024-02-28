import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/core/config/apis/config_api.dart';

import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../../../../core/netwrok/failure.dart';
import '../../../../core/netwrok/web_connection.dart';
import '../../../../core/utils/connectivity_check/i_connectivity_checker.dart';
import '../../../../core/utils/image_picker/i_image_file.dart';
import '../models/update_profile_model.dart';

abstract class IEditProfileDataSource {
  Future<Either<Failure, UpdateProfileModel>> updateProfile(
      String id, IImageFile? file, String age, String name);
}

class EditProfileDataSource implements IEditProfileDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  EditProfileDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, UpdateProfileModel>> updateProfile(
      String id, IImageFile? file, String age, String name) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: '${API.searchUser}/$id',
          useMyPath: false,
          data: {'name': name, 'age': age},
          file: file,
          showLoader: false,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              UpdateProfileModel updateProfileModel =
                  UpdateProfileModel.fromJson(response.data);

              return Right(updateProfileModel);
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
