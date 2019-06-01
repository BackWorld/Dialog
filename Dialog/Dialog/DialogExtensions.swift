//
//  DialogAction.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/17.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

// MARK: - Configuration
public extension Dialog {
    class Configuration {
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
        public var backgroundColor = UIColor.black.withAlphaComponent(0.4)
		
		public init(){
		}
	}
}

// MARK: - Title
public extension Dialog{
    class Title {
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
        
		var attributes: [NSAttributedString.Key: Any] {
            var attributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.foregroundColor: self.color,
                NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16)
            ]
            let paragraph = NSMutableParagraphStyle()
            paragraph.lineHeightMultiple = 1.5
            paragraph.alignment = self.alignment
            attributes.updateValue(paragraph, forKey: NSAttributedString.Key.paragraphStyle)
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

// MARK: - Message
public extension Dialog{
    class Message {
		public var text: String? = nil
		public var attributedText: NSAttributedString? = nil
		
		var attributedString: NSAttributedString?{
			if let text = text {
				let paragraph = NSMutableParagraphStyle()
				paragraph.lineHeightMultiple = 1.5
				paragraph.alignment = .center
				return NSAttributedString(string: text, attributes: [
                    NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14),
                    NSAttributedString.Key.paragraphStyle: paragraph
				])
			}
			else if let attributedText = attributedText {
				return attributedText
			}
			return nil
		}
		
		public init(){
		}
		
		public init(_ text: String?){
			self.text = text
		}
		public init(attributedText: NSAttributedString?){
			self.attributedText = attributedText
		}
	}
}

// MARK: - Action
public extension Dialog {
    class Action {
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

// MARK: - Style
public extension Dialog.Action{
    class Style {
        public static let `default` = Style()
        public static let cancel = Style.custom(tintColor: .gray)
        public static let primary = Style.custom(isBold: true)
        public static let destructive = Style.custom(tintColor: .red)
        
        public var tintColor: UIColor = Dialog.Configuration.default.primaryColor
        public var alignment: UIControl.ContentHorizontalAlignment = .center
        public var isBold = false //是否加重显示
        
        var font: UIFont{
            return isBold
                ? .boldSystemFont(ofSize: 16)
                : .systemFont(ofSize: 16)
        }
		
        public static func custom(
            tintColor: UIColor = Dialog.Configuration.default.primaryColor,
            alignment: UIControl.ContentHorizontalAlignment = .center,
            isBold: Bool = false) -> Style
        {
            let instance = Style()
            instance.tintColor = tintColor
            instance.alignment = alignment
            instance.isBold = isBold
            return instance
        }
    }
}
