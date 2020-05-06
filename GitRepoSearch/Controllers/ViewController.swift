//
//  ViewController.swift
//  GitRepoSearch
//
//  Created by Bhushan on 06/05/20.
//  Copyright © 2020 Bhushan. All rights reserved.
//

import UIKit
import Kingfisher
import PKHUD

class ViewController: BaseViewController {
    
    @IBOutlet weak var txtSearch: UISearchBar!
    @IBOutlet weak var usersTableView: UITableView!
    
    var masterUsers = [UsersModel]()
    var users = [UsersModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        getAllUsers()
    }
        
    //MARK:- #Func
    func filterUsersFor(_ userName: String){
        let filteredArray = self.masterUsers.filter{ ($0.login?.lowercased().contains(userName.lowercased()))! }
        self.users = filteredArray
        self.usersTableView.reloadData()
    }
    
    func redirectToDetailControllerWithDetails(_ details: UserDetails){
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "UserDetailViewController") as! UserDetailViewController
        vc.details = details
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK:- #API Call
    func getAllUsers(){
        
        super.showProgress()

        NetworkManager.shared.GET(url: APIEndpoints.GET_ALL_USERS, onSuccess: { (response) in
            
            super.hideProgress()

            guard let responseObject = response as? [[String: Any]] else{
                return
            }
            
            self.masterUsers.removeAll()
            
            for item in responseObject{
                guard let modelObject = UsersModel(JSON: item) else{
                    return
                }
                
                self.masterUsers.append(modelObject)
            }
            
            self.users = self.masterUsers
            self.usersTableView.reloadData()
            
        }) { (error) in
            print("error = \(error?.localizedDescription ?? "")")
        }
        
    }
    
    
    func getDetilsForUser(_ user: String){
        
        super.showProgress()

        NetworkManager.shared.GET(url: APIEndpoints.GET_ALL_USERS + "/\(user)", onSuccess: { (response) in
            
            super.hideProgress()
            
            guard let responseObject = response as? Dictionary<String, Any> else{
                return
            }
            
            guard let modelObject = UserDetails(JSON: responseObject) else{
                return
            }
            
            self.redirectToDetailControllerWithDetails(modelObject)
            
        }) { (error) in
            print("error = \(error?.localizedDescription ?? "")")
        }
        
    }
    
}

//MARK:- #SearchBar Delegate
extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchText == ""{
            self.users = self.masterUsers
            self.usersTableView.reloadData()
            return
        }
        
        self.filterUsersFor(searchText)
    }
}

//MARK:- #TableView Delegate
extension ViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.showEmptyMessage("No User Found", isEmpty: self.users.isEmpty)
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UsersTableViewCell") as? UsersTableViewCell
        
        let details = self.users[indexPath.row]
        cell?.lblUserName.text = details.login

        if let path = details.avatar_url, !path.isEmpty{
            let url = URL(string: path)
            cell?.imgUserProfilePic.kf.setImage(with: url)
        }
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let details = self.users[indexPath.row]
        
        if let userName = details.login{
            self.getDetilsForUser(userName)
        }
        
    }
}
