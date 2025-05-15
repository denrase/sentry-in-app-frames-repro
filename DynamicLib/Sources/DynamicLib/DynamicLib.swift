// The Swift Programming Language
// https://docs.swift.org/swift-book

public class DynamicLib {
    public static func bar(callback: () -> Void) {
        print("bar \(Int.random(in: 1..<100))")
        callback()
    }
}
