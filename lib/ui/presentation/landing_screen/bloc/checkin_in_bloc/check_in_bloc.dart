import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:el_race/ui/presentation/landing_screen/repository/check_in_repo.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

import '../../repository/location_reop.dart';

part 'check_in_event.dart';
part 'check_in_state.dart';

LocationRepo _locationRepo = LocationRepo();
CheckInREpo _checkInREpo = CheckInREpo();

class CheckInBloc extends Bloc<CheckInEvent, CheckInState> {
  CheckInBloc() : super(CheckInInitial()) {
    on<CheckInET>(checkInMethod);
  }

  FutureOr<void> checkInMethod(
      CheckInET event, Emitter<CheckInState> emit) async {
    try {
      Position location = await _locationRepo.getCurrentLocation();

      Response? response = await _checkInREpo.checkInUser(
          location.latitude.toString(), location.longitude.toString());

      log(response!.data.toString());
    } catch (e) {
      log('checkInMethod $e');
    }
  }
}
