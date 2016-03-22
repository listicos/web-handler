//
//  MainCell.swift
//  Ads Handler
//
//  Created by Ruben Velazquez Calva on 30/10/15.
//  Copyright © 2015 Listicos. All rights reserved.
//

import Foundation
import UIKit

protocol MainCellDelegate : class {
    func didChangeSwitchState(sender: MainCell, isOn: Bool)
}

class MainCell: UITableViewCell {
    @IBOutlet weak var icon: UIImageView!
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var descriptionText: UILabel!
    @IBOutlet weak var enabled: UISwitch!
    weak var cellDelegate: MainCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func statusChanged(sender: UISwitch) {
        cellDelegate?.didChangeSwitchState(self, isOn: sender.on)
    }
    
    override func prepareForReuse() {

    }
}