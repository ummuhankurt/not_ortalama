import 'package:flutter/material.dart';
import 'package:not_ortalama/Model/ders.dart';
import 'package:not_ortalama/constants/app_constants.dart';
import 'package:not_ortalama/helper/data_helper.dart';
import 'package:not_ortalama/widgets/ders_listesi.dart';
import 'package:not_ortalama/widgets/harf_dropdown.dart';
import 'package:not_ortalama/widgets/kredi_dropdown.dart';
import 'package:not_ortalama/widgets/ortalama_goster.dart';
class OrtalamaHesaplaApp extends StatefulWidget {
  const OrtalamaHesaplaApp({ Key? key }) : super(key: key);

  @override
  State<OrtalamaHesaplaApp> createState() => _OrtalamaHesaplaAppState();
}

class _OrtalamaHesaplaAppState extends State<OrtalamaHesaplaApp> {
  double secilenDeger = 4;
  int secilenKredi = 4;
  String girilenDersAdi = "";
  GlobalKey<FormState> formKey = GlobalKey<FormState>(); // Formun statine ulaşmak için bu anahtar kuullanılacak.
  @override
  Widget build(BuildContext context) {
    print("Scaffold çalıştı");
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(Sabitler.baslikText,style: Sabitler.baslikStyle,),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //form
          Row(
            children: [
              Expanded(
                flex: 2,
                child: _buidForm(),
              ),
              Expanded(
                flex: 1,
                child: OrtalamaGoster(dersSayisi: DataHelper.tumEklenenDersler.length,ortalama: DataHelper.ortalamaHesapla()),
              )
            ],
          ),
          //liste
          Expanded(
            child: DersListesi(
              onElemanCikarildi: (index){
                DataHelper.tumEklenenDersler.removeAt(index);
                setState(() {
                  
                });
              },
            )
          )
        ],
      )
    );
  }

 Widget _buidForm() {
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: Sabitler.yatay8,
            child: _buildtextFormField()),
            SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Padding(padding: Sabitler.yatay8,
                child: HafrDropdownWidget(
                  onHarfSecildi: (harf){
                    secilenDeger = harf;
                  },
                ),),
              ),
                Expanded(
                  child: Padding(padding: Sabitler.yatay8,
                  child:  KrediDropdownWidget(
                    onKrediSecildi: (kredi){
                      secilenKredi = kredi;
                    }
                    ),),
                ),
                 IconButton(
                onPressed: (){
                  _dersEkleVeOrtalamaHesapla();
                },
                icon: Icon(Icons.arrow_forward_ios_sharp,
                color: Sabitler.anaRenk,
                size: 30,)
                 )
            ],
          ),
          SizedBox(height: 8,),
        ],
      ),
    );
  }

 TextFormField _buildtextFormField() {
   return TextFormField(
     onSaved: (deger){
       setState(() {
         girilenDersAdi = deger!;
       });
     },
     validator: (s){
       if(s!.length <= 0){
         return "Ders Adını Giriniz";
       }
       else return null;
     },
     decoration: InputDecoration(
       hintText: "Matematik",
       border:  OutlineInputBorder(
         borderRadius: Sabitler.radius,
         borderSide: BorderSide.none
       ), 
       filled: true,
       fillColor: Sabitler.anaRenk.shade100.withOpacity(0.2)
     ),
   );
 }

 
  _buildKrediler() {
    
  }

  void _dersEkleVeOrtalamaHesapla() {
    if(formKey.currentState!.validate()){
      formKey.currentState!.save();
      var eklenecekDers = Ders(ad: girilenDersAdi, harfDegeri: secilenDeger, krediDegeri: secilenKredi);
      DataHelper.dersEkle(eklenecekDers);
      setState(() {
        
      });
    }
  }
}
