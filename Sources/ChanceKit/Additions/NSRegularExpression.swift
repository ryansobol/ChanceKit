import Foundation

// MARK: - Initialization

extension NSRegularExpression {
  convenience init(_ pattern: String) {
    do {
      try self.init(pattern: pattern, options: [])
    }
    catch {
      preconditionFailure("Illegal regular expression pattern: \(pattern)")
    }
  }
}

// MARK: - Extraction

extension NSRegularExpression {
  func firstMatch(in string: String) -> NSTextCheckingResult? {
    let range = NSRange(location: 0, length: string.utf16.count)

    return self.firstMatch(in: string, options: [], range: range)
  }
}
