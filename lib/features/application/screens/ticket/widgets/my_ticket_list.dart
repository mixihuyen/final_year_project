import 'package:final_year_project/common/widgets/custom_shapes/containers/rounded_container.dart';
import 'package:final_year_project/common/widgets/loaders/animation_loader.dart';
import 'package:final_year_project/features/application/controllers/order_controller.dart';
import 'package:final_year_project/features/application/screens/home/home.dart';
import 'package:final_year_project/features/application/screens/trips/allTrips.dart';
import 'package:final_year_project/navigation_menu.dart';
import 'package:final_year_project/utils/constants/image_strings.dart';
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
import '../../../../../utils/formatters/forrmatter.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import '../../cart/widgets/cart_items.dart';

class TMyTicketListItem extends StatelessWidget {
  const TMyTicketListItem({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    final categoryController = Get.put(CategoryController());
    return FutureBuilder(
      future: controller.fetchUserOrders(),
      builder: (_, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị loading indicator khi đang tải
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hiển thị thông báo lỗi nếu có sự cố
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Hiển thị widget thông báo không có đơn hàng
          return const TAnimationLoaderWidget(
            text: "Whoops! Looks like you haven't booked your tickets yet",
            animation: TImages.bee,
          );
        }
        final orders = snapshot.data!;
        orders.sort((a, b) => b.orderDate.compareTo(a.orderDate));
        return ListView.separated(
          shrinkWrap: true,
          itemCount: orders.length,
          separatorBuilder: (_, index) =>
          const SizedBox(height: TSizes.spaceBtwSections),
          itemBuilder: (_, index)
          {
            final order = orders[index];
            return Column(
                children: [
                  for (var item in order.items)

              Container(
              width: 400,
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
                    '${item.start?.startProvince ?? ''} - ${item.end?.endProvince ?? ''}',
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
                            time: item.start?.departureTime ?? '',
                            location: item.start?.startLocation ?? '',
                            province: item.start?.startProvince ?? '',
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                          TicketTimeLocation(
                            time: item.end?.arrivalTime ?? '',
                            location: item.end?.endLocation ?? '',
                            province: item.end?.endProvince ?? '',
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
                        'Category:   ',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        categoryController.allCategories.firstWhere(
                                (cat) => cat.id == item.category
                        ).name,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text('Seats:   ',
                          style: Theme.of(context).textTheme.bodySmall),
                      Text(item.selectedSeats.join(', '),
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),

                  /// -- Date
                  Row(children: [
                    Text('Departure Date:   ', style: Theme.of(context).textTheme.bodySmall),
                    Text(' ${TFormatter.formatDate(item.date)} ', style: Theme.of(context).textTheme.bodyMedium),

                  ]),
                  const Divider(),
                  Text('Customer Information ',
                      style: Theme.of(context).textTheme.titleSmall),
                  const SizedBox(height: TSizes.spaceBtwItems/2),
                  Row(
                      children:[

                        Text('Full Name:   ', style: Theme.of(context).textTheme.bodySmall),
                        Text('${order.name} ', style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                  Row(
                      children:[
                        Text('Phone Number:   ', style: Theme.of(context).textTheme.bodySmall),
                        Text('${order.phoneNumber} ', style: Theme.of(context).textTheme.bodyMedium),
                      ]),

                  const Divider(),
                  Row(
                      children:[
                        Text('Payment Method:   ', style: Theme.of(context).textTheme.bodySmall),
                        Text('${order.paymentMethod} ', style: Theme.of(context).textTheme.bodyMedium),
                  ]),
                  Row(
                      children:[
                        Text('Order Date:   ', style: Theme.of(context).textTheme.bodySmall),
                        Text(TFormatter.formatDate(order.orderDate), style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                  const Divider(),

                  /// -- Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total amount: ',
                          style: Theme.of(context).textTheme.titleMedium),
                      TTicketPriceText(
                        price: TFormatter.format(order.totalAmount),
                      ),
                    ],
                  ),
                ],
              ),
            ),

                ],
              );
          }
        );
      },

    );
  }
}
