part of 'contact_bloc.dart';

sealed class ContactState extends Equatable {
  const ContactState();
  @override
  List<Object> get props => [];
}

final class ContactInitial extends ContactState {}

final class EmployeeListLoaded extends ContactState {
  final List<Employee> empList;
  const EmployeeListLoaded({required this.empList});
  @override
  List<Object> get props => [empList];
}

final class ContactLoadingState extends ContactState {
  final bool isLoading;
  const ContactLoadingState({required this.isLoading});
  @override
  List<Object> get props => [isLoading];
}
