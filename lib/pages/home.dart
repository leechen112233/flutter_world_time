import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map data ={};
  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty? data: ModalRoute.of(context)!.settings.arguments as Map;

    //set background
    String bgImage = data['isDayTime']?'assets/day.png':'assets/night.png';
    Color? bgColor = data['isDayTime']?Colors.blue:Colors.indigo[700];
    
    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(bgImage),
              fit: BoxFit.cover,
              )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 120, 0, 0),
              child: Column(
                children: [
                  ElevatedButton.icon(
                    onPressed: ()async{
                      //consider the whole serie of action as one async task: go to the location page, click a location, pop the location page with data
                      dynamic result = await Navigator.pushNamed(context, '/location');
                      print(result);
                      setState(() {
                        data = {
                          'time':result['time'],
                          'location':result['location'],
                          'isDayTime':result['isDayTime'],
                        };
                      });
                    },
                    icon: Icon(Icons.edit_location),
                    label: Text(
                      'Edit locations',
                      style: TextStyle(
                        color: Colors.grey[300],
                      ),
                    )
                  ),
                  SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                          data['location'],
                          style: TextStyle(
                            fontSize: 28,
                            letterSpacing: 2.0,
                            color: Colors.white,
                        )
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Text(
                      data['time'],
                      style: TextStyle(
                          fontSize: 66,
                          letterSpacing: 2.0,
                          color: Colors.white,
                      )
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
