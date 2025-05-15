// The Swift Programming Language
// https://docs.swift.org/swift-book

public class DynamicLib {
    public static func bar(callback: () -> Void) {
        callback()
    }
}
