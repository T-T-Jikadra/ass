// ignore_for_file: file_names, non_constant_identifier_names
class GovtRegistration {
  final String gid;
  final String GovtAgencyName;
  final String GovtAgencyARegNo;
  final String services;
  final String contactNumber;
  final String email;
  final String website;
  final String state;
  final String city;
  final String pinCode;
  final String fullAddress;
  final String password;
  final DateTime registrationTime;
  final String deviceToken;

  GovtRegistration(
      {required this.gid,
      required this.GovtAgencyName,
      required this.GovtAgencyARegNo,
      required this.services,
      required this.contactNumber,
      required this.email,
      required this.website,
      required this.state,
      required this.city,
      required this.pinCode,
      required this.fullAddress,
      required this.password,
      required this.deviceToken,
      DateTime? registrationTime})
      : registrationTime = registrationTime ?? DateTime.now();

  Map<String, dynamic> toJsonGovt() {
    return {
      'gid': gid,
      'GovtAgencyName': GovtAgencyName,
      'GovtAgencyRegNo': GovtAgencyARegNo,
      'services': services,
      'contactNumber': "+91$contactNumber",
      'website': website,
      'email': email,
      'state': state,
      'city': city,
      'pinCode': pinCode,
      'fullAddress': fullAddress,
      'password': password,
      'registrationTime': registrationTime.toString(),
      'deviceToken': deviceToken,
    };
  }
}
