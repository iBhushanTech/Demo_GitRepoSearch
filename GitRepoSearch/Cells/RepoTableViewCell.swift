//
//  RepoTableViewCell.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet weak var lblRepoName: UILabel!
    @IBOutlet weak var lblForks: UILabel!
    @IBOutlet weak var lblStars: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
