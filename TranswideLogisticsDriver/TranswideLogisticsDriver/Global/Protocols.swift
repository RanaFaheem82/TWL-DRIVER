//
//  Protocols.swift
//  UgoCab
//
//  Created by Gulfam Khan on 29/10/2019.
//  Copyright © 2019 Rapidzz. All rights reserved.
//

import Foundation

//MARK:- TopBarDelegate
protocol TopBarDelegate: class {
    func actionBack()
    func rightButtonAction()
    func actionCallbackEdit()
    func actionCallBackSave()
}

extension TopBarDelegate {
    func rightButtonAction() {}
    func actionCallbackEdit(){}
    func actionCallBackSave(){}
}

//MARK:- ProfileStatusViewControllerDelegate
protocol ProfileStatusViewControllerDelegate :class {
    func didselectItem(index: Int)
}

