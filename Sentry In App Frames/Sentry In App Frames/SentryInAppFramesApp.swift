//
//  SentryInAppFramesApp.swift
//  Sentry In App Frames
//
//  Created by Denis Andrašec on 15.05.25.
//

import SwiftUI
import Sentry

enum InAppFramesError: Error {
    case staticError
    case staticWithIncludeError
    case staticWithExcludeError
    
    case dynamicError
    case dynamicWithIncludeError
    case dynamicWithExcludeError
}

@main
struct SentryInAppFramesApp: App {
    
    let inAppFramesError: InAppFramesError
    
    init() {
        // Go though all errors and trigger them
        let inAppFramesError = InAppFramesError.staticError
        self.inAppFramesError = inAppFramesError
        
        SentrySDK.start { options in
            options.dsn = "https://6cc9bae94def43cab8444a99e0031c28@o447951.ingest.sentry.io/5428557"
            options.debug = true // Helpful to see what's going on
            
            switch inAppFramesError {
            case .staticError, .dynamicError:
                break;
            case .staticWithIncludeError:
                options.add(inAppInclude: "StaticLib")
            case .staticWithExcludeError:
                options.add(inAppExclude: "StaticLib")
            case .dynamicWithIncludeError:
                options.add(inAppInclude: "DynamicLib")
            case .dynamicWithExcludeError:
                options.add(inAppExclude: "DynamicLib")
            }
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView(inAppFramesError: inAppFramesError)
        }
    }
}
