import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/utils.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../data/model/browser/browser_tab.dart';
import '../../../domain/controller/bottom_navbar_controller.dart';
import '../../../domain/controller/browser_controller.dart';
import '../../../domain/controller/dapp_controller.dart';
import '../../../domain/controller/evm_new_controller.dart';
import '../dapps/new_dapps.dart';
import '../dapps/search_dapps.dart';

class ExplorerPage extends StatelessWidget {
  ExplorerPage({super.key});
  final BottomNavBarController controller = Get.find();
  final EvmNewController evm = Get.find();
  final BrowserController browserController = Get.put(BrowserController());
  final DappsController web3 = Get.put(DappsController());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Theme.of(context).dialogBackgroundColor,
        body: SafeArea(
          child: Obx(
            () => controller.isTabClicked.value
                ? _widgetSelectTab()
                : Column(
                    children: [
                      Expanded(
                        child: DappsWeb3(
                          initialUrl: web3.selectedTab().url ??
                              evm.selectedChain.value
                                  .explorer ??
                              "https://www.google.com/",
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            color: Theme.of(context).cardColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    web3.webController.goBack();
                                  },
                                  icon: const Icon(Icons.arrow_back_ios)),
                              IconButton(
                                  onPressed: () {
                                    web3.webController.goForward();
                                  },
                                  icon: const Icon(Icons.arrow_forward_ios)),
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => SearchDapps(),
                                        transition: Transition.downToUp);
                                  },
                                  icon: const Icon(Icons.search)),
                              GestureDetector(
                                onTap: () async {
                                  final image = await web3.screenshotTab();
                                  await web3.onChangeEventTab(
                                      web3.selectedTab().copyWith(
                                            image: image,
                                          ));
                                  await web3.loadTabs();
                                  controller.selectTab(true);
                                },
                                child: Container(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 6),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: Theme.of(context).indicatorColor,
                                      width: 2,
                                    ),
                                  ),
                                  child: Text(
                                      web3.listBrowserTab.length.toString()),
                                ),
                              ),
                              // IconButton(
                              //     onPressed: () async {
                              //       final image = await web3.screenshotTab();
                              //       await web3.onChangeEventTab(
                              //           web3.selectedTab().copyWith(
                              //                 image: image,
                              //               ));
                              //       await web3.loadTabs();
                              //       controller.selectTab(true);
                              //     },
                              //     icon: Icon(Icons.tab)),
                              IconButton(
                                  onPressed: () {
                                    //  web3.browserController.
                                    web3.loadUrl(evm
                                            .selectedChain.value.explorer ??
                                        "https://www.google.com");
                                  },
                                  icon: const Icon(
                                    Icons.home,
                                    size: 28,
                                  )),
                              PopupMenuButton(
                                icon: Icon(
                                  Icons.more_horiz,
                                  color: Theme.of(context).indicatorColor,
                                ),
                                shadowColor: Colors.transparent,
                                offset: Offset(0,
                                    -MediaQuery.of(context).size.width / 1.9),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                    color: AppColor.primaryColor,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                itemBuilder: (context) {
                                  return [
                                    PopupMenuItem(
                                      onTap: () async {
                                        await web3.addTab(BrowserTab(
                                            isSelected: true,
                                            name: "New Tab",
                                            url: evm
                                                    
                                                    .selectedChain
                                                    .value
                                                    .explorer ??
                                                "https://www.google.com"));
                                        web3.loadUrl(web3.selectedTab().url);
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.add,
                                            color: AppColor.primaryColor,
                                          ),
                                          8.0.width,
                                          Text(
                                            'New Tab',
                                            style: AppFont.medium14.copyWith(
                                                color: AppColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        web3.webController.reload();
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.refresh,
                                            color: AppColor.primaryColor,
                                          ),
                                          8.0.width,
                                          Text(
                                            'Reload',
                                            style: AppFont.medium14.copyWith(
                                                color: AppColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () {
                                        Share.share(
                                          web3.selectedTab().url ?? "",
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.share,
                                            color: AppColor.primaryColor,
                                          ),
                                          8.0.width,
                                          Text(
                                            'Share',
                                            style: AppFont.medium14.copyWith(
                                                color: AppColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                    PopupMenuItem(
                                      onTap: () async {
                                        if (!await launchUrl(
                                            Uri.parse(web3.selectedTab().url!),
                                            mode: LaunchMode
                                                .externalApplication)) {
                                          throw Exception('Could not launch ');
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          const Icon(
                                            Icons.open_in_full,
                                            color: AppColor.primaryColor,
                                          ),
                                          8.0.width,
                                          Text(
                                            'Open in browser',
                                            style: AppFont.medium14.copyWith(
                                                color: AppColor.primaryColor),
                                          )
                                        ],
                                      ),
                                    ),
                                  ];
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller.isLoadExplorer.value
                          ? Center(
                              child: CupertinoActivityIndicator(
                                radius: 20.r,
                                color: Theme.of(context).primaryColor,
                              ),
                            )
                          : const SizedBox(),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Widget _widgetSelectTab() {
    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: ListView.builder(
            itemCount: web3.listBrowserTab.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: () async {
                await web3.changeTab(web3.listBrowserTab[index]);
                controller.selectTab(false);
              },
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 8),
                height: 250.w,
                decoration: BoxDecoration(
                  border: web3.listBrowserTab[index].isSelected!
                      ? Border.all(color: AppColor.primaryColor, width: 4)
                      : Border.all(
                          color: Colors.white,
                        ),
                  color: Colors.white,
                  image: web3.listBrowserTab[index].image == null
                      ? null
                      : DecorationImage(
                          fit: BoxFit.cover,
                          image: MemoryImage(web3
                              .getImageTab(web3.listBrowserTab[index].image!))),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: const BoxDecoration(
                          color: Colors.black87,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(4),
                              topRight: Radius.circular(4))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              "${web3.listBrowserTab[index].name}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: AppFont.medium14
                                  .copyWith(color: Colors.white),
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                controller.selectTab(false);
                                web3.closeTabs(web3.listBrowserTab[index].id!);
                              },
                              icon: const Icon(
                                Icons.close,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  await web3.closeAllTab();
                  controller.selectTab(false);
                },
                child: Text(
                  "Close all",
                  style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () async {
                  await web3.addTab(BrowserTab(
                      isSelected: true,
                      name: "New Tab",
                      url: evm.selectedChain.value.explorer ??
                          "https://www.google.com"));
                  controller.selectTab(false);
                },
                child: Container(
                  height: 32.w,
                  width: 32.w,
                  decoration: const BoxDecoration(
                      color: AppColor.primaryColor, shape: BoxShape.circle),
                  child: const Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  controller.selectTab(false);
                },
                child: Text(
                  "Done",
                  style: AppFont.medium14.copyWith(color: AppColor.primaryColor),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
