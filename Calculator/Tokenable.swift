protocol Tokenable: CustomStringConvertible {
  func isEqualTo(_ other: Tokenable) -> Bool
}

// MARK: - where Self: Equatable

// Because a protocol cannot conform to another protocol with an associated type and the Equatable
// protocol has a Self associated type
// https://www.youtube.com/watch?v=g2LwFZatfTI?t=2236
// https://khawerkhaliq.com/blog/swift-protocols-equatable-part-one/
extension Tokenable where Self: Equatable {
  func isEqualTo(_ other: Tokenable) -> Bool {
    if let other = other as? Self {
      return self == other
    }

    return false
  }
}
