# tm 十米
##背景
tm十米，本来是打算开发一款线下社交APP的，是不是觉得很奇怪线下还要用APP？其实是这样的，设想一个场景，作为一个打工人，你朝九晚五挤地铁，突然一抬头看到了一个心动的小姐姐或者小哥哥，你很想要他联系方式，但是苦于内向，怎么办？这个时候你只需要打开软件（前提对方也得有这个APP）将会自动帮你匹配附近10米以内的小姐姐。。。是不是觉得很鸡肋？那是你不明白我们这些性格内向人的痛。。。。其实还有一个很好玩的玩法就是定点瞬间，具体的话自己了解，如果有同学想要一起开发的话就加入我吧.

##技术栈
前端：Flutter
后端：TP5
## 升级2.0并更换为GetX框架
### 文档参考

- [flutter起步](http://www.flutterchina.net.cn/guide/get-started/install.html)
- [GetX](https://hfybbs.gitee.io/flutter-getx-doc/engineer/start/)
- [GetX Cli](https://github.com/jonataslaw/get_cli/blob/master/README-zh_CN.md)
- [pub.dev](https://pub.flutter-io.cn/)
- [阿里图标库](https://www.iconfont.cn/)
- [图片资源路径生成插件](https://plugins.jetbrains.com/plugin/12585-flutter-img-sync)
- [代码规范参考](https://segmentfault.com/a/1190000019580511)
- [json转dart和Getx插件](https://plugins.jetbrains.com/plugin/16762-flutter-getx-starter)
- [json转dart网页](https://zmtzawqlp.gitee.io/jsontodart/#/)
### 快速搭建步骤
1. 配置好Flutter开发环境并安装常用插件例如：flutter-img-sync 参考文档图片资源路径生成插件，json转art和Getx插件
2. 创建flutter项目在根目录下面新建`assets/images/`目录将所有图片资源文件导入进去其他资源需要
   在`assets`下面新建相应目录。
3. 将lib下所有文件和pubspec.yaml文件复制到自己项目需要进行适当的修改 如果你已经执行了这一步那么第四步禁止使用否则会初始化项目的，第四步骤仅限于老鸟初始化自己项目使用
4. 使用`flutter pub global activate get_cli` 和`flutter pub global activate get_cli`命令安装并使用GetX Cli
5. 使用`get init`命令初始化GetX项目，慎重使用仅限老鸟。GetX Cli 已经帮我们初始化好了一个路由结构以及 home 子页面，这个实例是可以直接运行的。
   GetX Cli 将项目全部装进了 app 目录中，modules 存放页面，每个页面又分别存在 bindings，controllers，views
   它们分别负责的是：

* bindings：负责 controller 与 view 的耦合
* controller：负责响应式变量和非响应式变量的管理
* view：负责页面
  即 view 与 controller 是解耦的，通过 binding 进行耦合
6. 如果你执行的是步骤三那么你可以跳到步骤六如果你执行的步骤四那么你需要将lib->data和lib->shared文件进行复制并修改
   data文件包含了所有网络请求需要的文件shared包含了所有常量封装的小控件和工具类
7. 修复所有error 修复方法就是导包的问题建议全局修改包名
8. 使用`get create page:demo`自己需要的新建页面需要适当修改参考其他页面文件进行修改 （ps 如果命令没用请使用`pub global activate get_cli`）
9. 修改main方法相应文件参考main.dart
10. 修改接口地址：Base地址data->api->api_constants.dart
11. 修改接口方法：data->api->api_repository.dart
12. 公共接口调用方法（可以自定义单独接口）data->api->base_provider.dart
13. json解析 data->models 请求和返回需要分开写
14. 修改图标 `flutter pub run flutter_launcher_icons_maker:main`
## 代码规范
1. 变量命名采用驼峰
2. 公共组件或工具封装需要写下使用方法
3. 组件超过三处使用需要抽离成为公共方法
4. 业务逻辑中三处以上的判断尽量使用switch来判断条件使用枚举
5. 有需要后期修改的写一个todo
6. 公共组件或方法更新需要兼容当前旧版本，使用 @Deprecated注解标记下一个版本移除
7. 可以参考文档 代码规范参考
   -[官方代码规范](https://dart.dev/guides/language/effective-dart)
   -[阿里项目规范](https://github.com/alibaba/flutter-go/blob/master/Flutter_Go%20%E4%BB%A3%E7%A0%81%E5%BC%80%E5%8F%91%E8%A7%84%E8%8C%83.md)

