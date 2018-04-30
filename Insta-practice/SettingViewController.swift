//
//  SettingViewController.swift
//  Insta-practice
//
//  Created by HayakawaYusuke on 2018/04/10.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth
import SVProgressHUD

class SettingViewController: UIViewController {

    @IBOutlet weak var displayNameTextField: UITextField!

    @IBAction func handleChangeButton(_ sender: Any) {
        if let displayName = displayNameTextField.text {

            // 表示名が入力されていないときはHUDを出して何もしない
            if displayName.isEmpty {
                SVProgressHUD.isEmptyshowError(withStatus: "表示名を入力してください")
                return
            }

            // 表示名を設定する
            let user = Auth.auth().currentUser
            if let user = user {
                let changeRequest = user.createProfileChangeRequest()
                changeRequest.displayName = displayName
                changeRequest.commitChanges { error in
                    if let error = error {
                        print("DEBUG_PRINT: " + error.localizedDescription)
                    }
                    print("DEBUG_PRINT: [displayName = \(String(describing: user.displayName))]の設定に成功しました。")

                        SVProgressHUD.showSuccess(withStatue: "表示名を変更しました")
                 }
            } else {
                print("DEBUG_PRINT: displayNameの設定に失敗しました")
            }
        }
        // キーボードを閉じる
        self.view.endEditing(true)
    }

    // ログアウトボタンをタップしたときに呼ばれるメソッド
    @IBAction func handleLogoutButton(_ sender: Any) {
        // ログアウトする
        try! Auth.auth().signOut()
        
        // ログイン画面の表示
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)

        // ログイン画面から戻ってきた時のためにホーム画面(index = 0)を選択している状態にしておく
        let tabBArController = parent as! ESTabBarController
        tabBArController.setSelectedIndex(0, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // 表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            displayNameTextField.text = user.displayName
        }
    }
}
