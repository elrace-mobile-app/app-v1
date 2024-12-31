import 'package:el_race/ui/presentation/landing_screen/bloc/checkin_in_bloc/check_in_bloc.dart';
import 'package:el_race/ui/presentation/signin/bloc/sign_in_bloc.dart';
import 'package:el_race/ui/presentation/signin/data/model.dart';
import 'package:el_race/ui/presentation/signin/data/repository.dart';
import 'package:get_it/get_it.dart';

import '../ui/presentation/call_screen/bloc/contact_bloc.dart';
import '../ui/presentation/call_screen/data/repository.dart';

final sl = GetIt.instance;
Future<void> initDI() async {
  sl.registerSingleton<SignInBloc>(SignInBloc());
  sl.registerSingleton<UserRepo>(UserRepo());
  sl.registerSingleton<ContactRepo>(ContactRepo());
  sl.registerSingleton<ContactBloc>(ContactBloc());
  sl.registerSingleton<LoginResponseModel>(LoginResponseModel());
  sl.registerSingleton<CheckInBloc>(CheckInBloc());
}
