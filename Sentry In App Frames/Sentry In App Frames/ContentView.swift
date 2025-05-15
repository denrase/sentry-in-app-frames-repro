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
                anotherMethod()
            }
        }
        .padding()
    }
    
    func anotherMethod() {
        switch inAppFramesError {
        case .staticError:
            StaticLib.foo {
                handleError()
            }
        case .dynamicError, .dynamicWithIncludeError, .dynamicWithExcludeError:
            DynamicLib.bar {
                handleError()
            }
        }
    }
    
    func handleError() {
        do {
            throw inAppFramesError
        } catch {
            SentrySDK.capture(error: error)
        }
    }
}

