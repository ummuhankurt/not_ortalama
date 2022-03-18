import 'package:flutter/material.dart';
import 'package:not_ortalama/constants/app_constants.dart';
import 'package:not_ortalama/helper/data_helper.dart';

class HafrDropdownWidget extends StatefulWidget {
  final Function onHarfSecildi;
  HafrDropdownWidget({required this.onHarfSecildi, Key? key}) : super(key: key);

  @override
  State<HafrDropdownWidget> createState() => _HafrDropdownWidgetState();
}

class _HafrDropdownWidgetState extends State<HafrDropdownWidget> {
  double secilenDeger = 4;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropdownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.radius
      ),
      child: DropdownButton<double>(
        value: secilenDeger,
        elevation: 16,
        iconEnabledColor: Sabitler.anaRenk.shade500,
        items: 
          DataHelper.tumDerslerinHarfleri(),
        onChanged: (deger){
          setState(() {
            secilenDeger = deger!;
            widget.onHarfSecildi(secilenDeger);
          });
        },
        underline: Container(),
      ),
    );
  }
}