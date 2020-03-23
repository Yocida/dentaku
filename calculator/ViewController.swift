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
    var onscreenNumber:Double = 0; // 画面上の数字
    var previousNumber:Double = 0; // 前回表示されていた数字
    var operation = 0; //  + , - , × , ÷
    
    var operationFlag = false  // 符号フラグ
    var firstFlag = false //数字(整数)
    var result : String = "" // 計算結果
    
       @IBOutlet weak var label: UILabel!{ // 計算結果表示ラベル
        didSet{
            label.text = "0"
        }
    }
//       @IBOutlet weak var pushButton: UIButton!
    
    //数値ボタン押下時動作
    @IBAction func numbers(_ sender: UIButton) {
        //符号ボタンの押下有無
        if operationFlag {
            //符号ボタン押下後最初の数値ボタン押下の場合
            if firstFlag {
                label.text = String(sender.tag-1)  // String(sender.tag-1) 表示
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
                firstFlag = false
                
//              pushButton.setTitleColor(UIColor.redColor(), forState: .Highlighted) //文字色
//                pushButton.backgroundColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7) //背景色
            }
            //表示文字数が14文字の場合
            else if label.text!.utf8.count > 13{
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
                print(label.text!.utf8.count)
                print("入力最大桁数は14桁です。")
            }
            //0が入力されている場合
            else if label.text == "0"{
                label.text = String(sender.tag-1)
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
            } else {
                label.text = label.text! + String(sender.tag-1)  // String(sender.tag-1) 表示
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
            }
        } else {
            //=ボタン押下後最初の数値ボタン押下の場合
            if firstFlag {
                label.text = String(sender.tag-1)  // String(sender.tag-1) 表示
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
                firstFlag = false
            }
            //表示文字数が14文字の場合
            if label.text!.utf8.count > 13{
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
                print(label.text!.utf8.count)
                print("入力最大桁数は14桁です。")
            }
            //0が入力されている場合
            else if label.text == "0"{
                label.text = String(sender.tag-1)
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
            } else {
                label.text = label.text! + String(sender.tag-1)  // 表示文字＋押下ボタン数字
                onscreenNumber = Double(label.text!)!  // 数字に変換し代入
            }
        }
    }

    //符号、＝、クリアボタン押下時動作
    @IBAction func buttons(_ sender: UIButton) {
        //＋－×÷ボタン押下時の処理
        if label.text != "" && sender.tag != 11 && sender.tag != 16{
            if operationFlag {
                keisan( operation:operation )
            }
            
            previousNumber = Double(label.text!)!
            operationFlag = true
            firstFlag = true
            operation = sender.tag
//            pushButton = sender
            
//            sender.setTitleColor(UIColor.redColor(), forState: .Highlighted) //文字色
 //           sender.backgroundColor = UIColor(red:59/255,green:89/255,blue:152/255,alpha:0.7) //背景色
        }
        // =ボタン押下時の処理
        else if sender.tag == 16 {
            keisan( operation:operation )
            previousNumber = 0;
            onscreenNumber = 0;
            operation = 0;      //符号
            operationFlag = false
            firstFlag = true
        }
        // Cボタン押下時の処理
        else if sender.tag == 11{
            label.text = "0"     //ラベル表示空
            previousNumber = 0;
            onscreenNumber = 0;
            operation = 0;      //符号
            operationFlag = false
            firstFlag = false
        }
    }

    //四則計算関数
    func keisan(operation:Int){
        if operation == 15{ //÷
            result = String(previousNumber / onscreenNumber)
        }
        else if operation == 14{//×
            result = String(previousNumber * onscreenNumber)
        }
        else if operation == 13{//-
            result = String(previousNumber - onscreenNumber)
        }
        else if operation == 12{//+
            result = String(previousNumber + onscreenNumber)
        }
        
        label.text = result.replacingOccurrences(of:"\\.0$", with:"", options: NSString.CompareOptions.regularExpression, range: nil)
    }
    
    //view読み込み時の動作
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
