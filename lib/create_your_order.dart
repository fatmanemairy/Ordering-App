import 'package:flutter/material.dart';
import 'dart:convert';
import 'food_item.dart';
import 'package:assessment/your-order-summary.dart';

class CreateYourOrder extends StatefulWidget {
  final double needcalories;

  const CreateYourOrder({Key? key, required this.needcalories}) : super(key: key);

  @override
  State<CreateYourOrder> createState() => CreateYourOrderState();
}

class CreateYourOrderState extends State<CreateYourOrder> {
  List<FoodItem> vegetables = [];
  List<FoodItem> meats = [];
  List<FoodItem> carbs = [];

  @override
  void initState() {
    super.initState();
    _loadFoodData();
  }

  String vegetablesJson = '''[
   {
      "food_name":"Broccoli",
      "calories":55,
      "price":55,
      "image_url":"https://cdn.britannica.com/25/78225-050-1781F6B7/broccoli-florets.jpg"
       
   },
   {
      "food_name":"Spinach",
      "calories":23,
       "price":20,
       "image_url":"https://www.daysoftheyear.com/cdn-cgi/image/dpr=1%2Cf=auto%2Cfit=cover%2Cheight=650%2Cq=40%2Csharpen=1%2Cwidth=956/wp-content/uploads/fresh-spinach-day.jpg"
       
   },
   {
      "food_name":"Carrot",
      "calories":41,
       "price":10,
      "image_url":"https://cdn11.bigcommerce.com/s-kc25pb94dz/images/stencil/1280x1280/products/271/762/Carrot__40927.1634584458.jpg?c=2"
    
   },
   {
      "food_name":"Bell Pepper",
      "calories":31,
       "price":30,
      "image_url":"https://i5.walmartimages.com/asr/5d3ca3f5-69fa-436a-8a73-ac05713d3c2c.7b334b05a184b1eafbda57c08c6b8ccf.jpeg?odnHeight=768&odnWidth=768&odnBg=FFFFFF"
    
   }
]''';
  String carbsJson = '''[
   {
      "food_name":"Brown Rice",
      "calories":111,
        "price":15,
     "image_url":"https://assets-jpcust.jwpsrv.com/thumbnails/k98gi2ri-720.jpg"
  
   },   
   {
      "food_name":"Oats",
      "calories":389,
          "price":25,
      "image_url":"https://media.post.rvohealth.io/wp-content/uploads/2020/03/oats-oatmeal-732x549-thumbnail.jpg"

   },
   {
      "food_name":"Sweet Corn",
      "calories":86,
      "price":22,
      "image_url":"https://m.media-amazon.com/images/I/41F62-VbHSL._AC_UF1000,1000_QL80_.jpg"
    
   },
   {
      "food_name":"Black Beans",
      "calories":132,
      "price":20,
      "image_url":"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTwxSM9Ib-aDXTUIATZlRPQ6qABkkJ0sJwDmA&usqp=CAU"
    
   }
]''';
  String meatsJson = '''[
   {
      "food_name": "Chicken Breast",
      "calories": 165,
        "price":50,
      "image_url": "https://www.savorynothings.com/wp-content/uploads/2021/02/airy-fryer-chicken-breast-image-8.jpg"
   
   },
   {
      "food_name": "Salmon",
      "calories": 206,
       "price":75,
      "image_url": "https://cdn.apartmenttherapy.info/image/upload/f_jpg,q_auto:eco,c_fill,g_auto,w_1500,ar_1:1/k%2F2023-04-baked-salmon-how-to%2Fbaked-salmon-step6-4792"
      
   },
   {
      "food_name": "Lean Beef",
      "calories": 250,
       "price":80,
      "image_url": "https://www.mashed.com/img/gallery/the-truth-about-lean-beef/l-intro-1621886574.jpg"
  
   },
   {
      "food_name": "Turkey",
      "calories": 135,
       "price":75,
      "image_url": "https://fox59.com/wp-content/uploads/sites/21/2022/11/white-meat.jpg?w=2560&h=1440&crop=1"
    
   }
]''';

  void _loadFoodData() {
    vegetables = parseJsonData(vegetablesJson);
    meats = parseJsonData(meatsJson);
    carbs = parseJsonData(carbsJson);
  }

  List<FoodItem> parseJsonData(String jsonData) {
    List<dynamic> jsonList = json.decode(jsonData);
    return jsonList.map((item) => FoodItem(
      foodName: item['food_name'],
      calories: item['calories'],
      price: item['price'].toDouble(),
      imageUrl: item['image_url'],
    )).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 25.0),
          icon: Icon(Icons.arrow_left_sharp, size: 35.0),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Center(
          child: Text(
            'Create your order',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  buildSection('Vegetables', vegetables),
                  buildSection('Meats', meats),
                  buildSection('Carbs', carbs),
                ],
              ),
            ),
          ),
          buildFooter(),
        ],
      ),
    );
  }

  Widget buildSection(String title, List<FoodItem> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 200,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 16.0),
              ...items.map((item) => buildFoodItem(item)).toList(),
              SizedBox(width: 16.0),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildFoodItem(FoodItem item) {
    return Container(
      width: 180,
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 115,
              child: Image.network(
                item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item.foodName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(' ${item.calories} Cal'),
                      ],
                    ),
                    SizedBox(height: 4.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('\$${item.price.toStringAsFixed(2)}'),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Color(0xFFFF5733),
                              child: IconButton(
                                icon: Icon(Icons.remove, size: 14.0, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    if (item.quantity > 0) {
                                      item.quantity--;
                                    }
                                  });
                                },
                              ),
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              '${item.quantity}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 8.0),
                            CircleAvatar(
                              radius: 14.0,
                              backgroundColor: Color(0xFFFF5733),
                              child: IconButton(
                                icon: Icon(Icons.add, size: 14.0, color: Colors.white),
                                onPressed: () {
                                  setState(() {
                                    item.quantity++;
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFooter() {
    int totalCalories = 0;
    double totalPrice = 0.0;

    List<FoodItem> selectedItems = [];

    for (var item in [...vegetables, ...meats, ...carbs]) {
      if (item.quantity > 0) {
        selectedItems.add(item);
        totalCalories += item.calories * item.quantity;
        totalPrice += item.price * item.quantity;
      }
    }

    double minCalories = widget.needcalories * 0.9;

    bool isButtonEnabled = totalCalories >= minCalories || totalCalories == widget.needcalories;

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
                  color: Colors.grey, // Light grey color
                ),
              ),
            ],
          ),
          SizedBox(height: 8.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Price',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$ ${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFFFF5733), // Light grey color
                ),
              ),
            ],
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: isButtonEnabled
                ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YourOrderSummary(
                    selectedItems: selectedItems,
                    totalCalories: totalCalories,
                    totalPrice: totalPrice,
                    needcalories: widget.needcalories,
                  ),
                ),
              );
            }
                : null, // Disable button if criteria are not met
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: isButtonEnabled ? Color(0xFFF25700) : Colors.grey, // Change button color based on state
              minimumSize: Size(100, 50), // Button size (width, height)
              padding: const EdgeInsets.symmetric(horizontal: 125, vertical: 22), // Button padding
              textStyle: const TextStyle(
                fontSize: 16,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15), // Border radius
              ),
            ),
            child: Text('Place Order'),
          ),
        ],
      ),
    );
  }

}
