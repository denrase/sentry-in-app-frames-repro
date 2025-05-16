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
    case dynamicError
    case dynamicWithIncludeError
    case dynamicWithExcludeError
}

@main
struct SentryInAppFramesApp: App {
    
    let inAppFramesError: InAppFramesError
    
    init() {
        // Go though all errors and trigger them
        let inAppFramesError = InAppFramesError.dynamicWithExcludeError
        self.inAppFramesError = inAppFramesError
        
        SentrySDK.start { options in
            options.dsn = "https://993ec28dc35face1e9a950ae87f3084d@o447951.ingest.us.sentry.io/4509327016919040"
            options.debug = true // Helpful to see what's going on
            
            switch inAppFramesError {
            case .staticError, .dynamicError:
                break;
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
