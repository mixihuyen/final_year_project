import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../../../common/styles/shadows.dart';
import '../../../../../common/widgets/icons/t_ticket_icon.dart';
import '../../../../../common/widgets/select_date/select_date.dart';
import '../../../../../common/widgets/text/ticket_price_text.dart';
import '../../../../../common/widgets/text/ticket_title_text.dart';
import '../../../../../common/widgets/tickets/cart/add_remove_button.dart';
import '../../../../../common/widgets/tickets/ticket_location/ticket_location.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
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
                  (cat) => cat.id == cartItem.category,);
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
                  '${cartItem.start?.startProvince ?? ''} - ${cartItem.end?.endProvince ?? ''}',
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
                          location: cartItem.start?.startLocation ?? '',
                          province: cartItem.start?.startProvince ?? '',
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        TicketTimeLocation(
                          time: cartItem.end?.arrivalTime ?? '',
                          location: cartItem.end?.endLocation ?? '',
                          province: cartItem.end?.endProvince ?? '',
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

                /// -- Price and Quantity
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// -- Quantity with add/remove buttons
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {
                            cartController.updateQuantity(cartItem, -1);
                          },
                          icon: const Icon(Icons.remove),
                        ),
                        Text('${cartItem.quantity}'),
                        IconButton(
                          onPressed: () {
                            cartController.updateQuantity(cartItem, 1);
                          },
                          icon: const Icon(Icons.add),
                        ),
                      ],
                    ),

                    /// -- Price
                    TTicketPriceText(
                      price: cartItem.getFormattedPrice(),
                    ),
                  ],
                ),
              ],
            ),
          );
        }).toList(),
      );
    }
    );
  }
}
