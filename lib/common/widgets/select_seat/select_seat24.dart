import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../features/application/controllers/cart_controller.dart';
import '../../../features/application/models/cart_item_model.dart';

class MultiSeatSelector24 extends StatelessWidget {
  final CartItemModel cartItem;

  MultiSeatSelector24({required this.cartItem});

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
              final availableSeats = _generateAvailableSeats(); // Hàm tạo danh sách ghế

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Tắt cuộn để GridView nằm trong cột
                itemCount: availableSeats.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4, // Số cột (có thể điều chỉnh theo hình)
                  mainAxisSpacing: 8.0, // Khoảng cách giữa các ghế
                  crossAxisSpacing: 8.0,
                  childAspectRatio: 1.2, // Điều chỉnh tỷ lệ ghế (chiều rộng/chiều cao)
                ),
                itemBuilder: (context, index) {
                  final seat = availableSeats[index];
                  final isUnavailable = unavailableSeats.contains(seat);
                  final isSelected = cartItem.selectedSeats.contains(seat);

                  return GestureDetector(
                    onTap: isUnavailable
                        ? null
                        : () {
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
      '1A', '1B', '1C', '1D',
      '2A', '2B', '2C', '2D',
      '3A', '3B', '3C', '3D',
      '4A', '4B', '4C', '4D',
      '5A', '5B', '5C', '5D',
      '6A', '6B', '6C', '6D',

    ];
  }
}
