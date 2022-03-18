import 'package:flutter/material.dart';
import 'package:not_ortalama/constants/app_constants.dart';
import 'package:not_ortalama/helper/data_helper.dart';

class KrediDropdownWidget extends StatefulWidget {
  final Function onKrediSecildi;
  const KrediDropdownWidget({required this.onKrediSecildi, Key? key }) : super(key: key);

  @override
  State<KrediDropdownWidget> createState() => _KrediDropdownState();
}

class _KrediDropdownState extends State<KrediDropdownWidget> {
  int secilenKredi = 4;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: Sabitler.dropdownPadding,
      decoration: BoxDecoration(
        color: Sabitler.anaRenk.shade100.withOpacity(0.3),
        borderRadius: Sabitler.radius,
      ),
      child: DropdownButton<int>(
        iconEnabledColor: Sabitler.anaRenk,
        value: secilenKredi,
        items: DataHelper.tumKredilerinKredileri(),
        onChanged: (deger){
          setState(() {
            secilenKredi = deger!;
            widget.onKrediSecildi(secilenKredi);
          });
        },
        underline: Container(),
      ),
    );
  }
}