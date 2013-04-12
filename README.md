MobileANE
=========

MobileANE是一个针对Adobe AIR移动设备功能扩展的项目，方便用户在AIR核心功能之外使用原生语言才能提供的功能。

目前已经实现的功能有：

1. sendSMS 发短信功能(支持iOS,Android)

1.如何使用
-------------------------------------

本目录已经包含了打包最终生成的ANE文件，即ane/MobileUtil.ane。如果您只是使用，不需要进行功能修改，可以
忽略下面的编译说明，将MobileUtil.ane拷贝到您的项目，进行引用即可。

在Flash Builder中添加的ANE，默认是不选中的（在ActionScript构建打包设置中），需要手动选择每一个平台，把勾打上，否则运行时会找不到类。

引用ANE后，Flash Builder会自动更新项目的XML描述文件，在extensions节点加入ANE的标识。如下：

        <extensions>
        <extensionID>com.techmx.ext.MobileUtil</extensionID>
        </extensions>

如果没有自动生成，则需要您手工添加。然后在您的AS代码里，即可使用ANE：

        import com.techmx.ext.MobileUtil;
        var mobileUtil:MobileUtil = new MobileUtil();
        mobileUtil.sendSMS("1000000","今天你吃饭了吗?");

2.如何编译
-------------------------------------

首先，无论您是Windows还是Mac系统，都要首先配置环境变量(PATH)，确保可以调用ADT命令。

配置方式参见Adobe的文档：
[http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-71994050128cca87097-8000.html](http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-71994050128cca87097-8000.html)

Windows下的ADT命令应该是这样的(可以新建一个文本文件，将以下命令粘入，保存为build.bat，执行)：

    adt -package -storetype PKCS12 -keystore appplatform.p12 -storepass 123456 -target ane MobileUtil.ane extension.xml -swc *.swc -platform Android-ARM -C .\Android-ARM\ . -platform default -C .\Default\ . 

Mac OSX下：

请执行ane/build.sh文件，具体方式，打开终端，输入：

    sudo sh {您的文件路径}/build.sh

稍等片刻，即可生成ANE文件

3.交流反馈
-------------------------------------

QQ群：231842868

4.参考资料
-------------------------------------

[http://www.adobe.com/devnet/air.html](http://www.adobe.com/devnet/air.html)
