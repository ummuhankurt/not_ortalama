import 'package:flutter/material.dart';
import 'package:not_ortalama/Model/ders.dart';
import 'package:not_ortalama/constants/app_constants.dart';
import 'package:not_ortalama/helper/data_helper.dart';

class DersListesi extends StatelessWidget {
  final Function onElemanCikarildi;
  const DersListesi({required this.onElemanCikarildi, Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Ders> tumDersler = DataHelper.tumEklenenDersler;
    return tumDersler.length > 0 ? ListView.builder(
      itemCount:tumDersler.length,
      itemBuilder: (context,index){
        return Dismissible(
          key: UniqueKey(), // Listenize eklenen her elemana birbirinden farklı keyler atar.
          direction: DismissDirection.startToEnd,
          onDismissed: (a){
            onElemanCikarildi(index);
          },
          child: Padding(
            padding: EdgeInsets.all(2),
            child: Card(
              child: ListTile(
                title: Text(tumDersler[index].ad),
                leading: CircleAvatar(
                  backgroundColor: Sabitler.anaRenk,
                  child: Text((tumDersler[index].harfDegeri * tumDersler[index].krediDegeri).toStringAsFixed(2)),
                ),
                subtitle: Text("${tumDersler[index].krediDegeri} Kredi , Harf Değeri :${tumDersler[index].harfDegeri}"),
              ),
            ),
          ),
        );
      }
      ) : 
      Container(
        child: Center(child: Text("Lütfen ders ekleyin",style: Sabitler.baslikStyle,)),
      );
  }
}