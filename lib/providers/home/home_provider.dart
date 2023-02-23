import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:udhar_app/domain/home/imp_home_repo.dart';
import 'package:udhar_app/domain/home/udhar_list_entity.dart';

@injectable
class HomeProvider extends ChangeNotifier {
  ImpHomeRepository repo;

  HomeProvider(this.repo);

  //Controllers
  final phoneNumberController = TextEditingController();
  final nameController = TextEditingController();
  final upiIdController = TextEditingController();
  final amountController = TextEditingController();

  //Entities
  UdharListEntity? udharListEntity;
  List<UdharListEntity>? udharList;

  //DropDown variables and funcs
  final List<String> udharType = ["Udhar Given", "Udhar Taken"];
  String selectedUdharType = 'Udhar Given';
  void setUdharType(value) {
    selectedUdharType = value;
    notifyListeners();
  }

  //Upload Udhar for User
  Future uploadUdhar() async {
    udharListEntity = UdharListEntity(
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
      upiId: upiIdController.text,
      amount: amountController.text,
      udharType: selectedUdharType,
    );
    await repo.uploadUdhar(udharListEntity: udharListEntity!);
    notifyListeners();
  }

  getUdharData() {
    repo.getUdharData().listen((event) {
      udharList = event;
      notifyListeners();
    });
  }
}
