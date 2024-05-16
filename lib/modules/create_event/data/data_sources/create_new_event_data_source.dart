import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:treeme/core/config/apis/config_api.dart';
import 'package:treeme/core/netwrok/failure.dart';
import 'package:treeme/modules/create_event/data/models/character_model.dart';
import 'package:treeme/modules/create_event/data/models/event_type_model.dart';
import 'package:treeme/modules/create_event/data/models/new_event_model.dart';

import '../../../../core/errors/error_response_model.dart';
import '../../../../core/errors/handle_error.dart';
import '../../../../core/netwrok/web_connection.dart';
import '../../../../core/utils/connectivity_check/i_connectivity_checker.dart';

abstract class ICreateEventDataSource {
  Future<Either<Failure, EventTypeModel>> getTypeEvent();
  Future<Either<Failure, List<CharacterModel>>> getCharacters();
  Future<Either<Failure, NewEventModel>> newEvent(String title, String date,
      String time, String event, String ownerId, String participants);
}

class CreateEventDataSource implements ICreateEventDataSource {
  final WebServiceConnections _webServiceConnections;
  final IConnectivityChecker _connectivityChecker;

  CreateEventDataSource(this._webServiceConnections, this._connectivityChecker);

  @override
  Future<Either<Failure, EventTypeModel>> getTypeEvent() async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: API.eventApp,
          showLoader: false,
          useMyPath: false,
        );

        switch (response.statusCode) {
          case 200:
            final errorResponseModel =
                ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              EventTypeModel eventTypeModel =
                  EventTypeModel.fromJson(response.data);
              return Right(eventTypeModel);
            } else {
              return Left(Failure(
                  errorResponseModel.code ?? ResponseCode.DEFAULT,
                  errorResponseModel.message ?? ResponseMessage.DEFAULT));
            }

          default:
            // 3.

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
  Future<Either<Failure, List<CharacterModel>>> getCharacters() async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections.getRequest(
          path: API.characters,
          showLoader: false,
          useMyPath: false,
        );

        switch (response.statusCode) {
          case 200:
          
           
              List<CharacterModel> characters = [];
              for (var element in response.data['characters']['data']) {
                characters.add(CharacterModel.fromJson(element));
              }

              return Right(characters);
            
            

          default:
            // 3.

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
  Future<Either<Failure, NewEventModel>> newEvent(String title, String date,
      String time, String event, String ownerId, String participants) async {
    bool isConnected = await _connectivityChecker.isConnected();
    if (isConnected) {
      try {
        Response response = await _webServiceConnections
            .postRequest(path: API.newEventApp, showLoader: false, data: {
          'title': title,
          'date': date,
          'time': time,
          'event': event,
          'participants': participants,
          'ownerId': ownerId
        });
        print(response.data.toString());
        print(response.statusCode);

        switch (response.statusCode) {
          case 200:
            final errorResponseModel =
                ErrorResponseModel.fromJson(response.data);
            if (errorResponseModel.code == 200) {
              NewEventModel eventModel = NewEventModel.fromJson(response.data);
              print(eventModel.toString());
              return Right(eventModel);
            } else {
              print(errorResponseModel.code.toString());
              print('return Failure with the desired exception');
              return Left(Failure(
                  errorResponseModel.code ?? ResponseCode.DEFAULT,
                  errorResponseModel.message ?? ResponseMessage.DEFAULT));
            }
          //
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
