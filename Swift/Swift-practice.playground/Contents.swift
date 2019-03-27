//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

class Car{
    var distant = 0
    var speed = 25
}
class Train:Car{
    override var speed: Int{
        didSet{
            distant = speed * 20 - speed
        }
    }
}

let train = Train()
print(train.speed)
train.speed = 30
print("如果汽車的速度為\(train.speed)，距離火車的距離為\(train.distant)")
let train1 = Train()
print(train1.speed)


var emojiDict = ["👻": "Ghost",
                 "💩": "Poop",
                 "😤": "Angray",
                 "😱": "Scream",
                 "👾": "Alien monster",
                 "123": "你好"]

var wordToLookup = "😱"
var meaning = emojiDict[wordToLookup]

let containerView = UIView(frame: CGRect(x: 0, y: 0, width: 300, height: 300))
containerView.backgroundColor = UIColor.orange

let emojiLabel = UILabel(frame: CGRect(x: 95, y: 20, width: 150, height: 150))
emojiLabel.text = wordToLookup
emojiLabel.font = UIFont.systemFont(ofSize: 100.0)

containerView.addSubview(emojiLabel)

let meaningLabel = UILabel(frame: CGRect(x: 100, y: 100, width: 150, height: 150))
meaningLabel.text = meaning
meaningLabel.font = UIFont.systemFont(ofSize: 30.0)
meaningLabel.textColor = UIColor.white
containerView.addSubview(meaningLabel)

wordToLookup = "🧢"
meaning = "Hat"

print(meaning)


