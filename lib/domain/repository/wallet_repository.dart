import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:ethereum_addresses/ethereum_addresses.dart';
import 'package:web3dart/web3dart.dart';

class WalletRepository {
  WalletRepository._constructor();

  static final WalletRepository _instance = WalletRepository._constructor();

  factory WalletRepository() => _instance;

  String generateMnemonic() {
    var mnemonic = bip39.generateMnemonic();
    return mnemonic;
  }

  bool validateMnemonic(String mnemonic) {
    return bip39.validateMnemonic(mnemonic);
  }

  Map<String, String> getAccountInfo(String mnemonic) {
    var seed = bip39.mnemonicToSeedHex(mnemonic);

    Chain chain = Chain.seed(seed);
    ExtendedKey key = chain.forPath("m/44'/60'/0'/0/0");
    var privateKey = key.privateKeyHex();
    Credentials account = EthPrivateKey.fromHex(privateKey);
    var encodedPrivateKey = privateKey.replaceRange(0, 2, "0x");

    return {
      'mnemonic': mnemonic,
      'private_key': encodedPrivateKey,
      'address': account.address.toString()
    };
  }

  bool validatePrivateKey(String privateKey) {
    var credential = EthPrivateKey.fromHex(privateKey);
    EthereumAddress address = credential.address;
    if (isValidEthereumAddress(address.hex)) {
      return true;
    } else {
      return false;
    }
    // final decodedKey = base64Url.decode(privateKey);
    // final hash = sha256.convert(decodedKey);
    // final firstByte = hash.bytes[0];
    // return firstByte <= 0x7f;
  }
}