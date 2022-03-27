import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/constants.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  late String cityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          padding: EdgeInsets.only(left: 30),
          icon: Icon(
            Icons.home,
            color: kIconColor,
          ),
          iconSize: 35,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 32, right: 32, top: 20),
        child: Column(
          children: [
            TextField(
              style: TextStyle(
                color: Colors.black,
              ),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                prefixIcon: Icon(
                  Icons.location_on,
                  color: Colors.grey,
                ),
                hintText: 'City Name',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: (value) {
                cityName = value;
              },
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                  width: double.infinity,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center,
                      backgroundColor: kAditionColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    ),
                    onPressed: () {
                      Navigator.pop(context, cityName);
                    },
                    child: Text(
                      'Search',
                      style: kCustomTextStyle.copyWith(
                        fontSize: 28,
                      ),
                    ),
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
