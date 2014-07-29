//
//  MNToolkitImpl.swift
//  MNToolkit
//
//  Created by 陆广庆 on 14/7/26.
//  Copyright (c) 2014年 陆广庆. All rights reserved.
//

import UIKit

class MNToolkitImpl: MNToolkit {
    
    class func getStroyboard(storyboardName: String) -> UIStoryboard {
        let storyboard = UIStoryboard(name: storyboardName, bundle: NSBundle.mainBundle())
        return storyboard;
    }
}
