import 'package:isar/isar.dart';
import 'package:mintsafe_wallet/data/model/chain_network/list_chain_selected.dart';
import 'package:mintsafe_wallet/data/model/chain_network/selected_chain.dart';
import 'package:mintsafe_wallet/data/model/token/selected_token.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/data.dart';
import '../../data/model/browser/browser_tab.dart';
import '../../data/model/nft/nft.dart';

class DbHelper {
  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  factory DbHelper() {
    return instance;
  }
  late Isar isar;

  void onInit() async {
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
      [
        PasswordSchema,
        AddressSchema,
        ChainNetworkSchema,
        TransactionHistorySchema,
        RecentAddressSchema,
        BrowserTabSchema,
        DappsHistorySchema,
        TokenSchema,
        SelectedTokenSchema,
        SelectedChainSchema,
        ListChainSelectedSchema,
        NftSchema,
      ],
      inspector: true,
      directory: dir.path,
    );
  }

  Future<void> setPassword(Password password) async {
    await isar.writeTxn(() async {
      await isar.passwords.put(password);
    });
  }

  Future<Password> getPassword() async {
    var password = Password();
    await isar.txn(() async {
      final pass = await isar.passwords.where().findAll();
      password = pass.first;
    });
    return password;
  }

  Future<void> addAddress(Address address) async {
    await isar.writeTxn(() async {
      await isar.address.put(address);
    });
  }

  Future<List<Address>?> getAllAddress() async {
    final List<Address> addressList = [];
    final allAddress =
        await isar.address.where(distinct: true, sort: Sort.asc).findAll();
    addressList.addAll(allAddress);
    return addressList;
  }

  Future<void> deleteAddress(int id) async {
    await isar.writeTxn(() async {
      await isar.address.delete(id);
    });
  }

  Future<void> changeWallet(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.address.get(id);
      add!.selectedAddress = true;
      await isar.address.put(add);
    });
  }

  Future<void> unSelectWallet(int id) async {
    await isar.writeTxn(() async {
      final add = await isar.address.get(id);
      add!.selectedAddress = false;
      await isar.address.put(add);
    });
  }

  Future<Address?> getSelectedWallet() async {
    final address =
        await isar.address.filter().selectedAddressEqualTo(true).findFirst();
    return address;
  }

// ############           Network       ####################//
  Future<void> setSelectedChain(SelectedChain chain) async {
    await isar.writeTxn(() async {
      await isar.selectedChains.put(chain);
    });
  }

  Future<SelectedChain> getSelectedChain() async {
    List<SelectedChain> listChain = [];
    await isar.txn(() async {
      listChain = await isar.selectedChains.where().findAll();
    });
    if (listChain.isNotEmpty) {
      return listChain.first;
    } else {
      return SelectedChain();
    }
  }

  Future<void> setChainNetwork(List<ChainNetwork> networks) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.putAll(networks);
    });
  }

  Future<void> changeNetwork(ListChainSelected chain) async {
    final selectedChain = await isar.selectedChains.where().findAll();
    await isar.writeTxn(() async {
      selectedChain.first.chainId = chain.chainId;
      await isar.selectedChains.put(selectedChain.first);
    });
  }

  // Future<void> unSelectNetwork(int id) async {
  //   await isar.writeTxn(() async {
  //     final add = await isar.chainNetworks.get(id);

  //     add!.selected = false;
  //     await isar.chainNetworks.put(add);
  //   });
  // }

  Future<List<ChainNetwork>> getAllChainNetwork() async {
    List<ChainNetwork> networks = [];
    await isar.txn(() async {
      networks = await isar.chainNetworks.where().findAll();
    });

    return networks;
  }

  Future<ListChainSelected?> getSelectedChainNetwork() async {
    final selectedChain = await isar.selectedChains.where().findAll();
    final chain = await isar.listChainSelecteds
        .filter()
        .chainIdEqualTo(selectedChain.first.chainId)
        .findFirst();
    return chain;
  }

  Future<void> addChainNetwork(ChainNetwork network) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.put(network);
    });
  }

  Future<void> editChainNetwork(ChainNetwork network) async {
    await isar.writeTxn(() async {
      final item = await isar.chainNetworks.get(network.id!);
      item!.chainId = network.chainId;
      item.name = network.name;
      item.rpc = network.rpc;
      item.symbol = network.symbol;
      item.explorer = network.explorer;
      item.logo = network.logo;
      item.color = network.color;
      await isar.chainNetworks.put(item);
    });
  }

  Future<void> deleteChainNetwork(int id) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.delete(id);
    });
  }

  Future<void> deleteAllChainNetwork(List<int> id) async {
    await isar.writeTxn(() async {
      await isar.chainNetworks.deleteAll(id);
    });
  }

  Future<void> updateWallet(int id, double balance) async {
    await isar.writeTxn(() async {
      final address = await isar.address.get(id);
      if (address != null) {
        address.balance = balance;
        await isar.address.put(address);
      }
    });
  }

  Future<List<Address>?> readAddressList() async {
    final List<Address> addressList = [];
    final allAddress =
        await isar.address.where(distinct: true, sort: Sort.asc).findAll();

    addressList.addAll(allAddress);

    return addressList;
  }

  Future<List<RecentAddress>> getRecentAddress() async {
    List<RecentAddress> list = [];
    await isar.txn(() async {
      list = await isar.recentAddress.where().findAll();
    });

    return list;
  }

  Future<void> setToken(List<Token> tokens) async {
    await isar.writeTxn(() async {
      await isar.tokens.putAll(tokens);
    });
  }

  Future<List<Token>> getAllTokens() async {
    List<Token> token = [];
    await isar.txn(() async {
      token = await isar.tokens.where().findAll();
    });
    return token;
  }

  Future<List<Token>> getListTokenByChainId({
    required String chainId,
  }) async {
    final tokens = await isar.tokens.filter().chainIdEqualTo(chainId).findAll();
    return tokens;
  }

  /// ######################### TOKEN #######################
  Future<List<SelectedToken>> getSelectedToken(
      {required String walletAddress, required String chainID}) async {
    List<SelectedToken> tokens = [];
    await isar.txn(() async {
      tokens = await isar.selectedTokens
          .filter()
          .walletAddressEqualTo(walletAddress)
          .chainIdEqualTo(chainID)
          .findAll();
    });
    return tokens;
  }

  Future<void> selectToken(SelectedToken token) async {
    await isar.writeTxn(() async {
      final result = await isar.selectedTokens.get(token.id!);
      result!.selected = token.selected;
      await isar.selectedTokens.put(result);
    });
  }

  Future<void> changeSelectedToken(SelectedToken token) async {
    await isar.writeTxn(() async {
      await isar.selectedTokens.put(token);
    });
  }

  Future<void> deleteSelectedToken(String contract) async {
    final token = await isar.selectedTokens
        .filter()
        .contractAddressEqualTo(contract)
        .findFirst();
    await isar.writeTxn(() async {
      await isar.selectedTokens.delete(token?.id ?? 0);
    });
  }

  /// ######################### Chain #######################
  Future<List<ListChainSelected>> getSelectedChainWallet(
      {required String walletAddress}) async {
    List<ListChainSelected> chains = [];
    await isar.txn(() async {
      chains = await isar.listChainSelecteds
          .filter()
          .walletAddressEqualTo(walletAddress)
          .findAll();
    });
    return chains;
  }

  Future<void> setSelectedChainWallet(ListChainSelected chains) async {
    await isar.writeTxn(() async {
      await isar.listChainSelecteds.put(chains);
    });
  }

  Future<void> deleteSelectedChainWallet(String chainId) async {
    final chain = await isar.listChainSelecteds
        .filter()
        .chainIdEqualTo(chainId)
        .findFirst();
    await isar.writeTxn(() async {
      await isar.listChainSelecteds.delete(chain?.id ?? 0);
    });
  }

  /// ######################### NFT #######################
  Future<List<Nft>> getAllNFT(
      {required String chainId, required String owner}) async {
    List<Nft> tokens = [];
    await isar.txn(() async {
      tokens = await isar.nfts
          .where()
          .filter()
          .chainIdEqualTo(chainId)
          .ownerEqualTo(owner)
          .findAll();
    });
    return tokens;
  }

  Future<void> addAllNFT(List<Nft> nft) async {
    await isar.writeTxn(() async {
      await isar.nfts.putAll(nft);
    });
  }

  Future<void> addNFT(Nft nft) async {
    await isar.writeTxn(() async {
      await isar.nfts.put(nft);
    });
  }

  Future<void> deleteNFT(int id) async {
    await isar.writeTxn(() async {
      await isar.nfts.delete(id);
    });
  }

  Future<void> deleteAllNft() async {
    await isar.writeTxn(() async {
      await isar.nfts.clear();
    });
  }

  // Dapps History


  Future<List<DappsHistory>> getDappsHistory() async {
    List<DappsHistory> list = [];
    await isar.txn(() async {
      list = await isar.dappsHistorys.where().findAll();
    });

    return list;
  }

  Future<void> addHistoryDapps(DappsHistory history) async {
    await isar.writeTxn(() async {
      await isar.dappsHistorys.put(history);
    });
  }

  Future<void> deleteDappsHistory(int id) async {
    await isar.writeTxn(() async {
      await isar.dappsHistorys.delete(id);
    });
  }


  ///// BROWSER TAB
  ///
  Future<List<BrowserTab>> getAllBrowserTab() async {
    var list = <BrowserTab>[];
    await isar.txn(() async {
      list = await isar.browserTabs.where().findAll();
    });

    return list;
  }

  Future<void> addBrowserTab(BrowserTab tab) async {
    await isar.writeTxn(() async {
      await isar.browserTabs.put(tab);
    });
  }

  Future<void> deleteBrowserTab(int id) async {
    await isar.writeTxn(() async {
      await isar.browserTabs.delete(id);
    });
  }

  onTabStateChanged(BrowserTab tab) async {
    await isar.writeTxn(() async {
      var tabs = await isar.browserTabs.get(tab.id!);
      tabs!.isSelected = tab.isSelected;
      tabs.name = tab.name;
      tabs.url = tab.url;
      tabs.image = tab.image;

      await isar.browserTabs.put(tabs);
    });
  }

  Future<void> changeBrowserTab(BrowserTab tab) async {
    await isar.writeTxn(() async {
      var tabs = await isar.browserTabs.where().findAll();
      for (var element in tabs) {
        element.isSelected = false;
      }

      await isar.browserTabs.putAll(tabs);
      final selectedTab = await isar.browserTabs.get(tab.id!);
      selectedTab!.isSelected = true;
      selectedTab.name = tab.name ?? "";
      selectedTab.url = tab.url ?? "";

      isar.browserTabs.put(selectedTab);
    });
  }

  Future<void> closeAllBrowserTab() async {
    await isar.writeTxn(() async {
      await isar.browserTabs.clear();
    });
  }

}
