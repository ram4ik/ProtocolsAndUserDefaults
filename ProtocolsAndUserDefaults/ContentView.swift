//
//  ContentView.swift
//  ProtocolsAndUserDefaults
//
//  Created by ramil on 25.08.2020.
//

import SwiftUI

enum Constant {
    enum UserDefaults {
        enum Key: String {
            case highScore
            
            var value: String {
                return rawValue
            }
        }
    }
}

protocol Savable {
    func set<T>(_ value: T, forKey: Constant.UserDefaults.Key)
    func integer(forKey key: Constant.UserDefaults.Key) -> Int
}

extension Savable {
    func set<T>(_ value: T, forKey key: Constant.UserDefaults.Key) {
        UserDefaults.standard.set(value, forKey: key.value)
        UserDefaults.standard.synchronize()
    }
    
    func integer(forKey key: Constant.UserDefaults.Key) -> Int {
        UserDefaults.standard.integer(forKey: key.value)
    }
}

struct ContentViewModel: Savable {
    func saveHighScore(_ highScore: Int) {
        set(highScore, forKey: .highScore)
    }
    
    func getHighScore() -> Int {
        integer(forKey: .highScore)
    }
}

struct ContentView: View, Savable {
    private let viewModel = ContentViewModel()
    
    var body: some View {
        Text("\(integer(forKey: .highScore))")
            .padding()
            .onTapGesture(count: 1, perform: {
                self.set(42, forKey: .highScore)
            })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
