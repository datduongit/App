import Foundation
import UIKit

extension UILabel {
    public func addBullet() {
        guard let string = self.text else { return }
        var updatedText: String = string
        
        // Turn any "paragraphs" (double-line breaks) into bullet points
        if string.contains("\n\n") {
            updatedText = string.replacingOccurrences(of: "\n\n",
                                                      with: "\n•   ")
        } else {
            // Turn any sentence ending with '.' or '!' into bullet points
            if let regex = try? NSRegularExpression(pattern: "(?<=[\\.!])[\\s]+(?=[A-Z])") {
                updatedText = regex.stringByReplacingMatches( in: string,
                                                              options: [],
                                                              range: NSRange(location: 0, length: string.count),
                                                              withTemplate: "\n•   " )
            }
        }
        updatedText = "•   \(updatedText)"
        
        // Create a mutable attributed string from our massaged text
        let formattedText = NSMutableAttributedString( string: updatedText)
        
        // Add our paragraph formatting to add nice spacing between and
        // hanging indents so our text lines up cleanly after the bullets
        formattedText.addAttributes([.paragraphStyle: createParagraphAttribute()],
                                    range: NSRange(location: 0, length: formattedText.length))
        
        // Assign resulting formatted text to the attributedText property
        self.attributedText = formattedText
    }
    
    private func createParagraphAttribute() -> NSParagraphStyle {
        // Start by creating a copy of default paragraph style
        // swiftlint:disable force_cast
        let paragraphStyle = NSParagraphStyle.default.mutableCopy()
            as! NSMutableParagraphStyle
        // swiftlint:enable force_cast
        
        // Add some "tabStops" to line up our bulletted text
        paragraphStyle.tabStops = [NSTextTab(
                                    textAlignment: .left,
                                    location: 11,
                                    options: [:])]
        paragraphStyle.defaultTabInterval = 11
        
        // Make the first line "head" indent 0. This positions the bullet
        // along the left, and any subsequent lines have a hanging indent
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 11
        
        // Add some line space between the bullet points
        paragraphStyle.paragraphSpacing = 10
        
        return paragraphStyle
    }
    
    public func heightForView(text: String?, font: UIFont?, width: CGFloat) -> CGFloat {
        let label: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}
