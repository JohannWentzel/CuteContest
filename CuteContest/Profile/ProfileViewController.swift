//
//  ProfileViewController.swift
//  CuteContest
//
//  Created by Johann Wentzel on 2018-08-23.
//  Copyright © 2018 Johann Wentzel. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var numPostsLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Networking.sharedInstance?.profileDataDelegate = self
        Networking.sharedInstance?.getProfileData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        Networking.sharedInstance?.logout()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ProfileViewController: ProfileDataDelegate {
    func didUpdateStats(posts: Int, totalScore: Int) {
        numPostsLabel.text = "\(posts)"
        totalScoreLabel.text = "\(totalScore)"
    }
}
