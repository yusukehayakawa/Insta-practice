//
//  ViewController.swift
//  Insta-practice
//
//  Created by HayakawaYusuke on 2018/04/10.
//  Copyright © 2018年 HayakawaYusuke. All rights reserved.
//

import UIKit
import ESTabBarController
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    // インスタンス化された直後（初回に一度のみ）
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTab()
    }

    // 画面が表示された直後
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
          // ログインしていないときの処理
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            self.present(loginViewController!, animated: true, completion: nil) //present(_:animated:completion:)メソッドでモーダル表示
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupTab() {
        // 画像のファイル名を指定してESTabBarControllerを作成する
        let tabBarController: ESTabBarController! = ESTabBarController(tabIconNames: ["home", "camera", "setting"])
        
         // 選択ボタンの色の設定
        tabBarController.selectedColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        // ボタンの背景色の設定
        tabBarController.buttonsBackgroundColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        // 選択インジケーターの高さの設定
        tabBarController.selectionIndicatorHeight = 3


//  作成したESTabBarControllerを親のViewController（＝self）に追加する
        // 追加するViewControllerの指定するメソッドaddChildViewController(_:)
        addChildViewController(tabBarController)

        // 追加時に行う処理を記述する
        let tabBarView = tabBarController.view!
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tabBarView) // 子のViewControllerのViewを追加
        let safeArea = view.safeAreaLayoutGuide // 親のViewのSafe Area全体に子のViewを表示するよう制約を設定
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            tabBarView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tabBarView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            ])

        // 子のViewControllerのdidMove(toParentViewController:)メソッドで追加の完了
        tabBarController.didMove(toParentViewController: self)
        
        // タブをタップした時に表示するViewControllerを設定する
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: "Home")
        let setingViewController = storyboard?.instantiateViewController(withIdentifier: "Setting")
        // 真ん中のタブはボタンとして扱う
        tabBarController.highlightButton(at: 1)
        tabBarController.setAction({
          // ボタンが押されたらImageViewControllerをモーダルで表示する
            let imageViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageSelect")
            self.present(imageViewController!, animated: true, completion: nil)
        }, at: 1)
    }
}

