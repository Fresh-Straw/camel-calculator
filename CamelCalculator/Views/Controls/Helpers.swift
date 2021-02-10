//
//  Helpers.swift
//  CamelCalculator
//
//  Created by Olaf Neumann on 10.01.21.
//

import SwiftUI

func runCounter(counter: Binding<Int>, start: Int, end: Int, speed: Double) {
    counter.wrappedValue = start

    Timer.scheduledTimer(withTimeInterval: speed, repeats: true) { timer in
        counter.wrappedValue += 1
        if counter.wrappedValue == end {
            timer.invalidate()
        }
    }
}
