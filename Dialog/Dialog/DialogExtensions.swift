//
//  DialogAction.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/17.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

public extension Dialog {
	public class Configuration {
		public static let `default` = Configuration()
		
		public var cornerRadius: Int = 0{
			didSet{
				if cornerRadius < 0 {
					cornerRadius = 0
				}
				else if cornerRadius > 20{
					cornerRadius = 20
				}
			}
		}
		public var isBackgroundViewUserInteractionEnabled = false
		public var primaryColor: UIColor = .black
		
		public init(){
		}
	}
}

public extension Dialog{
    public class Title {
        public var text: String? = nil
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
        
		var attributes: [String: Any] {
            var attributes: [String: Any] = [
				NSForegroundColorAttributeName: self.color,
                NSFontAttributeName: UIFont.boldSystemFont(ofSize: 16)
            ]
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineHeightMultiple = 1.5
            paragraph.alignment = self.alignment
            attributes.updateValue(paragraph, forKey: NSParagraphStyleAttributeName)
            return attributes
		}

		public init(){
		}
		
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

public extension Dialog{
	public class Message {
		public var text: String? = nil
		public var attributes: [String: Any] = [:]
		
		public init(){
		}
		
		public init(_ text: String?,
					attributes: [String: Any] = [:])
		{
			self.text = text
			self.attributes = attributes
		}
	}
}

public extension Dialog {
	public class Action {
        public typealias Handler = ((Action) -> Void)

        public var icon: UIImage? = nil
        public var title: String? = nil
        var handler: Handler?
        public var style: Action.Style = .default
		
		public init(){
		}
		
        public init(title: String? = nil, icon: UIImage? = nil, style: Action.Style = .default, handler: Handler? = nil) {
            self.title = title
            self.icon = icon
			self.style = style
            self.handler = handler
        }
    }
}

public extension Dialog.Action{
	public class Style {
        public static let `default` = Style()
        public static let cancel = Style.custom(isBold: true)
        public static let destructive = Style.custom(tintColor: .red)
        
        public var tintColor: UIColor = Dialog.Configuration.default.primaryColor
        public var alignment: UIControlContentHorizontalAlignment = .center
        public var isBold = false //是否加重显示
        
        var font: UIFont{
            return isBold
                ? .boldSystemFont(ofSize: 16)
                : .systemFont(ofSize: 16)
        }
		
        public static func custom(tintColor: UIColor = Dialog.Configuration.default.primaryColor, alignment: UIControlContentHorizontalAlignment = .center, isBold: Bool = false) -> Style{
            let instance = Style()
            instance.tintColor = tintColor
            instance.alignment = alignment
            instance.isBold = isBold
            return instance
        }
    }
}
