
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mintsafe_wallet/config/config.dart';
import 'package:mintsafe_wallet/utils/utils.dart';

import '../../../domain/controller/bottom_navbar_controller.dart';
import '../../../domain/controller/browser_controller.dart';
import '../../../domain/controller/dapp_controller.dart';

class SearchDapps extends StatelessWidget {
  SearchDapps({super.key});

  final BottomNavBarController controller = Get.put(BottomNavBarController());
  final BrowserController browserController = Get.put(BrowserController());
  final DappsController web3 = Get.find();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light, //,
      child: Obx(() {
        return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: PreferredSize(
                preferredSize: Size(AppBar().preferredSize.width,
                    AppBar().preferredSize.height + 100),
                child: SafeArea(
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                                autofocus: true,
                                controller: controller.initialUrl,
                                cursorHeight: 16.h,
                                style: AppFont.semibold14.copyWith(
                                  color: Theme.of(context).indicatorColor,
                                ),
                                onChanged: (value) =>
                                    controller.setSearch(value),
                                onEditingComplete: () {
                                  Get.back();
                                  // web3.loadUrl(controller.initialUrl.text);
                                  final uri =
                                      Uri.tryParse(controller.initialUrl.text);

                                  if (uri != null && uri.isAbsolute) {
                                    web3.webController.loadUrl(
                                        urlRequest: URLRequest(
                                            url: Uri.parse(
                                                controller.initialUrl.text)));
                                  } else {
                                    web3.webController.loadUrl(
                                        urlRequest: URLRequest(
                                            url: Uri.parse(
                                                "https://www.google.com/search?q=${controller.initialUrl.text}")));
                                  }

                                  controller.initialUrl.clear();
                                  // web3.webController.loadUrl(
                                  //     urlRequest: URLRequest(
                                  //         url: Uri.parse(
                                  //             "https://www.google.com/search?q=${controller.initialUrl.text}")));

                                  // web3.webController.reload();

                                  // if (controller.initialUrl.text.isNotEmpty) {
                                  //   Get.to(() => DappsWeb3(
                                  //       initialUrl:
                                  //           controller.initialUrl.text));
                                  // }
                                },
                                decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: Theme.of(context).indicatorColor,
                                  ),
                                  // suffixIcon: GestureDetector(
                                  //   onTap: () {
                                  //     controller.searchController.text = '';
                                  //   },
                                  //   child: Icon(
                                  //     Icons.close,
                                  //     color: Theme.of(context).indicatorColor,
                                  //   ),
                                  // ),

                                  hintText: "Search or enter website url",
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 0.h, horizontal: 24.w),
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide(
                                          width: 1.h,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide(
                                          width: 1.h,
                                          color:
                                              Theme.of(context).primaryColor)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(16.r),
                                      borderSide: BorderSide(
                                          width: 1.h,
                                          color:
                                              Theme.of(context).primaryColor)),
                                )),
                          ),
                          GestureDetector(
                            onTap: () => Get.back(),
                            child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Text(
                                  "Cancel",
                                  style: AppFont.medium12.copyWith(
                                      color: Theme.of(context).indicatorColor),
                                )),
                          )
                        ],
                      ),
                    ),
                  ),
                )),
            body: ListView.builder(
              itemCount: browserController.dappsHistory.length,
              itemBuilder: (context, index) {
                final item =
                    browserController.dappsHistory.reversed.toList()[index];
                return GestureDetector(
                  onTap: () {
                    Get.back();
                    // web3.loadUrl(controller.initialUrl.text);
                    final uri = Uri.tryParse(item.url!);

                    if (uri != null && uri.isAbsolute) {
                      web3.webController.loadUrl(
                          urlRequest: URLRequest(url: Uri.parse(item.url!)));
                    } else {
                      web3.webController.loadUrl(
                          urlRequest: URLRequest(
                              url: Uri.parse(
                                  "https://www.google.com/search?q=${item.url!}")));
                    }
                  },
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          Icons.public,
                          size: 24.w,
                        ),
                        12.0.width,
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                item.title ?? "",
                                maxLines: 1,
                                style: AppFont.medium12.copyWith(
                                    color: Theme.of(context).indicatorColor),
                              ),
                              Text(
                                item.url ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppFont.light10.copyWith(
                                    color: Theme.of(context).indicatorColor),
                              ),
                            ],
                          ),
                        ),
                      const  Spacer(),
                        GestureDetector(
                          onTap: () {
                            browserController.deleteDappsHistory(item.id!);
                          },
                          child: Icon(
                            Icons.close,
                            color: Theme.of(context).indicatorColor,
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ));
      }),
    );
  }
}
