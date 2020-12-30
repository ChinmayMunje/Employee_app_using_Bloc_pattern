
import 'dart:async';

import 'package:movie_bloc/Employee.dart';

class EmployeeBloc {
  List<Employee> _employeeList = [
    Employee(1, "Employee 1", 10000.0),
    Employee(2, "Employee 2", 20000.0),
    Employee(3, "Employee 3", 30000.0),
    Employee(4, "Employee 4", 40000.0),
    Employee(5, "Employee 5", 50000.0),
  ];
// output Stream
  final ListStreamController = StreamController<List<Employee>>();
  final IncrementStreamController = StreamController<Employee>();
  final DecrementStreamController = StreamController<Employee>();


  //Input Sink
Stream<List<Employee>> get employeeListStream => ListStreamController.stream;

StreamSink<List<Employee>> get employeeListSink => ListStreamController.sink;

StreamSink<Employee> get employeeSalaryIncrement => IncrementStreamController.sink;

StreamSink<Employee> get employeeSalaryDecrement => DecrementStreamController.sink;


EmployeeBloc(){
  ListStreamController.add(_employeeList);
  
  IncrementStreamController.stream.listen(_incrementSalary);
  
  DecrementStreamController.stream.listen(_decrementSalary);
}

  @override
  void dispose() {
    // TODO: implement dispose
    ListStreamController.close();
    IncrementStreamController.close();
    DecrementStreamController.close();
  }

  void _incrementSalary(Employee employee) {
  double salary = employee.salary;
  double incrementedSalary = salary * 20/100;

  _employeeList[employee.id -1].salary = salary + incrementedSalary;
  employeeListSink.add(_employeeList);
  }

  void _decrementSalary(Employee employee) {
    double salary = employee.salary;
    double decrementedSalary = salary * 20/100;

    _employeeList[employee.id -1].salary = salary - decrementedSalary;
    employeeListSink.add(_employeeList);
  }
}
