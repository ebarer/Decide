//
//  PollOptionCell.swift
//  Decide With Friends
//
//  Created by Elliot Barer on 2016-02-28.
//  Copyright © 2016 Elliot Barer. All rights reserved.
//

import UIKit

class PollOptionCell: UITableViewCell {

    @IBOutlet var pollTitleLabel: UILabel!
    @IBOutlet var pollSubtitleLabel: UILabel!
    @IBOutlet var pollCountLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
