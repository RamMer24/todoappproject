import 'package:flutter/material.dart';
import 'package:todoappproject/helpers/databasehandler.dart';
import 'package:todoappproject/screen/Createpage.dart';
import 'package:todoappproject/screen/Updatedata.dart';

class Viewscreen extends StatefulWidget {
  @override
  State<Viewscreen> createState() => _ViewscreenState();
}

class _ViewscreenState extends State<Viewscreen> {
  Future<List>? alldatap;

  Future<List> getdata() async {
    databasehandler obj = new databasehandler();
    var alldata = await obj.viewtitle();
    return alldata;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      alldatap = getdata();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Viewscreen")),
      ),
      body: FutureBuilder(
        future: alldatap,
        builder: (context, snapshots) {
          if (snapshots.hasData) {
            if (snapshots.data!.length == 0) {
              return Center(
                child: Text("no data found"),
              );
            } else {
              return ListView.builder(
                  itemCount: snapshots.data!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        ListTile(
                          leading:
                              Text(snapshots.data![index]["tid"].toString()),
                          title:
                              Text(snapshots.data![index]["title"].toString()),
                          subtitle:
                              Text(snapshots.data![index]["remark"].toString()),
                          trailing:
                              Text(snapshots.data![index]["date"].toString()),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                AlertDialog alert = new AlertDialog(
                                  title: Text("Are you sure!"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () async{
                                        var id = snapshots.data![index]["tid"].toString();
                                        databasehandler obj = new databasehandler();
                                        var status = await obj.deleteNote(id);
                                        if(status==1)
                                          {
                                            setState(() {
                                              alldatap = getdata();
                                            });
                                          }
                                        else
                                          {
                                            print("Record Not Deleted");
                                          }
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Yes"),
                                    ),
                                ElevatedButton(onPressed: (){
                                  Navigator.of(context).pop();
                                }, child: Text("No"),
                                ),
                                  ],
                                );
                                showDialog(context: context, builder:(context)
                                {
                                  return alert;
                                });
                                },

                                // var id = snapshots.data![index]["tid"].toString();
                                // databasehandler obj = new databasehandler();
                                // var status = await obj.deleteNote(id);
                                // if(status==1)
                                //   {
                                //     setState(() {
                                //       alldatap = getdata();
                                //     });
                                //   }
                                // else
                                //   {
                                //     print("Record Not Deleted");
                                //   }

                              icon: Icon(Icons.delete),

                            ),
                            IconButton(onPressed: (){
                              var id = snapshots.data![index]["tid"].toString();
                              var tl = snapshots.data![index]["title"].toString();


                              Navigator.of(context).push(
                                  MaterialPageRoute(builder:(context)=>Updatedata(
                                    updateid: id
                                  )));
                            },
                         icon: Icon(Icons.update),),
                          ],
                        ),
                        // IconButton(onPressed: (){},
                        //     icon: Icon(Icons.update),),
                      ],
                    );
                  });
            }
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      floatingActionButton: Container(
        child: FloatingActionButton(
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Createpage()));
          },
          child: Icon(
            Icons.add,
            size: 35,
          ),
        ),
      ),
    );
  }
}
