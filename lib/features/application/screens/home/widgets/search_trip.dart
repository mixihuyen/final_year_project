// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
//
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/sizes.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../../../utils/helpers/helper_functions.dart';
// import '../../../controllers/trip_controller.dart';
// import '../../../models/trip_model.dart';
//
// class SearchTrip extends StatefulWidget {
//   const SearchTrip({super.key});
//
//   @override
//   _SearchTripState createState() => _SearchTripState();
// }
//
// class _SearchTripState extends State<SearchTrip> {
//   String? pickupLocation;
//   String? destinationLocation;
//   DateTime? selectedDate;
//
//   List<String> uniquePickupLocations = [];
//   List<String> uniqueDestinationLocations = [];
//
//   final TripController tripController = Get.put(TripController());
//
//   @override
//   void initState() {
//     super.initState();
//     _loadTripsData();
//   }
//
//   // Hàm để tải dữ liệu chuyến đi và lấy ra các địa điểm duy nhất
//   Future<void> _loadTripsData() async {
//     final trips = await tripController.fetchAllTrips();
//
//     // Trích xuất các địa điểm khởi hành và điểm đến duy nhất
//     final pickupSet = <String>{};
//     final destinationSet = <String>{};
//
//     for (var trip in trips) {
//       if (trip.start != null && trip.start!.startProvince != null) {
//         pickupSet.add(trip.start!.startProvince!);
//       }
//       if (trip.end != null && trip.end!.endProvince != null) {
//         destinationSet.add(trip.end!.endProvince!);
//       }
//     }
//
//     setState(() {
//       uniquePickupLocations = pickupSet.toList();
//       uniqueDestinationLocations = destinationSet.toList();
//     });
//   }
//
//   // Hàm chọn điểm đón
//   Future<void> _selectPickupLocation() async {
//     final location = await showModalBottomSheet<String>(
//       context: context,
//       builder: (context) {
//         return ListView(
//           children: uniquePickupLocations.map((location) {
//             return ListTile(
//               title: Text(location),
//               onTap: () => Navigator.pop(context, location),
//             );
//           }).toList(),
//         );
//       },
//     );
//
//     if (location != null) {
//       setState(() {
//         pickupLocation = location;
//       });
//     }
//   }
//
//   // Hàm chọn điểm đến
//   Future<void> _selectDestinationLocation() async {
//     final location = await showModalBottomSheet<String>(
//       context: context,
//       builder: (context) {
//         return ListView(
//           children: uniqueDestinationLocations.map((location) {
//             return ListTile(
//               title: Text(location),
//               onTap: () => Navigator.pop(context, location),
//             );
//           }).toList(),
//         );
//       },
//     );
//
//     if (location != null) {
//       setState(() {
//         destinationLocation = location;
//       });
//     }
//   }
//
//   Future<void> _selectDate() async {
//     final DateTime? date = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//     );
//
//     if (date != null) {
//       setState(() {
//         selectedDate = date;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final dark = THelperFunctions.isDarkMode(context);
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Container(
//         padding: const EdgeInsets.all(16.0),
//         decoration: BoxDecoration(
//           color: dark ? TColors.textPrimary : TColors.white,
//           borderRadius: BorderRadius.circular(16.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 8,
//               offset: const Offset(0, 4),
//             ),
//           ],
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: TSizes.spaceBtwItems),
//             Row(
//               children: [
//                 Text(TTexts.titleSearch,
//                     style: Theme.of(context).textTheme.titleMedium),
//               ],
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Icon(Iconsax.location),
//               title: Text(TTexts.pickUpPoint,
//                   style: Theme.of(context).textTheme.labelMedium),
//               subtitle: Text( pickupLocation ?? TTexts.selectPickUpPoint,
//                   style: Theme.of(context).textTheme.bodyLarge),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: _selectPickupLocation,
//             ),
//             const Divider(),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Icon(Iconsax.send_1),
//               title: Text(TTexts.destination,
//                   style: Theme.of(context).textTheme.labelMedium),
//               subtitle: Text( destinationLocation ?? TTexts.selectDestination,
//                   style: Theme.of(context).textTheme.bodyLarge),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: _selectDestinationLocation,
//             ),
//             const Divider(),
//             ListTile(
//               contentPadding: EdgeInsets.zero,
//               leading: const Icon(Iconsax.calendar),
//               title: Text(TTexts.date,
//                   style: Theme.of(context).textTheme.labelMedium),
//               subtitle: Text( selectedDate != null
//                   ? '${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}'
//                   : TTexts.selectDate,
//                   style: Theme.of(context).textTheme.bodyLarge),
//               trailing: const Icon(Icons.arrow_forward_ios),
//               onTap: _selectDate,
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             SizedBox(
//               width: double.infinity,
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: TColors.primary,
//                   padding: const EdgeInsets.symmetric(vertical: 16.0),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15.0),
//                   ),
//                 ),
//                 onPressed: () {
//                   // Thực hiện tìm kiếm với các tham số được chọn
//                 },
//                 child: Text(TTexts.search,
//                     style: Theme.of(context).textTheme.bodyLarge!.apply(color: TColors.white)),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
