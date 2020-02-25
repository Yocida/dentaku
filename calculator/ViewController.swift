//
//  ViewController.swift
//  calculator
//
//  Created by 吉田愛華 on 2020/02/23.
//  Copyright © 2020 吉田愛華. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //変数宣言
    var numberOnScreen:Double = 0; // 画面上の数字
    var previousNumber:Double = 0; // 前回表示されていた数字
    var numberOnScreen_Int = 0; // 画面上の数字(整数)
    var previousNumber_Int = 0; // 前回表示されていた数字(整数)
    var performingMath = false  // 計算可能フラグ
    var operation = 0; //  + , - , × , ÷
    
    @IBOutlet weak var label: UILabel!  // 計算結果表示ラベル
    @IBOutlet weak var button: UIButton! {
        didSet {
            // ボタンの装飾
            let rgba = UIColor(red: 200/255, green: 255/255, blue: 255/255, alpha: 1.0) // ボタン背景色設定
            button.backgroundColor = rgba                                               // 背景色
            button.layer.borderWidth = 0.5                                              // 枠線の幅
            button.layer.borderColor = UIColor.black.cgColor                            // 枠線の色
            button.layer.cornerRadius = 5.0                                             // 角丸のサイズ
        }
    }
    
    //数値ボタン押下時動作
    @IBAction func numbers(_ sender: UIButton) {
        if performingMath == true{
            label.text = String(sender.tag-1)  // numberOnScreen の値が上書きされる
            numberOnScreen = Double(label.text!)!
            performingMath = false
        }
        //表示文字数が14文字の場合
        else if label.text!.utf8.count > 13{
            numberOnScreen = Double(label.text!)!  // 数字が表示
            print(label.text!.utf8.count)
            print("入力最大桁数は14桁です。")
        }
        //0が入力されている場合
        else if label.text == "0"{
            label.text = String(sender.tag-1)
        }
        else{
            label.text = label.text! + String(sender.tag-1)  // 表示文字＋押下ボタン数字
            numberOnScreen = Double(label.text!)!  // 数字が表示
            print(label.text!.utf8.count)
        }
    }
    
    //符号、クリアボタン押下時動作
    @IBAction func buttons(_ sender: UIButton) {
        //数字が表示されていた場合の処理
        if label.text != "" && sender.tag != 11 && sender.tag != 16{
            previousNumber = Double(label.text!)!
            
            if sender.tag == 15{ // ÷
                label.text = "÷";
            }
            else if sender.tag == 14{  // ×
                label.text = "×";
            }
            else if sender.tag == 13{  // -
                label.text = "-";
            }
            else if sender.tag == 12{  // +
                label.text = "+";
            }
            
            operation = sender.tag
            performingMath = true;
        }
        // = が押された時の処理
        else if sender.tag == 16
        {
            if operation == 15{ //÷
                label.text = String(previousNumber / numberOnScreen)
            }
            else if operation == 14{//×
                label.text = String(previousNumber * numberOnScreen)
            }
            else if operation == 13{//-
                previousNumber_Int = Int(previousNumber)
                numberOnScreen_Int = Int(numberOnScreen)
                label.text = String(previousNumber_Int - numberOnScreen_Int)
            }
            else if operation == 12{//+
                previousNumber_Int = Int(previousNumber)
                numberOnScreen_Int = Int(numberOnScreen)
                label.text = String(previousNumber_Int + numberOnScreen_Int)
            }
        }
        // C が押された時の処理
        else if sender.tag == 11{
            label.text = ""     //ラベル表示空
            previousNumber = 0;
            numberOnScreen = 0;
            operation = 0;      //符号
        }
        //数字が表示されていなかった場合の処理
        else{
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
}
