// import 'package:final_year_project/features/application/controllers/category_controller.dart';
// import 'package:final_year_project/features/application/models/category_model.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
//
// import '../../../../../common/widgets/layouts/grid_layout.dart';
// import 'ticket_card.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../controllers/trip_controller.dart';
// import '../../../models/trip_model.dart';
// class TTripTab extends StatelessWidget {
//   const TTripTab({super.key, required this.category});
//
//   final CategoryModel category;
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = CategoryController.instance;
//     return FutureBuilder(
//       future: controller.getCategoryTrips(categoryId: category.id),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // Hiển thị spinner nếu dữ liệu đang được tải
//           return const Center(child: CircularProgressIndicator());
//         }
//         if (snapshot.hasError) {
//           // Hiển thị thông báo lỗi nếu có lỗi xảy ra
//           return Center(child: Text('Error: ${snapshot.error}'));
//         }
//         if (snapshot.hasData) {
//           // Nếu có dữ liệu, hiển thị danh sách các chuyến đi
//           final trips = snapshot.data as List<TripModel>;  // Đảm bảo kiểu dữ liệu phù hợp
//           return Padding(
//             padding: const EdgeInsets.all(TSizes.defaultSpace),
//             child: TGridLayout(
//                 itemCount: trips.length,
//                 itemBuilder: (_, index) => TTicketCard(trip: trips[index])
//             ),
//           );
//         } else {
//           // Hiển thị thông báo nếu không có chuyến đi nào
//           return const Center(child: Text('No trips available.'));
//         }
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/category_controller.dart';
import '../../../models/category_model.dart';
import '../../../models/trip_model.dart';
import 'ticket_card.dart';
import '../../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../../utils/constants/sizes.dart';


class TTripTab extends StatelessWidget {
  final CategoryModel category;

  const TTripTab({Key? key, required this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CategoryController controller = CategoryController.instance;

    return FutureBuilder<List<TripModel>>(
      future: controller.getCategoryTrips(categoryId: category.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No trips available.'));
        }

        final trips = snapshot.data!;
        print('Displaying trips for categoryId ${category.id}: ${trips.length} trips found.');
        return Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: TGridLayout(
            itemCount: trips.length,  // Số lượng chuyến đi cần hiển thị
            itemBuilder: (_, index) => TTicketCard(trip: trips[index]),  // Hiển thị đúng chuyến đi
          ),
        );
      },
    );
  }
}

