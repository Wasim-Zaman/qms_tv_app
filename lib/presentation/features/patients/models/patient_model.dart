class Department {
  final String tblDepartmentID;
  final String deptcode;
  final String deptname;

  Department({
    required this.tblDepartmentID,
    required this.deptcode,
    required this.deptname,
  });

  factory Department.fromJson(Map<String, dynamic> json) {
    return Department(
      tblDepartmentID: json['tblDepartmentID'] as String,
      deptcode: json['deptcode'] as String,
      deptname: json['deptname'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'tblDepartmentID': tblDepartmentID,
      'deptcode': deptcode,
      'deptname': deptname,
    };
  }
}

class User {
  final String name;
  final String email;
  final String deptcode;

  User({required this.name, required this.email, required this.deptcode});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json['name'] as String,
      email: json['email'] as String,
      deptcode: json['deptcode'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'deptcode': deptcode};
  }
}

class PatientModel {
  final String id;
  final String name;
  final String nationality;
  final String sex;
  final String idNumber;
  final int age;
  final String mobileNumber;
  final String status;
  final String cheifComplaint;
  final String ticket;
  final int ticketNumber;
  final String barcode;
  final String bloodGroup;
  final String birthDate;
  final String mrnNumber;
  final String remarks;
  final String registrationDate;
  final String? firstCallTime;
  final String? vitalTime;
  final String? assignDeptTime;
  final String? secondCallTime;
  final String departmentId;
  final String userId;
  final String? bedId;
  final int state;
  final bool callPatient;
  final String? beginTime;
  final String? endTime;
  final String createdAt;
  final String updatedAt;
  final Department department;
  final User user;
  final List<dynamic> vitalSigns;

  PatientModel({
    required this.id,
    required this.name,
    required this.nationality,
    required this.sex,
    required this.idNumber,
    required this.age,
    required this.mobileNumber,
    required this.status,
    required this.cheifComplaint,
    required this.ticket,
    required this.ticketNumber,
    required this.barcode,
    required this.bloodGroup,
    required this.birthDate,
    required this.mrnNumber,
    required this.remarks,
    required this.registrationDate,
    this.firstCallTime,
    this.vitalTime,
    this.assignDeptTime,
    this.secondCallTime,
    required this.departmentId,
    required this.userId,
    this.bedId,
    required this.state,
    required this.callPatient,
    this.beginTime,
    this.endTime,
    required this.createdAt,
    required this.updatedAt,
    required this.department,
    required this.user,
    required this.vitalSigns,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    return PatientModel(
      id: json['id'] as String,
      name: json['name'] as String,
      nationality: json['nationality'] as String,
      sex: json['sex'] as String,
      idNumber: json['idNumber'] as String,
      age: json['age'] as int,
      mobileNumber: json['mobileNumber'] as String,
      status: json['status'] as String,
      cheifComplaint: json['cheifComplaint'] as String,
      ticket: json['ticket'] as String,
      ticketNumber: json['ticketNumber'] as int,
      barcode: json['barcode'] as String,
      bloodGroup: json['bloodGroup'] as String,
      birthDate: json['birthDate'] as String,
      mrnNumber: json['mrnNumber'] as String,
      remarks: json['remarks'] as String,
      registrationDate: json['registrationDate'] as String,
      firstCallTime: json['firstCallTime'] as String?,
      vitalTime: json['vitalTime'] as String?,
      assignDeptTime: json['assignDeptTime'] as String?,
      secondCallTime: json['secondCallTime'] as String?,
      departmentId: json['departmentId'] as String,
      userId: json['userId'] as String,
      bedId: json['bedId'] as String?,
      state: json['state'] as int,
      callPatient: json['callPatient'] as bool,
      beginTime: json['beginTime'] as String?,
      endTime: json['endTime'] as String?,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      department: Department.fromJson(
        json['department'] as Map<String, dynamic>,
      ),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      vitalSigns: json['vitalSigns'] as List<dynamic>,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'nationality': nationality,
      'sex': sex,
      'idNumber': idNumber,
      'age': age,
      'mobileNumber': mobileNumber,
      'status': status,
      'cheifComplaint': cheifComplaint,
      'ticket': ticket,
      'ticketNumber': ticketNumber,
      'barcode': barcode,
      'bloodGroup': bloodGroup,
      'birthDate': birthDate,
      'mrnNumber': mrnNumber,
      'remarks': remarks,
      'registrationDate': registrationDate,
      'firstCallTime': firstCallTime,
      'vitalTime': vitalTime,
      'assignDeptTime': assignDeptTime,
      'secondCallTime': secondCallTime,
      'departmentId': departmentId,
      'userId': userId,
      'bedId': bedId,
      'state': state,
      'callPatient': callPatient,
      'beginTime': beginTime,
      'endTime': endTime,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'department': department.toJson(),
      'user': user.toJson(),
      'vitalSigns': vitalSigns,
    };
  }
}
