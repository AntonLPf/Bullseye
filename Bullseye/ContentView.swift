//
//  ContentView.swift
//  Bullseye
//
//  Created by Антон Шишкин on 17.09.2020.
//  Copyright © 2020 Антон Шишкин. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
//    MARK: Properties
//    ================
    
//    User interface views
    @State var alertIsVisible = false
    @State var sliderValue = 50.0
    @State var target = Int.random(in: 1...100)
    var sliderValueRounded: Int {
        Int(self.sliderValue.rounded())
    }
    @State var score = 0
    @State var round = 1
    
//    User interface content and layout
    var body: some View {
        VStack {
            Spacer()
//            Target row
            HStack {
                Text("Put the bullseye as close as you can to:")
                Text("\(self.target)")
            }
            
            Spacer()
            
//            Slider row
            HStack{
                Text("1")
                Slider(value: self.$sliderValue, in: 1...100)
                Text("100")
            }
            
//            Button row
            Button(action: {
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text(alertTitle()), message: Text(self.scoringMessage()), dismissButton: .default(Text("Awesome")) {
                    self.score += self.pointsForCurrentRound()
                    self.target = Int.random(in: 1...100)
                    self.round += 1
                }
                )
            }
            
            Spacer()
            
//            Score row
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start over")
                }
                Spacer()
                Text("Score")
                Text("\(self.score)")
                Spacer()
                Text("Round:")
                Text("\(self.round)")
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Info")
                }
            }
            .padding(.bottom, 20)
        }
    }
    
//    MARK: Methods
//    =============
    
    func pointsForCurrentRound() -> Int {
        let maximumScore = 100
        let difference = abs(self.sliderValueRounded - self.target)
        
        let bonus: Int
        if difference == 0 {
            bonus = 100
        } else if difference == 1 {
            bonus = 50
        } else {
            bonus = 0
        }
        
        return (maximumScore - difference) + bonus
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(self.sliderValueRounded).\n" + "The target value is \(self.target).\n" + "You scored \(self.pointsForCurrentRound()) points this"
    }
    
    func alertTitle() -> String {
        let difference: Int = abs(self.sliderValueRounded - self.target)
        let title: String
        if difference == 0 {
            title = "Perfect!"
        } else if difference < 5 {
            title = "You almost had it!"
        } else if difference <= 10 {
            title = "Not bad."
        } else {
            title = "Are you eve truing?"
        }
        return title
    }
    

    
}

//MARK: Preview
//=============
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
