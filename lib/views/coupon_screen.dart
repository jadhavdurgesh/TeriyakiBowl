import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:teriyaki_bowl_app/utils/utils.dart';
import 'package:teriyaki_bowl_app/views/common/custom_button.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:flutter/services.dart';
import '../utils/colors.dart';

class CouponScreen extends StatefulWidget {
  final data;

  const CouponScreen({super.key, required this.data});

  @override
  State<CouponScreen> createState() => _CouponScreenState();
}

class _CouponScreenState extends State<CouponScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: primaryColor,
        ),
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          "Select Promo Code",
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: primaryColor,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back,
            size: 32,
            color: primaryColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: ListView.builder(
            itemCount: widget.data['code_list'].length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(
                decelerationRate: ScrollDecelerationRate.fast),
            itemBuilder: (BuildContext context, index) {

              var couponSnap = widget.data[widget.data['code_list'][index]];

              return Container(
                decoration: BoxDecoration(
                  color: lightColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.shade200,
                      offset: const Offset(0, 1),
                      blurRadius: 1,
                      spreadRadius: 2,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text("${couponSnap['coupon_name']}",
                              style: const TextStyle(
                                color: primaryColor,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                          ),
                          CustomButton(
                              btnText: "Copy",
                              paddingV: 8,
                              paddingH: 16,
                              onTap: () async {
                                await Clipboard.setData(ClipboardData(text: "${couponSnap['cid']}"));

                                showSnackBar("Promocode copied successfully!", context);
                              },
                          )
                        ],
                      ),
                      Text("${couponSnap['cid']}",
                        style: const TextStyle(
                            fontSize: 16,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      12.heightBox,
                      Text("${couponSnap['coupon_desc']}",
                        style: const TextStyle(
                            fontSize: 13,
                          color: textDarkColor
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
