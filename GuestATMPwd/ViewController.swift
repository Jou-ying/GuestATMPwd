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
    
    
    // 設定所有可以選擇的數值為陣列
    var allNumberList: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    // 設定六個亂數答案為陣列
    var passwordList: [Int] = []
    
    // 設定回答的六個數值為陣列
    var guestWordList: [Int] = [0, 0, 0, 0, 0, 0]
    
    // 記錄目前填入第幾個數值
    var currentGuestWordIndex = 0
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.setDefaultValue()
        
    }

    
    //MARK: - cust func
    func setDefaultValue() {
        
        // 重新亂數選擇答案
        self.passwordList = []
        
        self.allNumberList = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        
        // 需要六個數值，所以重複執行6次
        for i in 1...6 {
            
            // 亂數取出放入答案陣列裡的是第幾個數值
            let index = Int.random(in: 0...self.allNumberList.count-1)
            
            // 取出index中的值，並刪除此項目(因為6個值不能重複，需過濾掉已選取的)
            let number = self.allNumberList.remove(at: index)
            
            self.passwordList.append(number)
            
        }
        
        print(passwordList)
        
        self.guestWordList = [0, 0, 0, 0, 0, 0]
        
        // 循環每個輸入框，且預設未輸入數值狀態
        for textField in self.guestNumberTextFieldList {
            
            textField.text = ""
        }
        
        
        // 循環每個數字按鈕，預設每個都可以點選
        for button in self.numberButtonList {
            
            button.isEnabled = true
            
        }
        
        
        self.currentGuestWordIndex = 0
        
    }
    
    
    
    //MARK: -IBAction
    
    // 點選數值
    @IBAction func didTapNumberButton(_ sender: UIButton) {
        
        self.currentGuestWordIndex += 1
        
        // 循環填入數值
        for textField in self.guestNumberTextFieldList {
            
            if textField.text == "" {
                
                // 輸入過的字無法再點選(因6個數字不能重複)
                sender.isEnabled = false
                
                // 將選取數值放入陣列中
                self.guestWordList[textField.tag] = Int((sender.titleLabel?.text!)!)!
                
                textField.text = sender.titleLabel?.text
                
                break
            }
        }
    }
    
    
    // 驗證數值
    @IBAction func checkGuestButton(_ sender: Any) {
        
       // 確認是否6個數值都有填寫
       var isGuestAllNumber = true
            
       for guestNum in self.guestNumberTextFieldList {
                
           if guestNum.text == "" {
                    
              isGuestAllNumber = false
              self.resultLabel.text = "未輸入完整密碼"
                    
            }
        }
            
        // 確認數值填寫完畢
        if isGuestAllNumber {
                    
            var A_count = 0
            var B_count = 0
                
            // 判斷位置及數值都相同
            for i in 0..<self.guestWordList.count {
                    
                if self.passwordList[i] == self.guestWordList[i] {
                        
                    A_count += 1
                }
            }
                
            
            // 判斷有相同的值
            for i in 0..<self.guestWordList.count {
                    
                for j in 0..<self.passwordList.count {
                        
                    if self.passwordList[j] == self.guestWordList[i] {
                            
                        B_count += 1
                    }
                }
            }
            
            // B個數需減掉重複的A個數
            B_count -= A_count
                           
                           
            // 代表六個數字全對
            if A_count == 6 {
                               
                self.resultLabel.text = "恭喜你！得到\(A_count)A"
                               
            }else {
                               
                self.resultLabel.text = "\(A_count)A\(B_count)B  密碼錯誤，請再試一次"
            }
        }
    }
    
    
    // 重新再來一次
    @IBAction func didTapResetButton(_ sender: UIButton) {
        
        self.setDefaultValue()
    }
    
    
    // 清除上一個輸入的值
    @IBAction func clearGuestNumber(_ sender: UIButton) {
        
        if self.currentGuestWordIndex > 0 {
            
            // 要清除第幾個值
            let clearIndex = self.currentGuestWordIndex
            
            
            // 恢復button可點擊
            for button in self.numberButtonList {
                
                if button.titleLabel?.text == self.guestNumberTextFieldList[clearIndex-1].text {
                    
                    button.isEnabled = true
                }
            }
            
            
            // 清除值
            for guestNum in self.guestNumberTextFieldList {
                
                if guestNum.tag == (clearIndex-1) {
                    
                    guestNum.text = ""
                }
            }
        
            self.currentGuestWordIndex -= 1
            
        }
        
    }
    
}

