import 'package:flutter/material.dart';
import 'package:healthy/models/doctor_info.dart';
import 'package:healthy/models/user-info.dart';
import 'package:healthy/presentation/pages/home/home_cards/doctor_card.dart';

class HomeDoctors extends StatelessWidget {
  final List<DoctorInfo> doctors;
  final UserInfo userInfo;

   const HomeDoctors({Key key, this.doctors, this.userInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      key: Key("doctors"),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(
          doctorInfo: doctors[index],
          userInfo: userInfo,
        );
      },
    );
  }
}
