# Dialog
A dialog UI component by Swift.

### 要求
- Xcode 8.3+
- Swift 3.2+
- iOS 9.0+

### 介绍
##### UIKit中的对话框组件：
- 一般情况下，系统提供了`UIAlertView`和`UIAlertController`两个类，提供了对话框的基本使用，用法比较简单，这里不再赘述；
- 但系统的alert对话框默认是很难自定义样式的：比如修改文字颜色、圆角大小以及点击背景自动消失等等操作；
##### Dialog库
- 本库模仿系统的alert控件，实现了高度的还原（包括动画和UI），以及更友好强大的适配（包括转屏、文本过长、按钮过多等情况下的UI适配）；
- 本库用法更加简洁，基于UIWindow的topViewController，任何地方中均可调用；
- 高度可定制的UI（按钮颜色、icon、文本对齐位置、对话框的圆角大小等）；
- 支持自定义view/view controller的弹出；
- 支持图片大图模式；

### 用法
##### default默认样式

- 方法定义

~~~ swift
public static func `default`(title: Dialog.Title? = nil,
                                 message: Dialog.Message? = nil,
                                 actions: [Dialog.Action]? = nil,
                                 configuration: Dialog.Configuration = .default)
 {}
~~~
- `Dialog.Title`

~~~ swift
public init(_ text: String?,
                    color: UIColor = Dialog.Configuration.default.primaryColor,
                alignment: NSTextAlignment = .center)
{}
~~~
- `Dialog.Message`

~~~ swift
public init(_ text: String?,
                    attributes: [String: Any] = [:])
{}
~~~~

- `Dialog.Action`

~~~ swift
public init(title: String? = nil, icon: UIImage? = nil, style: Action.Style = .default, handler: Handler? = nil)
{}
~~~

- `Dialog.Configuration`

~~~ swift
public class Configuration: NSObject {
        public var cornerRadius: CGFloat = 0 //圆角半径
        public var isBackgroundViewUserInteractionEnabled = false //是否点击背景消失
        public var primaryColor: UIColor = .black //对话框里的元素主色
}
~~~

- 用法示例

![Dialog Default](https://upload-images.jianshu.io/upload_images/1334681-dee4fe933d99fdc9.gif?imageMogr2/auto-orient/strip)

> 代码见`DemoDialogDefaultVC.swift` 

##### image大图样式
~~~ swift
Dialog.image(UIImage(named: "image"), actions: [
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1"),
			Dialog.Action(title: "hello1")
])
~~~

![Dialog Image](https://upload-images.jianshu.io/upload_images/1334681-c9537cfaef8e1a68.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

##### custom自定义view样式

~~~ swift
// 自定义controller
let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ActionCollectionVC") as! ActionCollectionVC
vc.view.frame = CGRect(origin: .zero, size: CGSize(width: view.bounds.width, height: 100))
vc.collectionView?.delegate = self

// 调用
Dialog.custom(vc.view, actions: [
	Dialog.Action(title: "Cancel")
])
~~~

![Dialog Custom](https://upload-images.jianshu.io/upload_images/1334681-e7d5f74eb4bed16b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/400)

### Carthage
- 目前该控件库已上传到github上，支持Carthage编译
- 用法

> 1.在你的Cartfile中加入
`github "BackWorld/Dialog" "master"`

> 2.在终端执行`carthage update`

> 3.将`Carthage/Build/iOS`目录下的`Dialog.framework`拖到你的项目中

> 4.在使用的swift文件中`import Sheeter`即可

### 简书
https://www.jianshu.com/p/06c2b2cd0872

> 如果对你有帮助，别忘了点个赞和关注~
