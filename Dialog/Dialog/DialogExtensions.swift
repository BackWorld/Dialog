//
//  DialogAction.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/17.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

public extension Dialog{
    public struct Message{
        public var text: String?
        public var attributes: [String: Any] = [:]
        
        public init(_ text: String?,
                    attributes: [String: Any] = [:])
        {
            self.text = text
            self.attributes = attributes
        }
    }
}


public extension Dialog{
    public struct Title{
        public var text: String?
        public var color: UIColor = Dialog.Configuration.default.primaryColor
        public var alignment: NSTextAlignment = .center{
            didSet{
                switch alignment {
                case .center, .left, .right:
                    break
                default:
                    alignment = .center
                }
            }
        }
        
        lazy var attributes: [String: Any] = {
            var attributes: [String: Any] = [
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
            ]
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineHeightMultiple = 1.5
            paragraph.alignment = self.alignment
            attributes.updateValue(paragraph, forKey: NSParagraphStyleAttributeName)
            return attributes
        }()

        public init(_ text: String?,
                    color: UIColor = Dialog.Configuration.default.primaryColor,
                alignment: NSTextAlignment = .center)
        {
            self.text = text
            self.color = color
            self.alignment = alignment
        }
    }
}

public extension Dialog {
    public class Configuration: NSObject {
        public static let `default` = Configuration()
        
        public var cornerRadius: CGFloat = 0
        public var isBackgroundViewUserInteractionEnabled = false
        public var primaryColor: UIColor = .black
    }
}


public extension Dialog {
    public struct Action {
        public typealias Handler = ((Action) -> Void)

        var icon: UIImage?
        var title: String?
        var handler: Handler?
        var style: Action.Style = .default
        
        public init(title: String? = nil, icon: UIImage? = nil, handler: Handler? = nil, style: Action.Style = .default) {
            self.title = title
            self.icon = icon
            self.handler = handler
            self.style = style
        }
    }
}

public extension Dialog.Action{
    public struct Style{
        public static let `default` = Style()
        public static let cancel = Style.custom(isPrimary: true)
        public static let destructive = Style.custom(tintColor: .red)
        
        public var tintColor: UIColor = Dialog.Configuration.default.primaryColor
        public var alignment: UIControlContentHorizontalAlignment = .center
        public var isPrimary = false //是否加重显示
        
        var font: UIFont{
            return isPrimary
                ? .boldSystemFont(ofSize: 16)
                : .systemFont(ofSize: 16)
        }
        
        public static func custom(tintColor: UIColor = Dialog.Configuration.default.primaryColor, alignment: UIControlContentHorizontalAlignment = .center, isPrimary: Bool = false) -> Style{
            var instance = Style()
            instance.tintColor = tintColor
            instance.alignment = alignment
            instance.isPrimary = isPrimary
            return instance
        }
    }
}
