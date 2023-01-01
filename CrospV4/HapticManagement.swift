//
//  HapticManagement.swift
//  CrospV4
//
//  Created by Joshua Koshy on 12/31/22.
//

import SwiftUI

/*
Made the below functions using integer values and labels from:
https://developer.apple.com/documentation/uikit/uiimpactfeedbackgenerator/feedbackstyle
*/

let lightHapticobj = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: 0)!)
let mediumHapticobj = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: 1)!)
let heavyHapticobj = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: 2)!)
let softHapticobj = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: 3)!)
let rigidHapticobj = UIImpactFeedbackGenerator(style: UIImpactFeedbackGenerator.FeedbackStyle(rawValue: 4)!)
let notifyHapticObj = UINotificationFeedbackGenerator()


func lightHaptic() {
    lightHapticobj.prepare()
    lightHapticobj.impactOccurred()
}

func mediumHaptic() {
    mediumHapticobj.prepare()
    mediumHapticobj.impactOccurred()
}

func heavyHaptic() {
    heavyHapticobj.prepare()
    heavyHapticobj.impactOccurred()
}

func softHaptic() {
    softHapticobj.prepare()
    softHapticobj.impactOccurred()
}

func rigidHaptic() {
    rigidHapticobj.prepare()
    rigidHapticobj.impactOccurred()
}

func errorHaptic() {
    notifyHapticObj.prepare()
    notifyHapticObj.notificationOccurred(.error)
}

func successHaptic() {
    notifyHapticObj.prepare()
    notifyHapticObj.notificationOccurred(.success)
}

func warningHaptic() {
    notifyHapticObj.prepare()
    notifyHapticObj.notificationOccurred(.warning)
}
