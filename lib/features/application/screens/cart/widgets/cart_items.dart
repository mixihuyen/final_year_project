import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/shadows.dart';
import '../../../../../common/widgets/icons/t_ticket_icon.dart';
import '../../../../../common/widgets/select_date/select_date.dart';
import '../../../../../common/widgets/select_seat/select_seat24.dart';
import '../../../../../common/widgets/select_seat/select_seat34.dart';
import '../../../../../common/widgets/text/ticket_price_text.dart';
import '../../../../../common/widgets/text/ticket_title_text.dart';
import '../../../../../common/widgets/tickets/cart/add_remove_button.dart';
import '../../../../../common/widgets/tickets/ticket_location/ticket_location.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../../../utils/helpers/location_helper.dart';
import '../../../controllers/cart_controller.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/cart_item_model.dart';
import '../../../models/category_model.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController()); // Lấy controller giỏ hàng
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());

    return Obx(() {
      if (cartController.cartItems.isEmpty) {
        return Center(
          child: Text(
            'Your cart is empty!',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        );
      }
      return Column(
        children: cartController.cartItems.map((cartItem) {
          CategoryModel? category = categoryController.allCategories.firstWhereOrNull(
                  (cat) => cat.id == cartItem.category);
          final startLocationName = LocationHelper.getStationName(cartItem.start?.startLocation);
          final endLocationName = LocationHelper.getStationName(cartItem.end?.endLocation);
          final startProvinceName = LocationHelper.getProvinceName(cartItem.start?.startProvince);
          final endProvinceName = LocationHelper.getProvinceName(cartItem.end?.endProvince);
          return Container(
            width: 390,
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            decoration: BoxDecoration(
              color: dark ? TColors.textPrimary : TColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [TShadowStyle.ticketShadow],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// -- Title
                TTicketTitleText(
                  title:
                  '$startProvinceName - $endProvinceName',
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                /// -- Divider
                const Divider(),

                /// -- Ticket Details
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// -- Icon
                    const TicketDetailIcons(),
                    const SizedBox(width: TSizes.defaultSpace),

                    /// -- Details
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TicketTimeLocation(
                          time: cartItem.start?.departureTime ?? '',
                          location: startLocationName ?? '',
                          province: startProvinceName ?? '',
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TicketTimeLocation(
                          time: cartItem.end?.arrivalTime ?? '',
                          location: endLocationName ?? '',
                          province: endProvinceName ?? '',
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                /// -- Category
                Row(
                  children: [
                    Text(
                      'Category: ',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    Text(
                      category?.name ?? 'Unknown Category',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),

                /// -- Date
                DatePicker(cartItem: cartItem),
                const Divider(),
                const SizedBox(height: TSizes.spaceBtwItems),
                /// -- Seats Selector (Kiểm tra category.id để gọi widget khác nhau)
                if (category?.name == '34-room VIP')
                  MultiSeatSelector34(cartItem: cartItem)
                else if (category?.name == '24-room VIP')
                  MultiSeatSelector24(cartItem: cartItem),

              ],
            ),
          );
        }).toList(),
      );
    }
    );
  }
}
