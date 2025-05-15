//
//  ContentView.swift
//  Sentry In App Frames
//
//  Created by Denis Andrašec on 15.05.25.
//

import SwiftUI
import Sentry
import DynamicLib
import StaticLib

struct ContentView: View {
    
    let inAppFramesError: InAppFramesError
    
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, Sentry!")
            
            Button("Throw Current InAppFramesError: \(inAppFramesError)") {
                handleError()
            }
        }
        .padding()
    }
    
    func handleError() {
        do {
            switch inAppFramesError {
            case .staticError, .staticWithIncludeError, .staticWithExcludeError:
                StaticLib.foo()
            case .dynamicError, .dynamicWithIncludeError, .dynamicWithExcludeError:
                DynamicLib.bar()
            }
            throw inAppFramesError
        } catch {
            SentrySDK.capture(error: error)
        }
    }
}

