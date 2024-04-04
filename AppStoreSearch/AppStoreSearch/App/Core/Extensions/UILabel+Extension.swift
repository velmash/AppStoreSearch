//
//  UILabel+Extension.swift
//  AppStoreSearch
//
//  Created by 윤형찬 on 4/2/24.
//

import UIKit

extension UILabel {
    func isTextTruncated() -> Bool {
        guard let text = self.text, let font = self.font else {
            return false
        }
        
        let labelWidth = self.bounds.width
        let labelNumberOfLines = CGFloat(self.numberOfLines)
        
        let textAttributes: [NSAttributedString.Key: Any] = [.font: font]
        let attributedText = NSAttributedString(string: text, attributes: textAttributes)
        
        let drawingOptions: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        let sizeConstraint = CGSize(width: labelWidth, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingRect = attributedText.boundingRect(with: sizeConstraint, options: drawingOptions, context: nil)
        
        // UILabel의 최대 높이 계산
        let maxLabelHeight = font.lineHeight * labelNumberOfLines
        
        // 실제 텍스트가 차지하는 높이와 UILabel의 최대 높이를 비교
        return boundingRect.height > maxLabelHeight
    }
    
}


