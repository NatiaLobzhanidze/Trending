//
//  TableViewExtensions.swift
//  Trending
//
//  Created by Natia's Mac on 09.02.23.
//

import Foundation
import UIKit

extension UITableView {
    func registerClass<T: UITableViewCell>(class: T.Type) {
        self.register(T.self, forCellReuseIdentifier: T.identifier)
    }
    
    func registerNib<T: UITableViewCell>(class: T.Type) {
        self.register(T.nib, forCellReuseIdentifier: T.identifier)
    }
    
    func deque<T: UITableViewCell>(class: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

extension UITableViewCell {
    static var identifier: String { String(describing: self) }
    
    static var nib: UINib { UINib(nibName: identifier, bundle: nil) }
}
