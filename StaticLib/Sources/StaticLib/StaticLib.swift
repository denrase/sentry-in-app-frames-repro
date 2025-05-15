// The Swift Programming Language
// https://docs.swift.org/swift-book

public class StaticLib {
    public static func foo(callback: () -> Void) {
        callback()
    }
}
