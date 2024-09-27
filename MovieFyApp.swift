//
//  MovieFyApp.swift
//  MovieFy
//
//  Created by Efekan Güvendik on 25.09.2024.
//

import SwiftUI
import netfox

@main
struct MovieFyApp: App {
    
    @StateObject private var networkRequest = NetworkCallRequest()
    
    var body: some Scene {
        WindowGroup {
            HomeScreen()
                .onAppear{
                    #if DEBUG
                        NFX.sharedInstance().start()
                            #endif
            }
        }
    }
}


