//: Playground - noun: a place where people can play

import UIKit
import XCPlayground

var color = UIColor.init(red: 0.337, green: 0.588, blue: 0.78, alpha: 1); // 0.572234762979684
var color2 = UIColor.init(red: 0.341, green:0.902, blue:0.675, alpha: 1); // 0.4325609031491384
var color3 = UIColor.init(red: 0.878, green: 0.553, blue: 0.675, alpha: 1); // 0.9374358974358974
let name = "pink"
var hue: CGFloat = 0;
var sat: CGFloat = 0;
var bri: CGFloat = 0;
var alpha: CGFloat = 1;
var hue2: CGFloat = 0;
var sat2: CGFloat = 0;
var bri2: CGFloat = 0;
var alpha2: CGFloat = 1;
var hue3: CGFloat = 0;
var sat3: CGFloat = 0;
var bri3: CGFloat = 0;
var alpha3: CGFloat = 1;
color.getHue(&hue, saturation: &sat, brightness: &bri, alpha: &alpha);
hue
sat
bri

color2.getHue(&hue2, saturation: &sat2, brightness: &bri2, alpha: &alpha2);
color3.getHue(&hue3, saturation: &sat3, brightness: &bri3, alpha: &alpha3);

bri2
bri3

var round:Double = 1;
let time = 5

let mult:Double = -0.035
var comult = (Double)(hue)
if comult >= 0.5 {
    comult -= 0.5
} else {
    comult /= 3
}
var coef:Double = 0.015*1/Double(bri)
var coef2: Double = 0.020*1/Double(bri2);
var coef3: Double = 0.020*1/Double(bri3)
coef = 0.016
coef2 = 0.022
coef3 = 0.020
//switch (name) {
//    case "blue":
//        coef = 0.015*1/Double(bri)
//        break;
//    case "green":
//        coef = 0.020*1/Double(bri);
//        break;
//    case "pink":
//        coef = 0.020*1/Double(bri);
//        break;
//default:
//    break;
//}
//let coef:Double = 0.025

for index in 1...100 {
    let varyH:CGFloat = (CGFloat)((coef*pow(M_E, mult * (Double)(index)) + 0.005));
    let varyH2:CGFloat = (CGFloat)((coef2*pow(M_E, mult * (Double)(index)) + 0.005));
    let varyH3:CGFloat = (CGFloat)((coef3*pow(M_E, mult * (Double)(index)) + 0.005));
    var score = time + (Int)(abs(15*log(varyH))-56)
    var score2 = time + (Int)(abs(15*log(varyH2))-56)
    var score3 = time + (Int)(abs(15*log(varyH3))-56)
    abs(15*log(abs(varyH))) - 56
}
//var varyH:CGFloat = (CGFloat)((coef*pow(M_E, mult*round) + 0.005) * pow((Double)(-1), (Double)(arc4random()%2)));
var varyH:CGFloat = (CGFloat)((coef*pow(M_E, mult*round) + 0.005))
var varyH2:CGFloat = (CGFloat)((coef2*pow(M_E, mult*round) + 0.005))
var varyH3:CGFloat = (CGFloat)((coef3*pow(M_E, mult*round) + 0.005))

hue
let newCol = hue+varyH;

var discolored = UIColor.init(hue: hue+varyH, saturation: sat, brightness: bri, alpha: alpha);
var discolored2 = UIColor.init(hue: hue2+varyH2, saturation: sat2, brightness: bri2, alpha: alpha2);
var discolored3 = UIColor.init(hue: hue3+varyH3, saturation: sat3, brightness: bri3, alpha: alpha3);

var containerView = UIView(frame: CGRectMake(0,0,505,760));

containerView.backgroundColor = UIColor.whiteColor();

let colorView = UIView(frame: CGRectMake(0,0,250,250));
colorView.backgroundColor = color;
let discolorView = UIView(frame: CGRectMake(255,0,250,250));
discolorView.backgroundColor = discolored;

let colorView2 = UIView(frame: CGRectMake(0,255,250,250));
colorView2.backgroundColor = color2;
let discolorView2 = UIView(frame: CGRectMake(255,255,250,250));
discolorView2.backgroundColor = discolored2;

let colorView3 = UIView(frame: CGRectMake(0,510,250,250));
colorView3.backgroundColor = color3;
let discolorView3 = UIView(frame: CGRectMake(255,510,250,250));
discolorView3.backgroundColor = discolored3;

containerView.addSubview(colorView);
containerView.addSubview(discolorView);
containerView.addSubview(colorView2);
containerView.addSubview(discolorView2);
containerView.addSubview(colorView3);
containerView.addSubview(discolorView3);
//XCPlaygroundPage.currentPage.liveView = containerView;
