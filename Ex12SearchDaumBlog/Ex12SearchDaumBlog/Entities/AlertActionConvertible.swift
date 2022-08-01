//
//  AlertActionConvertible.swift
//  Ex12SearchDaumBlog
//
//  Created by 도학태 on 2022/08/01.
//

import Foundation
import UIKit


protocol AlertActionConvertible {
    var title : String { get }
    var style : UIAlertAction.Style { get }
}
