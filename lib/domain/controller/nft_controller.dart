import 'dart:convert';

import 'dart:developer' as dev;
import 'dart:math';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/domain/controller/evm_new_controller.dart';
import 'package:mintsafe_wallet/utils/helper/helper.dart';

import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart' as http;

import '../../config/config.dart';
import '../../data/data.dart';
import '../../data/model/nft/nft.dart';


class NftController extends GetxController {
  EvmNewController evm = Get.find();
  final contractController = TextEditingController();
  final tokenIdController = TextEditingController();
  final addressController = TextEditingController();
  final gasLimitController = TextEditingController();
  final gasPriceController = TextEditingController();
  var isloading = false.obs;
  var isloadingTransfer = false.obs;
  var isValid = true.obs;
  var buttonNext = true.obs;
  var networkFee = 0.0.obs;
  var networkFeeSlow = 0.0.obs;
  var networkFeeAverage = 0.0.obs;
  var networkFeeFast = 0.0.obs;
  var gasLimit = 0.0.obs;
  var gasPrice = 0.0.obs;
  var selectedFee = 0.obs;
  var selectedIndexFee = 1.obs;
  var isValidAddressSent = false.obs;
  var isNextLoading = false.obs;

  void reset() {
    contractController.clear();
    tokenIdController.clear();
    isValid.value = true;
    isloading.value = false;
  }

  checkButtonNext() {
    if (addressController.text != '' && isValidAddressSent.value == true) {
      buttonNext.value = false;
    } else {
      buttonNext.value = true;
    }
  }

  setAddressSent(Address address) {
    addressController.text = address.address ?? "";
    checkAddressSent(address.address ?? "");
  }

  checkAddressSent(String value) {
    isValidAddressSent.value = isValidEthereumAddress(value);
    checkButtonNext();
  }

  void changeFee(int index) => selectedFee.value = index;
  void changeIndexFee(int index) => selectedIndexFee.value = index;
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
  }

  Future<void> fetchNFT(String contractAddress, int tokenId) async {
    try {
      isloading.value = true;
      if (!evm.listNFT.any((element) => element.tokenId == tokenId)) {
        final contract = DeployedContract(
          evm.erc721Abi!,
          EthereumAddress.fromHex(contractAddress),
        );
        final tokenURIFunction = contract.function('tokenURI');
        final tokenOwnerFunction = contract.function('ownerOf');
        final tokenSymbolFunction = contract.function('symbol');
        final tokenURI = await evm.web3client!.call(
            contract: contract,
            function: tokenURIFunction,
            params: [BigInt.from(tokenId)]);
        final tokenOwner = await evm.web3client!.call(
            contract: contract,
            function: tokenOwnerFunction,
            params: [BigInt.from(tokenId)]);
        final tokenSymbol = await evm.web3client!.call(
            contract: contract, function: tokenSymbolFunction, params: []);
        dev.log("token Uri => $tokenURI");
        dev.log("token Owner => $tokenOwner");
        dev.log("token Symbol => $tokenSymbol");
        String owner = (tokenOwner.first).toString();
        if (evm.selectedAddress.value.address == owner) {
          isValid.value = true;
          for (var uri in tokenURI) {
            if (uri.startsWith('ipfs://')) {
              final ipfsHash = uri.replaceFirst('ipfs://', '');
              final ipfsUrl = 'https://ipfs.io/ipfs/$ipfsHash';
              final response = await http.get(Uri.parse(ipfsUrl));
              dev.log(response.statusCode.toString());
              if (response.statusCode == 200) {
                final metadata = jsonDecode(response.body);
                final imageURL = metadata['image'];
                if (imageURL.startsWith('ipfs://')) {
                  final ipfsHash = imageURL.replaceFirst('ipfs://', '');
                  final ipfsImageURL =
                      'https://ipfs.io/ipfs/$ipfsHash'; // Use a public IPFS gateway
                  final imageResponse = await http.get(Uri.parse(ipfsImageURL));

                  if (imageResponse.statusCode == 200) {
                    final imageBytes = imageResponse.bodyBytes;
                    String imageBase64 = MethodHelper().convertUint8ListToString(imageBytes);
                    Nft nft = Nft(
                        contractAddress: contractAddress,
                        tokenId: tokenId,
                        name: metadata['name'],
                        owner: owner,
                        chainId:
                            evm.selectedChain.value.chainId,
                        imageByte: imageBase64,
                        description: metadata['description']);
                    await DbHelper.instance.addNFT(nft);
                  }
                } else {
                  final imageResponse = await http.get(Uri.parse(imageURL));
                  if (imageResponse.statusCode == 200) {
                    final imageBytes = imageResponse.bodyBytes;
                    String imageBase64 = MethodHelper().convertUint8ListToString(imageBytes);
                    Nft nft = Nft(
                        contractAddress: contractAddress,
                        tokenId: tokenId,
                        owner: owner,
                        chainId:
                            evm.selectedChain.value.chainId,
                        name: metadata['name'],
                        imageByte: imageBase64,
                        description: metadata['description']);
                    await DbHelper.instance.addNFT(nft);
                  }
                }
              }
            } else {
              final response = await http.get(Uri.parse(uri));
              if (response.statusCode == 200) {
                final metadata = jsonDecode(response.body);
                dev.log("token metadata => $metadata");
                final imageURL = metadata['image'];
                dev.log("Image  => $imageURL");
                if (imageURL.startsWith('ipfs://')) {
                  final ipfsHash = imageURL.replaceFirst('ipfs://', '');
                  final ipfsImageURL =
                      'https://ipfs.io/ipfs/$ipfsHash'; // Use a public IPFS gateway
                  final imageResponse = await http.get(Uri.parse(ipfsImageURL));

                  if (imageResponse.statusCode == 200) {
                    final imageBytes = imageResponse.bodyBytes;
                    String imageBase64 = MethodHelper().convertUint8ListToString(imageBytes);
                    Nft nft = Nft(
                        contractAddress: contractAddress,
                        tokenId: tokenId,
                        owner: owner,
                        chainId:
                            evm.selectedChain.value.chainId,
                        name: metadata['name'],
                        imageByte: imageBase64,
                        description: metadata['description']);
                    await DbHelper.instance.addNFT(nft);
                  }
                } else {
                  final imageResponse = await http.get(Uri.parse(imageURL));
                  if (imageResponse.statusCode == 200) {
                    final imageBytes = imageResponse.bodyBytes;
                    dev.log(imageBytes.toString());
                    String imageBase64 = MethodHelper().convertUint8ListToString(imageBytes);
                    dev.log("response image byte => $imageBase64");
                    Nft nft = Nft(
                        contractAddress: contractAddress,
                        tokenId: tokenId,
                        owner: owner,
                        chainId:
                            evm.selectedChain.value.chainId,
                        name: metadata['name'],
                        imageByte: imageBase64,
                        description: metadata['description']);
                    await DbHelper.instance.addNFT(nft);
                  }
                }
              }
            }
          }
          evm.initializeNFt();
          reset();
          Get.back();
        } else {
          isValid.value = false;
        }
        isloading.value = false;
      } else {
        Get.snackbar("Failed", "NFT has been added",
            backgroundColor: AppColor.yellowColor, colorText: Colors.white);
        isloading.value = false;
      }
    } catch (e) {
      isValid.value = false;
      isloading.value = false;
    }
  }

  Future<double> getEstimateGasNFTTransfer({
    required String to,
    required Nft nft,
  }) async {
    final credentials = EthPrivateKey.fromHex(evm.selectedPrivateKey.value);
    final contract = DeployedContract(
        evm.erc721Abi!, EthereumAddress.fromHex(nft.contractAddress!));
    final fromAddress = credentials.address;
    final gasprice = await evm.web3client!.getGasPrice();
    final transferFunction = contract.function('transferFrom');
    final transferParams = [
      EthereumAddress.fromHex(nft.owner!),
      EthereumAddress.fromHex(to),
      BigInt.from(nft.tokenId!)
    ];
    final transferData = transferFunction.encodeCall(transferParams);

    final gaslimit = await evm.web3client!.estimateGas(
      data: transferData,
      gasPrice: gasprice,
      to: EthereumAddress.fromHex(to),
      sender: fromAddress,
      value: EtherAmount.zero(),
    );
    gasLimit.value = gaslimit.toDouble();
    gasPrice.value =
        (gasprice.getInWei / BigInt.from(pow(10, 18))).ceilToDouble();

    final txFee = gasprice.getInWei * gaslimit;
    final fee = txFee / BigInt.from(10).pow(18);
    dev.log('Gas fee estimate: $fee wei');
    return fee;
  }

  Future<void> getNetworkFee({required Nft nft}) async {
    try {
      isNextLoading.value = true;
      final fee = await getEstimateGasNFTTransfer(
        nft: nft,
        to: addressController.text,
      );

      networkFee.value = fee;
      networkFeeAverage.value = fee;
      networkFeeSlow.value = fee - (fee * 0.33);
      networkFeeFast.value = fee + (fee * 0.33);
      gasLimitController.text = gasLimit.value.toString();
      gasPriceController.text = gasPrice.value.ceilToDouble().toString();

      isNextLoading.value = false;
    } catch (e) {
      isNextLoading.value = false;
      dev.log(e.toString());
    }
  }

  Future<void> transferNft({required String to, required Nft nft}) async {
    final contract = DeployedContract(
      evm.erc721Abi!,
      EthereumAddress.fromHex(nft.contractAddress ?? ''),
    );
    var credentials = EthPrivateKey.fromHex(evm.selectedPrivateKey.value);
    try {
      isloadingTransfer.value = true;
      Transaction transaction = Transaction.callContract(
        contract: contract,
        from: credentials.address,
        function: contract.function('transferFrom'),
        parameters: [
          EthereumAddress.fromHex(nft.owner!),
          EthereumAddress.fromHex(to),
          BigInt.from(nft.tokenId!)
        ],
        // maxGas: 100000, // Adjust the gas limit as needed
        // gasPrice: EtherAmount.inWei(BigInt.from(1000000000)),
      );

      final response = await evm.web3client!.sendTransaction(
          credentials, transaction,
          chainId:
              int.parse(evm.selectedChain.value.chainId!));
      dev.log("Transfer NFT Result : $response");
      await DbHelper.instance.deleteNFT(nft.id!);
      evm.initializeNFt();
      Get.snackbar("Success", "NFT has been sent",
          backgroundColor: AppColor.primaryColor,
          colorText: Colors.white);
      Get.close(4);

      isloadingTransfer.value = false;
    } catch (e) {
      isloadingTransfer.value = false;
    }
  }
}
