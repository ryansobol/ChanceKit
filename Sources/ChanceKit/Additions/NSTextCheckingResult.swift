import Foundation

// MARK: - Extraction

extension NSTextCheckingResult {
	func substring(at idx: Int, in string: String) -> Substring? {
		guard let range = Range(self.range(at: idx), in: string) else {
			return nil
		}

		return string[range]
	}
}
