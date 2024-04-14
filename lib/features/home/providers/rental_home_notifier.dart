import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/core/utils/types.dart';
import 'package:real_estate_app/features/auth/providers/auth_providers.dart';
import 'package:real_estate_app/features/home/data/house_data_service.dart';
import 'package:real_estate_app/features/home/models/rental_house.dart';

class RentalHomeNotifier extends StateNotifier<AsyncValue> {
  RentalHomeNotifier({required this.repository})
      : super(const AsyncValue.data(null));

  final RentalHomeService repository;

  FutureEither0 addRentalHouse(
      {required RentalHouse rentalHouse, required String? ownerId}) async {
    state = const AsyncValue.loading();
    return await repository
        .addRentalHouse(ownerId: ownerId, rentalHouse: rentalHouse)
        .whenComplete(() => state = const AsyncValue.data(null));
  }

  FutureEither0 deleteHouse() async {
    return await repository.deleteHouse();
  }

  Stream<List<RentalHouse>> getAllRentalHouse() {
    return repository.getAllRentalHouse();
  }

  FutureEither0 updateHouse(
      String houseId, Map<String, dynamic> updatefields) async {
    return await repository.updateHouse(houseId, updatefields);
  }
}

final rentalHomeNotifierProvider =
    StateNotifierProvider<RentalHomeNotifier, AsyncValue>((ref) {
  final repository = ref.read(rentalHomeRepository);
  return RentalHomeNotifier(repository: repository);
});

final rentalHomeRepository = Provider((ref) {
  final userService = ref.read(userServiceProvider);
  return RentalHomeService(userService: userService);
});

final rentalHomeStreamProvider = StreamProvider((ref) {
  final repository = ref.read(rentalHomeRepository);
  return repository.getAllRentalHouse();
});