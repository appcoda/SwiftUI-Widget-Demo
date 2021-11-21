//
//  EventTimes.swift
//  EventTimes
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

import WidgetKit
import SwiftUI

let events = ["Wake up", "Breakfast", "Go to work", "Lunch", "Come home", "Go to sleep"]
let eventTimes = ["7:00 AM", "8:00 AM", "8:30 AM", "12:00 PM", "5:00 PM", "11:00 PM"]
var currentEvent = 0

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), eventName: "Daily event", eventTime: "N/A")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), eventName: events[currentEvent], eventTime: eventTimes[currentEvent])
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of six entries an second apart, starting from the current time.
        let currentDate = Date()
        
        for timeOffset in 0 ..< events.count {
            let entryDate = Calendar.current.date(byAdding: .second, value: timeOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, eventName: events[timeOffset], eventTime: eventTimes[timeOffset])
            entries.append(entry)
        }
        currentEvent = 0
        
        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    } // end getTimeline

} // end TimelineProvider

struct SimpleEntry: TimelineEntry {
    let date: Date
    let eventName: String
    let eventTime: String
}

struct EventTimesEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text(entry.eventTime)
            Text(entry.eventName)
        }
    }
} // end EventTimesEntryView

@main
struct EventTimes: Widget {
    let kind: String = "EventTimes"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            EventTimesEntryView(entry: entry)
        }
        .configurationDisplayName("My Daily Events")
        .description("Shows my typical workday schedule.")
    }
} // end EventTimes

struct EventTimes_Previews: PreviewProvider {
    static var previews: some View {
        EventTimesEntryView(entry: SimpleEntry(date: Date(), eventName: events[currentEvent], eventTime: eventTimes[currentEvent]))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
