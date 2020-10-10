import 'package:flutter/cupertino.dart';
import 'package:news/common/utils/utils.dart';
import 'package:news/common/values/values.dart';

import 'common/entity/entitys.dart';

/// 全局配置
class Global {
  /// 用户配置
  static UserLoginResponseEntity profile = UserLoginResponseEntity(
    accessToken: null,
  );

  /// 是否 release
  static bool get isRelease => bool.fromEnvironment("dart.vm.product");

  /// init
  static Future init() async {
    //运行初始
    WidgetsFlutterBinding.ensureInitialized();

    //工具开始
    await StorageUtil.init();
    HttpUtil();

    // 读取离线用户信息
    var _profileJSON = StorageUtil().getJSON(STORAGE_USER_PROFILE_KEY);
    if (_profileJSON != null) {
      profile = UserLoginResponseEntity.fromJson(_profileJSON);
    }

    //http 缓存

    // android 状态栏为透明的沉浸
    // if(Platform.isAndroid){
    //   SystemUiOverlayStyle systemUiOverlayStyle =
    //       SystemUiOverlayStyle(statusBarColor:Colors.transparent);
    //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    // }
  }

  // 持久化 用户信息
  static Future<bool> saveProfile(UserLoginResponseEntity userResponse) {
    profile = userResponse;
    return StorageUtil()
        .setJson(STORAGE_USER_PROFILE_KEY, userResponse.toJson());
  }
}
