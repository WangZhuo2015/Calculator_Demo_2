//
//  ViewController.swift
//  Calculator_Demo_2
//
//  Created by 王卓 on 15/5/13.
//  Copyright (c) 2015年 王卓. All rights reserved.
//
import UIKit


//此枚举用于记录计算状态
enum Calc{
    case plus
    case minus
    case multiply
    case division
    case blank
    case equal
}
class ViewController: UIViewController,UITextFieldDelegate {
    var NUM=0.0;//当前操作数
    var NUM_L=0.0;//前操作数
    var Point=false;//是否点击了小数点
    var site=10.0;//小数点后的位数
    var flag:Calc=Calc.blank;//Calc型变量flag用于记录计算的状态
    var text=""//此文本用于输出到TextField
    var tapped_Calc:UIButton?//按下的计算符号，一开始其值为nil
    @IBOutlet var Screen:UITextField!;//通过InterfaceBuilder捆绑一个UITextField到具体对象
    
    //通过InterfaceBuilder捆绑按钮1～9的动作到btn1函数
    @IBAction func btn1(sender:UIButton){
        if(!Point){
            NUM*=10;
            NUM+=Double(sender.currentTitle!.toInt()!);//通过UIButton的text处理
        }
        else{
            NUM += (Double(sender.currentTitle!.toInt()!)/site);//如果小数点状态为启用，则添加到相应位置
            site*=10;
        }
        Refresh()//更新UITextField的内容
    }
    
    //处理任意计算符号按钮的响应事件
    @IBAction func Calc_tapped(sender:UIButton){
        Cal();//首先完成上一步的计算
        NUM_L=NUM;//将结果变为前操作数
        
        //根据按钮的不同，改变计算状态标志
        switch(sender.currentTitle!){
        case "+":flag = Calc.plus;
        case "-":flag = Calc.minus;
        case "÷":flag = Calc.division;
        case "X":flag = Calc.multiply
        default:Void()
        }
        println(String(stringInterpolationSegment: flag))//在控制台输出的用于调试的数据
        
        //可选绑定
        //若tapped_Calc不为空，则恢复其颜色为默认的紫色
        if var tapped=tapped_Calc{
            tapped_Calc?.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)}
        
        //将后按的计算符号按钮的颜色设置为橙色
        sender.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Normal)
        //
        tapped_Calc=sender;
        Refresh()
        NUM=0;
    }
    
    //更新UITextField的内容
    func Refresh(){
        text = "\(NUM)"
        println(text)
        Screen.text=text;
    }
    
    //响应等于按钮的事件
    @IBAction func equal(sender:UIButton){
        if var tapped=tapped_Calc{ tapped_Calc?.setTitleColor(UIColor.purpleColor(), forState: UIControlState.Normal)}
        Cal();
        Refresh()
    }
    
    //响应小数点按钮的事件
    @IBAction func point(sender:UIButton){
        Point=true;
        Refresh()
    }
    
    //清零
    @IBAction func AC(sender:UIButton){
        NUM=0
        NUM_L=0
        Point=false
        site=10;
        Refresh()
    }
    
    //相反数
    @IBAction func opposite_number(sender:UIButton){
        NUM = -(NUM);
        Refresh()
    }
    
    //百分比
    @IBAction func percent(sender:UIButton){
        NUM/=100;
        NUM_L=0;
        Refresh()
    }
    
    //计算函数，完成计算动作
    func Cal(){
        switch flag{
        case .plus:NUM_L+=NUM
        case .minus :NUM_L-=NUM
        case .multiply :NUM_L*=NUM
        case .division: NUM_L/=NUM
        case .blank:NUM_L=NUM
        default:Void()
        }
        NUM=NUM_L
        Point=false;//重置小数点状态
        site=10;
        flag=Calc.blank//重置计算状态
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Screen.textAlignment=NSTextAlignment.Right
        Screen.enabled=false;
        // Do any additional setup after loading the view, typically from a nib.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}



//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        resignFirstResponder()
////        TextC=Screen.text
////        var BIG=text.toInt()
////        TextC.removeRange(TextC.startIndex...TextC.find(TextC, "."))
//        //NUM
//        return true
//    }



//        count=count(text);
//        if text.hasSuffix(".0"){
//            text.removeAtIndex(i: String.Index)
//            //text.removeAtIndex(count(text))
//        }

////更新UITextField的内容
//func Refresh(){
//    text = "\(NUM)"
//    //var target=".0"
//    //if text.hasSuffix(target){
//    //var range=text.rangeOfString(target)
//    //text.stringByReplacingCharactersInRange(range!, withString: "")
//    //text.removeAtIndex(text.endIndex)
//    //}
//    println(text)
//    //res.stringByReplacingOccurrencesOfString(".0", withString: "" )
//    //println(res)
//    Screen.text=text;
//}