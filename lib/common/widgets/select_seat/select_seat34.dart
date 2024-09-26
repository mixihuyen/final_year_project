import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/application/controllers/cart_controller.dart';
import '../../../features/application/models/cart_item_model.dart';

class MultiSeatSelector34 extends StatelessWidget {
  final CartItemModel cartItem;

  MultiSeatSelector34({required this.cartItem});

  @override
  Widget build(BuildContext context) {
    final cartController = Get.put(CartController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (cartItem.date != null) ...[
          FutureBuilder<List<String>>(
            future: cartController.getUnavailableSeats(cartItem.tripId, cartItem.date),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              }

              final unavailableSeats = snapshot.data!;
              final availableSeats = _generateAvailableSeats();

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Tắt cuộn để GridView nằm trong cột
                itemCount: availableSeats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6, // Số cột (có thể điều chỉnh theo hình)
                  mainAxisSpacing: 8.0, // Khoảng cách giữa các ghế
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 0.8, // Điều chỉnh tỷ lệ ghế (chiều rộng/chiều cao)
                ),
                itemBuilder: (context, index) {
                  final seat = availableSeats[index];
                  final isUnavailable = unavailableSeats.contains(seat);
                  final isSelected = cartItem.selectedSeats.contains(seat);

                  return GestureDetector(
                    onTap: isUnavailable
                        ? null
                        : () {
                      // Khi người dùng chọn hoặc bỏ chọn ghế
                      cartController.selectSeat(cartItem, seat, !isSelected);
                    },
                    child: Column(
                      children: [
                        // Icon ghế (có thể thay bằng hình ảnh PNG hoặc SVG)
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isUnavailable
                                    ? Colors.grey // Ghế đã đặt
                                    : isSelected
                                    ? Colors.red // Ghế đang chọn
                                    : Colors.white, // Ghế trống
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(color: Colors.black26),
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.bed, // Dùng icon hình giường
                                  color: isUnavailable ? Colors.white : Colors.black,
                                  size: 24,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // Hiển thị số ghế
                        Text(
                          seat,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isUnavailable ? Colors.grey : Colors.black,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ],
      ],
    );
  }

  // Hàm tạo danh sách các ghế có sẵn
  List<String> _generateAvailableSeats() {
    // Tạo danh sách ghế giống với hình ảnh
    return [
      'A-01', 'B-01', 'A-02', 'B-02',
      'A-03', 'B-03', 'A-04', 'B-04',
      'A-05', 'B-05', 'A-06', 'B-06',
      'A-07', 'B-07', 'A-08', 'B-08',
      'A-09', 'B-09', 'A-10', 'B-10',
      'A-11', 'B-11', 'A-12', 'B-12',
      'A-13', 'B-13', 'A-14', 'B-14',
      'A-15', 'B-15', 'A-16', 'B-16',
      'A-17', 'B-17',
    ];
  }
}


