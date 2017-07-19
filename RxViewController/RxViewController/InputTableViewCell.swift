//
//  InputTableViewCell.swift
//  RxViewController
//
//  Created by chenyong on 2017/7/18.
//  Copyright © 2017年 chenyong. All rights reserved.
//

import UIKit

protocol InputTableViewInputCellDelegate: class {
    func inputChanged(cell: InputTableViewCell, text: String)
}

class InputTableViewCell: UITableViewCell {

    weak var delegate: InputTableViewInputCellDelegate?
    @IBOutlet weak var textField: UITextField!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    @objc
    @IBAction func textFieldValueChanged(_ sender: UITextField) {
        delegate?.inputChanged(cell: self, text: sender.text ?? "")
    }

}
