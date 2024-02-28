import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/netwrok/web_connection.dart';
import 'package:treeme/core/utils/connectivity_check/i_connectivity_checker.dart';
import 'package:treeme/modules/contacts/data/models/contact_chat.dart';
import 'package:treeme/modules/contacts/data/models/my_contact_model.dart';

import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../../../../core/netwrok/failure.dart';
import '../models/search_contact.dart';

abstract class IMyContactsDataSource {
  Future<Either<Failure, MyContactModel>> getMyContact();
  Future<Either<Failure, ContactChat>> createChatContact(String id);
  Future<Either<Failure, SearchContact>> searchContact(String query);
}

class MyContactDataSource implements IMyContactsDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  MyContactDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, MyContactModel>> getMyContact() async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: API.getContact,
          showLoader: false,
          useMyPath: false,
        );
        print(response.data.toString());
        print(response.statusCode);

        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              MyContactModel myContactModel = MyContactModel.fromJson(response.data);
              print(myContactModel.toString());
              return Right(myContactModel);
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
  Future<Either<Failure, ContactChat>> createChatContact(String id) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.postRequest(
          path: API.createPeerConversation,
          data: {
            'user_id': id,
          },
          showLoader: false,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              ContactChat contactChat = ContactChat.fromJson(response.data);

              return Right(contactChat);
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
  Future<Either<Failure, SearchContact>> searchContact(String query) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: '${API.searchUser}?query=$query',
          useMyPath: false,
          showLoader: false,
        );
        print(response.data.toString());
        switch (response.statusCode) {
          case 200:
            final errorResponseModel = ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              SearchContact contactChat = SearchContact.fromJson(response.data);

              return Right(contactChat);
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
