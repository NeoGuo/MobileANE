MobileANE
=========

MobileANE是一个针对Adobe AIR移动设备功能扩展的项目，方便用户在AIR核心功能之外使用原生语言才能提供的功能。

目前已经实现的功能有：

1. sendSMS 发短信功能(iOS,Android)

1.如何使用
-------------------------------------

本目录已经包含了打包最终生成的ANE文件，即ane/MobileUtil.ane。如果您只是使用，不需要进行功能修改，可以
忽略下面的编译说明，将MobileUtil.ane拷贝到您的项目，进行引用即可。

2.如何编译
-------------------------------------

首先，无论您是Windows还是Mac系统，都要首先配置环境变量(PATH)，确保可以调用ADT命令。

配置方式参见Adobe的文档：
[http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-71994050128cca87097-8000.html](http://help.adobe.com/en_US/air/build/WSfffb011ac560372f-71994050128cca87097-8000.html)

Windows下的ADT命令应该是这样的(可以新建一个文本文件，将以下命令粘入，保存为build.bat，执行)：
    adt -package -storetype PKCS12 -keystore appplatform.p12 -storepass 123456 -target ane MobileUtil.ane extension.xml -swc *.swc -platform Android-ARM -C .\Android-ARM\ . -platform default -C .\Default\ . 

Mac OSX下：

请执行build.sh文件，具体方式，打开终端，输入：
    sudo sh {您的文件路径}/build.sh

稍等片刻，即可生成ANE文件
