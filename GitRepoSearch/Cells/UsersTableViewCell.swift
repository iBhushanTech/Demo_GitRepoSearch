//
//  UsersTableViewCell.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import UIKit

class UsersTableViewCell: UITableViewCell {

    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var imgUserProfilePic: UIImageView!
    @IBOutlet weak var lblRepoCount: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.imgUserProfilePic.makeRounded()        
    }
}
