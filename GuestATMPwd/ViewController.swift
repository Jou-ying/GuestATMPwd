//
//  ViewController.swift
//  GuestATMPwd
//
//  Created by zoeli on 2020/5/13.
//  Copyright © 2020 zoeli. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet var guestNumberTextFieldList: [UITextField]!
    
    @IBOutlet weak var guestNumberTextField_1: UITextField!
    @IBOutlet weak var guestNumberTextField_2: UITextField!
    @IBOutlet weak var guestNumberTextField_3: UITextField!
    @IBOutlet weak var guestNumberTextField_4: UITextField!
    @IBOutlet weak var guestNumberTextField_5: UITextField!
    @IBOutlet weak var guestNumberTextField_6: UITextField!
    
    
    @IBOutlet var numberButtonList: [UIButton]!
    

    @IBOutlet weak var resultLabel: UILabel!
    
    
//     所有可以選擇的數值
    var allNumberList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    // 設定六個亂數值
    var passwordList: [Int] = []
    
    var guestWordList: [Int] = [0,0,0,0,0,0]
    
    // 有3次機會
    var tryCount = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setDefaultValue()
        
        print("\(self.passwordList)")
    }

    
    //MARK: - cust func
    func setDefaultValue() {
        
        self.tryCount -= 1
        
        self.passwordList = []
        
        self.allNumberList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        for i in 1...6 {
            
            let index = Int.random(in: 0...self.allNumberList.count-1)
            
            let remove = self.allNumberList.remove(at: index)
            
            self.passwordList.append(remove)
            
        }
        
        
        self.guestWordList = [0,0,0,0,0,0]
        
        // 循環填入數值
        for textField in self.guestNumberTextFieldList {
            
            textField.text = ""
            
        }
        
        
        //
        for button in self.numberButtonList {
            
            button.isEnabled = true
            
        }
        
    }
    
    
    
    //MARK: -IBAction
    @IBAction func didTapNumberButton(_ sender: UIButton) {
        
        // 循環填入數值
        for textField in self.guestNumberTextFieldList {
            
            if textField.text == "" {
                
                // 輸入過的字無法再點選
                sender.isEnabled = false
                self.guestWordList[textField.tag] = Int((sender.titleLabel?.text!)!)!
                
                textField.text = sender.titleLabel?.text
                break
            }
        }
    }
    
    
    
    @IBAction func checkGuestButton(_ sender: Any) {
        
        if self.tryCount > 0 {
            
            var isGuestAllNumber = true
            
            for guestNum in self.guestNumberTextFieldList {
                
                if guestNum.text == "" {
                    
                    isGuestAllNumber = false
                    self.resultLabel.text = "未輸入完整密碼"
                    
                }
                
            }
            
            
            if isGuestAllNumber {
                    
                var A_count = 0
                var B_count = 0
                
                
                for i in 0..<self.guestWordList.count {
                    
                    if self.passwordList[i] == self.guestWordList[i] {
                        
                        A_count += 1
                    }
                }
                
                
                for i in 0..<self.guestWordList.count {
                    
                    for j in 0..<self.passwordList.count {
                        
                        if self.passwordList[j] == self.guestWordList[i] {
                            
                            B_count += 1
                        }
                        
                    }
                }
                           
                           
                    // 代表六個數字全對
                    if A_count == 6 {
                               
                        self.resultLabel.text = "恭喜你！得到\(A_count)A"
                               
                    }else if A_count >= 4 , B_count <= 2 {
                               
                        self.resultLabel.text = "\(A_count)A\(B_count)B  差一點了~ 加油 💪🏼"
                               
                           
                    }else {
                               
                        self.resultLabel.text = "\(A_count)A\(B_count)B  密碼錯誤，請再試一次"
    
                    }
                }
        
        }else {
            self.resultLabel.text = "請先點選重新開始"
        }
        
    }
    
    
    
    @IBAction func didTapResetButton(_ sender: UIButton) {
        
        self.setDefaultValue()
    }
    
    
    // 清除上一個輸入的值
    @IBAction func clearGuestNumber(_ sender: UIButton) {
        
        // 要清除第幾個值
        var clearIndex = 0
        
        for guestNum in self.guestNumberTextFieldList {
            
            if guestNum.text != "" {
                clearIndex = guestNum.tag
            }
        }
        
        // 再跑一次回圈清除值
        for guestNum in self.guestNumberTextFieldList {
            
            if clearIndex == guestNum.tag {
                
                guestNum.text = ""
            }
        }
        
        
        // 恢復button狀態
        for button in self.numberButtonList {
            
            if button.titleLabel?.text == self.guestNumberTextFieldList[clearIndex].text {
                
                button.isEnabled = true
            }
        }
    }
    
    
}

