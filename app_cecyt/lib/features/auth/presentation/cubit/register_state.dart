part of 'register_cubit.dart';

sealed class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

final class RegisterInitial extends RegisterState {}

final class RegisterProgressState extends RegisterState {}

final class RegisterSuccessState extends RegisterState {
  final RegisterResponseModel userData;

  const RegisterSuccessState(this.userData);
}

final class RegisterErrorState extends RegisterState {
  final String error;

  const RegisterErrorState(this.error);
}
