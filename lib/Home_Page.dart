import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:movie_bloc/Employee.dart';
import 'package:movie_bloc/bloc/Employee_bloc.dart';

class Home_Page extends StatefulWidget {
  @override
  _Home_PageState createState() => _Home_PageState();
}

class _Home_PageState extends State<Home_Page> {

  final EmployeeBloc _employeeBloc = EmployeeBloc();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Employee App"),
      ),
      body: Container(
        child: StreamBuilder<List<Employee>>(
          stream: _employeeBloc.employeeListStream,
          builder: (BuildContext context, AsyncSnapshot<List<Employee>> snapshot){
            return ListView.builder(
              itemCount: snapshot.data.length,
                itemBuilder: (context, index){
                return Card(
                  elevation: 4.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("${snapshot.data[index].id}.",
                        style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${snapshot.data[index].name}.",
                              style: TextStyle(fontSize: 17),
                            ),
                            Text("₹ ${snapshot.data[index].salary}.",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_up),
                          color: Colors.green,
                          onPressed: (){
                            _employeeBloc.employeeSalaryIncrement.add(snapshot.data[index]);
                          },
                        ),
                      ),
                      Container(
                        child: IconButton(
                          icon: Icon(Icons.thumb_down),
                          color: Colors.red,
                          onPressed: (){
                            _employeeBloc.employeeSalaryDecrement.add(snapshot.data[index]);
                          },
                        ),
                      ),
                    ],
                  ),

                );
                },
            );
          },
        ),
      ),
    );
  }
}
