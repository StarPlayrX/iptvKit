//
//  Extensions.swift
//  IPTVee
//
//  Created by Todd Bruss on 10/3/21.
//

import Foundation
import SwiftUI

extension RangeReplaceableCollection where Self: StringProtocol {
    var digits: Self { filter(\.isWholeNumber) }
}

extension DispatchQueue {
    
    static func background(delay: Double = 0.0, background: (()->Void)? = nil, completion: (() -> Void)? = nil) {
        DispatchQueue.global(qos: .background).async {
            background?()
            if let completion = completion {
                DispatchQueue.main.asyncAfter(deadline: .now() + delay, execute: {
                    completion()
                })
            }
        }
    }
}

public extension String {
    var base64Decoded: String? {
         String(data: Data(base64Encoded: self) ?? Data(), encoding: .utf8)
    }
}

public extension String {
    func removingLeadingSpaces() -> String {
        guard let index = firstIndex(where: { !CharacterSet(charactersIn: String($0)).isSubset(of: .whitespaces) }) else {
            return self
        }
        return String(self[index...])
    }
}

public extension String {

    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?
    {

        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.locale = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        return date

    }
}

//"MMM dd yyyy h:mm a"
public extension Date {
    func toString(withFormat format: String = "h:mm a") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.timeZone = .current
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let str = dateFormatter.string(from: self)
        return str
    }
}


extension UIImage {

    func squareMe() -> UIImage {

        var squareImage = self
        let maxSize = max(self.size.height, self.size.width)
        let squareSize = CGSize(width: maxSize, height: maxSize)

        let dx = CGFloat((maxSize - self.size.width) / 2)
        let dy = CGFloat((maxSize - self.size.height) / 2)

        UIGraphicsBeginImageContext(squareSize)
        var rect = CGRect(x: 0, y: 0, width: maxSize, height: maxSize)

        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.systemGray6.cgColor)
            context.fill(rect)

            rect = rect.insetBy(dx: dx, dy: dy)
            self.draw(in: rect, blendMode: .normal, alpha: 1.0)

            if let img = UIGraphicsGetImageFromCurrentImageContext() {
                squareImage = img
            }
            UIGraphicsEndImageContext()

        }

        return squareImage
    }

}
