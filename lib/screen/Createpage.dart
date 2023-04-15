import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todoappproject/helpers/databasehandler.dart';

class Createpage extends StatefulWidget {

  @override
  State<Createpage> createState() => _CreatepageState();
}

class _CreatepageState extends State<Createpage> {

  TextEditingController dateinput = TextEditingController();
  TextEditingController _title = TextEditingController();
  TextEditingController _remark = TextEditingController();



  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Createpage"),
        ),

        body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Container(
          padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * 0.1),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Container(
    margin: EdgeInsets.only(left: 35, right: 35),
    child: Column(
    children: [
    TextFormField(
controller: _title,
      validator: (val)
      {
        if (val!.length<=0)
          {
            return "please enter title";
          }
        return null;
      },
      keyboardType: TextInputType.text,
    style: TextStyle(color: Colors.black),
    decoration: InputDecoration(
    enabledBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(
    color: Colors.black,
    ),

    ),
    hintText: "Title",
    hintStyle: TextStyle(color: Colors.black),
    border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    )),
    ),
      SizedBox(
          height: 30,
      ),

      TextFormField(
          controller: _remark,
        validator: (val)
        {
          if (val!.length<=0)
          {
            return "please enter remark";
          }
          return null;
        },
          keyboardType: TextInputType.text,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),

              hintText: "Remark",
              hintStyle: TextStyle(color: Colors.black),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              )),
      ),
              Container(
                  padding: EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.width / 3,
                  child: Center(
                      child: TextFormField(
                        style: TextStyle(color: Colors.black),
                        controller: dateinput,
                        //editing controller of this TextField
                        decoration: InputDecoration(

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,

                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.black,
                              ),
                            ),
                            icon: Icon(Icons.calendar_today), //icon of text field
                            labelText: "Enter Date" //label text of field
                        ),
                        readOnly: true,
                        //set it true, so that user will not able to edit text
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              //DateTime.now() - not to allow to choose before today.
                              lastDate: DateTime(2100));

                          if (pickedDate != null) {
                            print(
                                pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {

                              dateinput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      ),
                  ),
              ),
      Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xffFE7551),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10,),
              ),
            ),
            onPressed: () async{
             if(formkey.currentState!.validate()){
               var title =_title.text.toString();
               var remark =_remark.text.toString();
               var date =dateinput.text.toString();

               databasehandler obj = new  databasehandler();
               var status = await obj.insertitle(title,remark,date);
               print("Record inserted at:"+status.toString());

             }
            },

            child: Text("ADD",style: TextStyle(fontSize: 35.0,),),),
      ),

    ]

    ),
    ),
  ],
    ),
    ),
        ),

    ),
    );

  }
}
