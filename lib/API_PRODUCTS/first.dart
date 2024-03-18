import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'model.dart';
import 'second.dart';

class firstpage extends StatefulWidget {
  firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  DateTime backhome = DateTime.now();
  List<Cart> kart = [];
  @override
  void initState() {
    super.initState();
    gets();
  }

  Future<void> gets() async {
    try {
      Dio dio = Dio();

      final response = await dio.get('https://dummyjson.com/carts');
      print(response.data);
      if (response.statusCode == 200) {
        setState(() {
          kart = Cartjson.fromJson(response.data).carts;
        });
      } else {
        throw Exception('Failed to load');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> _onBackPressed() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Exit App?'),
            content: Text('Do you want to exit the app?'),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('No'),
              ),
              ElevatedButton(
                onPressed: () => SystemNavigator.pop(),
                child: Text('Yes'),
              ),
            ],
          ),
        )) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: SafeArea(
          child: Scaffold(
        appBar: AppBar(
          
          title: Center(child: Text("WECART")),
          leading: null,
          automaticallyImplyLeading: false,
          backgroundColor: Colors.amber,
        ),
        body: ListView.builder(
            itemCount: kart.length,
            itemBuilder: (context, index) => ListTile(
                    title: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 255, 216, 100),
                  ),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text(
                                'Cart Id  :  ',
                                style: TextStyle(),
                              ),
                              Text('${kart[index].id}')
                            ],
                          ),
                        ),
                        ExpansionTile(
                            collapsedShape: RoundedRectangleBorder(),
                            maintainState: true,
                            backgroundColor:
                                const Color.fromARGB(255, 197, 197, 195),
                            collapsedBackgroundColor:
                                const Color.fromARGB(255, 234, 204, 114),
                            title: Text("View Cart Details"),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('User Id',
                                            style: TextStyle(fontSize: 10)),
                                        Text('Total Product',
                                            style: TextStyle(fontSize: 10)),
                                        Text('Discount',
                                            style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${kart[index].userId}',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          '${kart[index].totalProducts}',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text('${kart[index].discountedTotal}',
                                            style: TextStyle(fontSize: 10)),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.05,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(""),
                                        Text(
                                          'Total Quantity',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                        Text(
                                          'Total',
                                          style: TextStyle(fontSize: 10),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      width: width * 0.06,
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(''),
                                        Text('${kart[index].totalQuantity}',
                                            style: TextStyle(fontSize: 10)),
                                        Text('${kart[index].total}',
                                            style: TextStyle(fontSize: 10))
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              GridView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 6,
                                  crossAxisSpacing: 4,
                                ),
                                padding: EdgeInsets.all(12.0),
                                itemCount: kart[index].products.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            ClipRRect(
                                                borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(8.0),
                                                  topRight:
                                                      Radius.circular(8.0),
                                                ),
                                                child: Image.network(
                                                    kart[index]
                                                        .products[i]
                                                        .thumbnail,
                                                    height: height * 0.10,
                                                    fit: BoxFit.fill)),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                kart[index].products[i].title,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 10),
                                              ),
                                              Text(
                                                'Price: ${kart[index].products[i].price.toString()}',
                                                style: TextStyle(fontSize: 8),
                                              ),
                                              Text(
                                                'Quantity: ${kart[index].products[i].quantity.toString()}',
                                                style: TextStyle(fontSize: 8),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          (MaterialPageRoute(
                                              builder: (context) => secondpage(
                                                  art: kart[index].products))));
                                    },
                                    child: Text("View Products")),
                              )
                            ])
                      ]),
                ))),
      )),
    );
  }
}
