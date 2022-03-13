import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1.5,
          leading: Builder(
            builder: (context) => IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.orange[600],
                ),
                onPressed: () => Navigator.of(context).pop()),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  child: Card(
                      elevation: 1.5,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Container(
                              height: 150,
                              width: 150,
                              margin: const EdgeInsets.only(top: 10),
                              decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.orangeAccent),
                              padding: const EdgeInsets.all(5),
                              child: CircleAvatar(
                                minRadius: 18,
                                backgroundColor: Colors.white,
                                child: Image.asset(
                                  'assets/images/profile_pic.png',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 1,
                            child: Container(
                              alignment: Alignment.center,
                              child: const Text(
                                'Mr Hudson',
                                style: TextStyle(fontSize: 20),
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 5,
                            child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                    Icons.calendar_today,
                                                    color: Colors.orange[600]),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Icon(Icons.store,
                                                    color: Colors.orange[600]),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment: Alignment.center,
                                                child: Icon(
                                                  Icons.location_city,
                                                  color: Colors.orange[600],
                                                ),
                                              ),
                                            ),
                                              Expanded(
                                            flex: 1,
                                            child: Container(),
                                          )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        children: <Widget>[
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Date Of Birth:',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Shop Name:',
                                                style: TextStyle(
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.centerLeft,
                                              child: const Text(
                                                'Address:',
                                                style: TextStyle(fontSize: 16),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Container(),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        child: Column(
                                          children: <Widget>[
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment:
                                                    Alignment.center,
                                                child: const Text('26/01/1980',style: TextStyle(fontSize: 14),textAlign: TextAlign.justify,),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment:
                                                    Alignment.center,
                                                child: const Text("Hudson's Store",style: TextStyle(fontSize: 14),textAlign: TextAlign.justify,),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Container(
                                                alignment:
                                                    Alignment.center,
                                                child: const Text('West NewBerry Massachussets 1234',style: TextStyle(fontSize: 14),),
                                              ),
                                            ),
                                              Expanded(
                                            flex: 1,
                                            child: Container(),
                                          )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                )),
                          )
                        ],
                      )),
                )),
            Container(
              padding: const EdgeInsets.only(left:20,right: 20,top: 10,bottom: 10),
              width: double.infinity,
              height: 70,
              child: MaterialButton(
                child: const Text('Edit Profile'),
                color: Colors.orangeAccent,
                onPressed: () {},
              ),
            )
          ],
        ));
  }
}
