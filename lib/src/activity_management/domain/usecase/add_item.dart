import 'package:equatable/equatable.dart';
import 'package:port_pass_app/core/usecase/usecase.dart';
import 'package:port_pass_app/core/utils/typedef.dart';
import 'package:port_pass_app/src/activity_management/domain/entities/item.dart';
import 'package:port_pass_app/src/activity_management/domain/repositories/activity_management_repository.dart';

class AddItem implements UsecaseWithParams<List<Item>, AddItemParams> {
  const AddItem(this._repository);

  final ActivityManagementRepository _repository;

  @override
  ResultFuture<List<Item>> call(AddItemParams params) => _repository.addItem(
        items: params.items,
        item: params.item,
        index: params.index,
      );
}

class AddItemParams extends Equatable {
  const AddItemParams({
    required this.items,
    required this.item,
    required this.index,
  });

  AddItemParams.empty()
      : items = [],
        item = const Item.empty(),
        index = -1;

  final List<Item> items;
  final Item item;
  final int index;

  @override
  List<Object?> get props => [item];
}
