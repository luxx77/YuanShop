part of 'address_cubit.dart';

class AddressState extends Equatable {
  final AddressApiState state;
  final List<AddressModel> models;
  final PaginationModel? pagination;

  const AddressState(
      {this.models = const [], required this.state, this.pagination});

  @override
  List<Object?> get props => [models, state, pagination];
}
