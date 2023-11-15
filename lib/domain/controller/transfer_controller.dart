import 'dart:developer' as dev;
import 'dart:math';

import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/helper/db_helper.dart';

import '../../data/data.dart';

class Transfercontroller extends GetxController {
  final SelectedToken? token;
  Transfercontroller({this.token});
  var selectedTab = 0.obs;
  EvmNewController evm = Get.find();
  var toRecent = false.obs;
  var transferLoading = false.obs;
  var addressController = TextEditingController();
  var amountController = TextEditingController();
  var isValidate = false.obs;
  var isLoading = false.obs;
  var totalAmount = 0.0.obs;
  var networkFee = 0.0.obs;
  var networkFeeSlow = 0.0.obs;
  var networkFeeAverage = 0.0.obs;
  var networkFeeFast = 0.0.obs;
  var selectedFee = 0.obs;
  var selectedIndexFee = 1.obs;
  var isAmountValid = false.obs;
  var useMax = false.obs;
  var buttonNext = true.obs;
  var gasLimitController = TextEditingController();
  var gasPriceController = TextEditingController();
  var tabGasFee = 0.obs;
  var amountInput = 0.0.obs;
  var buttonInputAmount = true.obs;
  var selectedToken = SelectedToken().obs;
  var tokenSelectInList = SelectedToken().obs;
  var isValidAddressSent = false.obs;

  void changeTab(int index) => selectedTab.value = index;

  @override
  void onInit() {
    if (token != null) {
      selectedToken.value = token!;
      tokenSelectInList.value = token!;
    }
    super.onInit();
  }

  void changeFee(int index) => selectedFee.value = index;
  void changeIndexFee(int index) => selectedIndexFee.value = index;

  // checkAddress(String value) {
  //   if (value.isEmpty) {
  //     alert("Address can't empty");
  //   } else if (!isValidEthereumAddress(value)) {
  //     alert("Invalid address");
  //   } else {
  //     setRecent(false);
  //     Get.to(() => InputAmountScreen(asset: null,));
  //   }
  // }

  checkButtonNext() {
    if (addressController.text != '' && isValidAddressSent.value == true) {
      buttonNext.value = false;
    } else {
      buttonNext.value = true;
    }
  }

  checkButtonInput() {
    if (amountController.text != '' && isValidate.value == true) {
      buttonInputAmount.value = false;
    } else {
      buttonInputAmount.value = true;
    }
  }

  checkAddressSent(String value) {
    isValidAddressSent.value = isValidEthereumAddress(value);
    checkButtonNext();
  }

  // nextSentPage() {
  //   setRecent(false);
  //   Get.to(() => SentToPage());
  // }

  selectToken(SelectedToken token) {
    tokenSelectInList.value = token;
  }

  cofirmToken() {
    selectedToken.value = tokenSelectInList.value;
    validateAmount();
    Get.back();
  }

  setAddressSent(Address address) {
    addressController.text = address.address ?? "";
    checkAddressSent(address.address ?? "");
  }

  void checkAmountValid() {
    double amount = double.tryParse(amountController.text) ?? 0;
    var total = 0.0;
    if (selectedToken.value.contractAddress == null) {
      total = amount + networkFee.value;
    } else {
      total = amount;
    }

    if (selectedToken.value.contractAddress == null) {
      if (total <= evm.balanceEth.value) {
        isAmountValid.value = true;
        print("total : $total");
        print("is valid amount");
      } else {
        isAmountValid.value = false;
        print("total : $total");
        print("is invalid");
      }
    } else {
      if (total <= selectedToken.value.balance!) {
        isAmountValid.value = true;
        print("total : $total");
        print("is valid amount");
      } else {
        isAmountValid.value = false;
        print("total : $total");
        print("is invalid");
      }
    }

    if (useMax.isTrue) {
      final total = amountInput.value + networkFee.value;
      if (total == evm.balanceEth.value) {
        isAmountValid.value = true;
      }
    }
  }

  setUseMax() {
    useMax.value = true;
    isValidate.value = true;
  }

  unSetUseMax() => useMax.value = false;

  Future<void> getTotalAmount() async {
    networkFee.value = 0;
    double amount = double.parse(
        amountController.text.isEmpty ? "0.0" : amountController.text);
    double fee = 0.0;

    if (selectedToken.value.contractAddress == null) {
      fee = await evm.getEstimateGasFee(
          to: addressController.text, amount: amount);
    } else {
      fee = await evm.getEstimateGasTokenTransfer(
          contractAddress: selectedToken.value.contractAddress!,
          to: addressController.text,
          decimal: selectedToken.value.decimal ?? 18,
          amount: 0);
    }

    networkFee.value = fee;

    networkFeeAverage.value = fee;
    networkFeeSlow.value = fee - (fee * 0.33);
    networkFeeFast.value = fee + (fee * 0.33);
    if (useMax.isFalse) {
      if (selectedToken.value.contractAddress == null) {
        totalAmount.value = amount + fee;
      } else {
        totalAmount.value = amount;
      }
      amountInput.value = double.parse(
          amountController.text.isEmpty ? "0.0" : amountController.text);
    } else {
      if (selectedToken.value.contractAddress == null) {
        final totalSentBalance = amount - networkFee.value;

        amountInput.value = totalSentBalance;
        totalAmount.value = totalSentBalance + networkFee.value;
      } else {
        final totalSentBalance = amount - networkFee.value;

        amountInput.value = amount;
        totalAmount.value = totalSentBalance + networkFee.value;
      }
    }
dev.log("Get total amount===>");
  }

  Future<void> getNetworkFee() async {
    if (selectedToken.value.contractAddress == null) {
      networkFee.value =
          await evm.getEstimateGasFee(to: addressController.text, amount: 0);
    } else {
      networkFee.value = await evm.getEstimateGasTokenTransfer(
          contractAddress: selectedToken.value.contractAddress!,
          to: addressController.text,
          decimal: selectedToken.value.decimal ?? 18,
          amount: 0);
    }

    gasLimitController.text = evm.gasLimit.value.toString();
    gasPriceController.text = evm.gasPrice.value.ceilToDouble().toString();
  }

  // Future<void> getGasPriceAndLimit() async {}

  void useMaxAmount() async {
    setUseMax();
    var balance = 0.0;

    if (useMax.value) {
      if (selectedToken.value.contractAddress == null) {
        balance = evm.balanceEth.value;
      } else {
        balance = selectedToken.value.balance ?? 0;
      }
    }

    amountController.text = balance.toString();
    amountInput.value = balance;
    changeTotalAmount(balance);
    checkButtonInput();
  }

  void saveFee() {
    if (selectedIndexFee.value == 0) {
      networkFee.value = networkFeeSlow.value;
    } else if (selectedIndexFee.value == 1) {
      networkFee.value = networkFeeAverage.value;
    } else {
      networkFee.value = networkFeeFast.value;
    }

    if (selectedFee.value == 1) {
      networkFee.value = (double.parse(gasLimitController.text) *
              double.parse(gasPriceController.text)) /
          pow(10, 9);
    }

    if (selectedToken.value.contractAddress == null) {
      totalAmount.value = amountInput.value + networkFee.value;
    } else {
      totalAmount.value = amountInput.value;
    }
  }

  changeTotalAmount(double amount) {
    if (useMax.isFalse) {
      if (selectedToken.value.contractAddress == null) {
        totalAmount.value = amount + networkFee.value;
      } else {
        totalAmount.value = amount;
      }
      amountInput.value = double.parse(
          amountController.text.isEmpty ? "0.0" : amountController.text);
    } else {
      if (selectedToken.value.contractAddress == null) {
        final totalSentBalance = amount - networkFee.value;

        amountInput.value = totalSentBalance;
        totalAmount.value = totalSentBalance + networkFee.value;
      } else {
        final totalSentBalance = amount - networkFee.value;

        amountInput.value = amount;
        totalAmount.value = totalSentBalance + networkFee.value;
      }
    }
  }

  validateAmount() {
    double amount = double.tryParse(amountController.text) ?? 0;

    final tokenSelected = selectedToken.value.contractAddress == null
        ? evm.balanceEth.value
        : evm.tokenSelected
            .singleWhere((element) =>
                element.contractAddress ==
                    selectedToken.value.contractAddress &&
                element.walletAddress == selectedToken.value.walletAddress)
            .balance!;
    if (amount > tokenSelected) {
      isValidate.value = false;
    } else {
      isValidate.value = true;
    }

    if (amount == tokenSelected) {
      useMax.value = true;
    } else {
      useMax.value = false;
    }
    changeTotalAmount(amount);
    checkButtonInput();
  }

  void setRecent(bool value) => toRecent.value = value;

  Future<void> sendTransaction() async {
    try {
      transferLoading.value = true;
      if (selectedToken.value.contractAddress == null) {
        await evm.sendEth(
          to: addressController.text,
          amount: amountInput.value,
        );
      } else {
        await evm.transferToken(
            contractAddress: selectedToken.value.contractAddress!,
            to: addressController.text,
            token: selectedToken.value,
            amount: amountInput.value);
      }
      // await DbHelper.instance
      //     .saveRecentAddress(RecentAddress(address: addressController.text));

      evm.findAllActivity(isRefresh: true);
      evm.getEthBalancePeriodic();
      evm.getBalance();

      toRecent.value = false;
      transferLoading.value = false;
    } catch (e) {
      transferLoading.value = false;
      dev.log(e.toString());
    }
  }
}
