//
//  TimerBootcamp.swift
//  SwiftfulThinkingContinueLearning
//
//  Created by gs on 25/07/2023.
//

import SwiftUI

struct TimerBootcamp: View {
    
    let timer = Timer.publish(
        every: 0.1,
        on: .main,
        in: .common
    ).autoconnect()
    
    
    // Current time
    /*
    @State var currentDate: Date = Date()
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter
    }
     */
    
    //Countdown
    @State var count: Int = 10
    @State var finishedText: String? = nil
    
    // Countdown to date
    @State var timeRemaining: String = ""
    let futureDate: Date = Calendar.current.date(byAdding: .hour, value: 2, to: Date()) ?? Date()
    
    func updateTimeRemaining() {
        let remaining = Calendar.current.dateComponents([.hour, .minute, .second], from: Date(), to: futureDate)
        
        let hour = remaining.hour ?? 0
        let minute = remaining.minute ?? 0
        let second = remaining.second ?? 0
        timeRemaining = "\(hour): \(minute): \(second)"
        
    }

    
    // Animation
    @State var count1: Int = 0
    
    
    
    var body: some View {
        ZStack {
            RadialGradient(
                gradient: Gradient(colors: [Color.blue.opacity(0.4), Color.blue]),
                center: .center,
                startRadius: 5,
                endRadius: 500)
            
            VStack {
                
                Text(finishedText ?? "\(count)" )
                    .font(.system(size: 200, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .onReceive(timer, perform: {_ in
                        //currentDate = value
                        if count <= 1 {
                            finishedText = "Wow!"
                        } else {
                            count -= 1
                        }
                    })
                
                Spacer()
                Text(timeRemaining )
                    .font(.system(size: 50, weight: .semibold, design: .rounded))
                    .foregroundColor(.white)
                    .lineLimit(1)
                    .minimumScaleFactor(0.1)
                    .onReceive(timer) { _ in
                        updateTimeRemaining()
                    }
                Spacer()
                HStack(spacing: 25) {
                    Circle()
                        .offset(y:count1 == 1 ? -20 : 0)
                    Circle()
                        .offset(y:count1 == 2 ? -20 : 0)
                    Circle()
                        .offset(y:count1 == 3 ? -20 : 0)
                }
                .padding(.bottom, 50)
                .frame(width: 150)
                .foregroundColor(.white)
                .onReceive(timer, perform: { _ in
                    
                    /*if (count1 ==  3) {
                        count1 = 0
                    } else {
                        count1  += 1
                    }
                     */
                    withAnimation(.easeInOut(duration: 0.1)) {
                        count1 = count1 == 3 ? 0 : count1 + 1
                    }
                    
                    
                })
                
            }
                
            }
        
    }
}

struct TimerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        TimerBootcamp()
    }
}
