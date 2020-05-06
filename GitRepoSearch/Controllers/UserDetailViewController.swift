//
//  UserDetailViewController.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import UIKit

class UserDetailViewController: BaseViewController {

    @IBOutlet weak var imgUserProfilePic: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblJoinDate: UILabel!
    @IBOutlet weak var lblFollowers: UILabel!
    @IBOutlet weak var lblFollowing: UILabel!
    @IBOutlet weak var lblBio: UILabel!

    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var detailTableView: UITableView!
    
    var details: UserDetails?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.imgUserProfilePic.makeRounded()

        self.showUserDetails()
    }
    
    //MARK:- #Func
    func showUserDetails(){
        self.lblUserName.text = "Name: \(String(describing: details?.name ?? ""))"
        self.lblEmail.text = "Email: \(String(describing: details?.email ?? ""))"
        self.lblLocation.text = "Location: \(String(describing: details?.location ?? ""))"
        self.lblJoinDate.text = "Join Date: \(details?.created_at?.components(separatedBy: "T").first ?? "")"
        self.lblFollowers.text = "Followers: \(String(describing: details?.followers ?? 0))"
        self.lblFollowing.text = "Following: \(String(describing: details?.following ?? 0))"
        self.lblBio.text = details?.bio

        if let path = details?.avatar_url, !path.isEmpty{
            let url = URL(string: path)
            imgUserProfilePic.kf.setImage(with: url)
        }
    }

}


//MARK:- #SearchBar Delegate
extension UserDetailViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
 
    }
}
