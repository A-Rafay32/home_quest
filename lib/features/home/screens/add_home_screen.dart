import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:real_estate_app/app/constants/app_images.dart';
import 'package:real_estate_app/app/constants/firebase_constants.dart';
import 'package:real_estate_app/app/themes/app_paddings.dart';
import 'package:real_estate_app/app/themes/app_text_field_themes.dart';
import 'package:real_estate_app/core/enums/house_status.dart';
import 'package:real_estate_app/core/enums/house_type.dart';
import 'package:real_estate_app/core/extensions/routes_extenstion.dart';
import 'package:real_estate_app/core/extensions/sizes_extensions.dart';
import 'package:real_estate_app/core/extensions/snackbar_ext.dart';
import 'package:real_estate_app/features/auth/providers/auth_providers.dart';
import 'package:real_estate_app/features/auth/screens/widgets/app_bar_white.dart';
import 'package:real_estate_app/features/auth/screens/widgets/button.dart';
import 'package:real_estate_app/features/auth/screens/widgets/custom_text_field.dart';
import 'package:real_estate_app/features/home/models/house_details.dart';
import 'package:real_estate_app/features/home/models/house_location.dart';
import 'package:real_estate_app/features/home/models/rental_house.dart';
import 'package:real_estate_app/features/home/providers/home_providers.dart';

class AddRentalHomeScreen extends ConsumerStatefulWidget {
  const AddRentalHomeScreen({super.key});

  @override
  ConsumerState<AddRentalHomeScreen> createState() => _AddRentalHomeScreenState();
}

class _AddRentalHomeScreenState extends ConsumerState<AddRentalHomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController bathroomQtyController = TextEditingController();
  TextEditingController roomQtyController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController rentController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  void clear() {
    nameController.clear();
    bathroomQtyController.clear();
    roomQtyController.clear();
    addressController.clear();
    sizeController.clear();
    rentController.clear();
    descriptionController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(65),
          child: CustomAppBar(
              onPressed: () {
                context.pop();
              },
              text: "Add Home")),
      body: SizedBox(
          height: context.h,
          width: context.w,
          child: SingleChildScrollView(
            child: Column(
              children: [
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: nameController,
                    inputDecoration: AppTextFieldDecorations.genericInputDecoration(label: "Name")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: addressController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(label: "Address")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: bathroomQtyController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(label: "No. of Bathrooms")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: sizeController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(label: "Size in feet")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: roomQtyController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(label: "No. of Rooms")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: rentController,
                    inputDecoration: AppTextFieldDecorations.genericInputDecoration(
                        label: "\$ Rent Per Month ")),
                AppSizes.normalY,
                CustomTextField(
                    validator: (value) {
                      return value == null ? "Field can't be empty" : null;
                    },
                    controller: descriptionController,
                    inputDecoration:
                        AppTextFieldDecorations.genericInputDecoration(label: "Description")),
                AppSizes.normalY,
                Button(
                    isLoading: ref.watch(rentalHomeNotifierProvider).isLoading,
                    press: () => addHouse(ref, context),
                    text: "Add House"),
                AppSizes.largeY,
              ],
            ),
          )),
    );
  }

  void addHouse(WidgetRef ref, BuildContext context) async {
    String? ownerId = ref.read(currentUserProvider)?.uid;
    print(ownerId);
    RentalHouse rentalhouse = RentalHouse(
        id: "",
        houseDetails: HouseDetails(
          balconyQty: 2,
          bathroomQty: 3,
          floors: 1,
          hasGarage: true,
          hasTerrace: false,
          kitchen: 1,
          livingRoomQty: 1,
          parkingSpaces: 1,
          roomQty: 3,
          sizeInFeet: 100,
        ),
        houseLocation: HouseLocation(
          address: addressController.text.trim(),
        ),
        name: nameController.text.trim().toString(),
        description: descriptionController.text.trim(),
        constructedOn: DateTime.now(),
        ownerId: ownerId,
        images: AppImages.houseImages,
        isFurnished: true,
        houseStatus: HouseStatus.Rent,
        houseType: HouseType.House,
        isAvailable: true,
        isFeatured: false,
        listedBy: currentUser?.uid ?? "",
        isApproved: true,
        propertyTax: 300,
        rentPerMonth: double.parse(rentController.text.trim()));
    final result = await ref
        .read(rentalHomeNotifierProvider.notifier)
        .addRentalHouse(rentalHouse: rentalhouse, ownerId: ownerId);
    result.fold((left) {
      context.showSnackBar(left.message.toString());
    }, (right) {
      clear();
      context.showSnackBar(right.message.toString());
    });
  }
}
