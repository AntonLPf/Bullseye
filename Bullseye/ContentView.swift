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
                print("Points awarded \(self.pointsForCurrentRound())")
                self.alertIsVisible = true
            }) {
                Text("Hit me!")
            }
            .alert(isPresented: self.$alertIsVisible) {
                Alert(title: Text("Hello there!"), message: Text(self.scoringMessage()), dismissButton: .default(Text("Awesome")))
            }
            
            Spacer()
            
//            Score row
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                    Text("Start over")
                }
                Spacer()
                Text("Score")
                Text("999999")
                Spacer()
                Text("Round:")
                Text("999")
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
        let difference: Int
        if Int(self.sliderValue.rounded()) > self.target {
            difference = sliderValueRounded - self.target
        } else if self.target > sliderValueRounded {
            difference = self.target - sliderValueRounded
        } else {
            difference = 0
        }
        return 100 - difference
    }
    
    func scoringMessage() -> String {
        return "The slider's value is \(self.sliderValueRounded).\n" + "The target value is \(self.target).\n" + "You scored \(self.pointsForCurrentRound()) points this"
    }
    
}

//MARK: Preview
//=============
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
