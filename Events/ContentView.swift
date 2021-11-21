//
//  ContentView.swift
//  Events
//
//  Created by Andrew Jaffee on 11/8/21.
/*
 
 Copyright (c) 2021 Andrew L. Jaffee, microIT Infrastructure, LLC, and
 iosbrain.com.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 
*/

import SwiftUI

let events = ["Wake up", "Breakfast", "Go to work", "Lunch", "Come home", "Go to sleep"]
let eventTimes = ["7:00 AM", "8:00 AM", "8:30 AM", "12:00 PM", "5:00 PM", "11:00 PM"]

struct ContentView: View {
    
    var body: some View {

        // Screen title
        Text("Daily Events").bold().italic().padding()
        
        // List of daily events with times
        Form {
            ForEach(0..<events.count) { event in
                Text("- \(events[event]) [ \(eventTimes[event]) ]")
            }
        }.padding().border(Color.blue)
        
    } // end body
    
} // end ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
