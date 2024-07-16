import 'package:flutter/material.dart';
import 'package:assessment/food_item.dart';
import 'package:assessment/create_your_order.dart';


class YourOrderSummary extends StatefulWidget {
  final List<FoodItem> selectedItems;
  final int totalCalories;
  final double totalPrice;
  final double needcalories;

  const YourOrderSummary({
    Key? key,
    required this.selectedItems,
    required this.totalCalories,
    required this.totalPrice,
    required this.needcalories,
  }) : super(key: key);

  @override
  _YourOrderSummaryState createState() => _YourOrderSummaryState();
}

class _YourOrderSummaryState extends State<YourOrderSummary> {
  late List<FoodItem> selectedItems;
  late int totalCalories;
  late double totalPrice;

  @override
  void initState() {
    super.initState();
    selectedItems = widget.selectedItems;
    totalCalories = widget.totalCalories;
    totalPrice = widget.totalPrice;
  }

  void increaseQuantity(int index) {
    setState(() {
      selectedItems[index].quantity++;
      recalculateTotal();
    });
  }

  void decreaseQuantity(int index) {
    setState(() {
      if (selectedItems[index].quantity > 0) {
        selectedItems[index].quantity--;
        recalculateTotal();
      }
    });
  }

  void recalculateTotal() {
    totalCalories = 0;
    totalPrice = 0.0;
    for (var item in selectedItems) {
      totalCalories += item.calories * item.quantity;
      totalPrice += item.price * item.quantity;
    }
  }

  Widget buildFooter() {
    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Cal',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$totalCalories out of ${widget.needcalories}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Price',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFFFF5733), // Light grey color
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreateYourOrder(needcalories: widget.needcalories),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color(0xFFF25700),
              minimumSize: Size(100, 50),
              padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 22), // Button padding
              textStyle: const TextStyle(
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: Text('Confirm'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Summary'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: selectedItems.length,
                itemBuilder: (context, index) {
                  final item = selectedItems[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(
                        item.imageUrl,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                      ),
                      title: Text(item.foodName),
                      subtitle: Text('${item.calories} Cal'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Color(0xFFFF5733),
                            child: IconButton(
                              icon: Icon(Icons.remove, size: 14.0, color: Colors.white),
                              onPressed: () {
                                decreaseQuantity(index);
                              },
                            ),
                          ),
                          SizedBox(width: 7,),
                          Text('${item.quantity}'),
                          SizedBox(width: 2,),
                          CircleAvatar(
                            radius: 14.0,
                            backgroundColor: Color(0xFFFF5733),
                            child: IconButton(
                              icon: Icon(Icons.add, size: 14.0, color: Colors.white),
                              onPressed: () {
                                increaseQuantity(index);
                              },
                            ),
                          ),
                          SizedBox(width: 4,),
                          Text('\$${item.price.toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16.0),
            buildFooter(),
          ],
        ),
      ),
    );
  }
}




















