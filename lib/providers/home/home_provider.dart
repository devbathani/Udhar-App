import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:udhar_app/domain/home/imp_home_repo.dart';
import 'package:udhar_app/domain/home/udhar_list_entity.dart';
import 'package:udhar_app/utils/logger.dart';

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

  //RazoryPay Setup
  Razorpay razorpay = Razorpay();
  void setupPay() {
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      // Do something when payment succeeds
      logger.i("Payment Done");
    });
    notifyListeners();
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      // Do something when payment fails
      logger.e("Payment Fail");
    });
    notifyListeners();
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET,
        (ExternalWalletResponse response) {
      // Do something when an external wallet is selected
    });
    notifyListeners();
  }

  payAmountToUser(int amount, String name, String phoneNumber) async {
    var options = {
      'key': "rzp_test_4qGWB3dkcHmRZT",
      'amount': amount * 100,
      'name': name,
      'description': 'service payment',
      'timeout': 300,
      'prefill': {
        'contact': phoneNumber,
      },
    };

    razorpay.open(options);
    notifyListeners();
  }
}
