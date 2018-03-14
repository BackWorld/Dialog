//
//  DialogViewController.swift
//  Dialog
//
//  Created by zhuxuhong on 2018/3/14.
//  Copyright © 2018年 zhuxuhong. All rights reserved.
//

import UIKit

class DialogViewController: UIViewController {
    @IBOutlet weak var wrapperView: UIView!
    @IBOutlet weak var wrapperViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var wrapperViewHeightConstraint: NSLayoutConstraint!
    
    var actions: [DialogAction]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
