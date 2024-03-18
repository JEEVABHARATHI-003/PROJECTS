import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'imagescreen.dart';
import 'model.dart';

// ignore: must_be_immutable
class secondpage extends StatefulWidget {
  List<Product> art;
  secondpage({super.key, required this.art});
  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Items in Cart"),
        backgroundColor: Colors.amber,
      ),
      body: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 6,
          crossAxisSpacing: 4,
        ),
        padding: EdgeInsets.all(12.0),
        itemCount: widget.art.length,
        itemBuilder: (context, i) {
          return InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                          actions: [
                            InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text("Close"))
                          ],
                          title: Text("Product Details"),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Title : ${widget.art[i].title}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text("Price : ${widget.art[i].price}"),
                              Text("Quantity : ${widget.art[i].quantity}"),
                              SizedBox(
                                height: height * 0.03,
                              ),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => imagescreen(
                                                  img: Image.network(widget
                                                      .art[i].thumbnail))));
                                    },
                                    child: Text("View Image")),
                              )
                            ],
                          ),
                        ));
              },
              child: Card(
                margin: EdgeInsets.all(1),
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8.0),
                              topRight: Radius.circular(8.0),
                            ),
                            child: Image.network(widget.art[i].thumbnail,
                                height: height * 0.10, fit: BoxFit.fill)),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.art[i].title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 11),
                          ),
                          Text('Price: ${widget.art[i].price.toString()}',
                              style: TextStyle(fontSize: 10)),
                          Text('Quantity: ${widget.art[i].quantity.toString()}',
                              style: TextStyle(fontSize: 10)),
                        ],
                      ),
                    ),
                  ],
                ),
              ));
        },
      ),
    ));
  }
}
