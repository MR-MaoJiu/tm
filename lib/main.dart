import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'app/routes/app_pages.dart';
import 'generated/locales.g.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: LocaleKeys.text_tm.tr,
      translationsKeys: AppTranslation.translations,
      locale: const Locale('zh', 'CN'), // 将会按照此处指定的语言翻译
      fallbackLocale: const Locale('en', 'US'), // 添加一个回调语言选项，以备上面指定的语言翻译不存在
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
}
