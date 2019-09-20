import Foundation

class AttributedStringManager {
    // supported tags
    private static let boldTag = "<b>"
    private static var customTag = "<custom>"
    private static var underlineTag = "<u>"
    
    // Underline attributes
    private static var underlineAttribute = [underlineTag: [NSAttributedString.Key.underlineStyle: 1.0]]
    
    static var supportedTags: [String: [NSAttributedString.Key: Any]] = underlineAttribute
    
    /// converts a string that contains any of the supported tags bold, underline or custom tag to a NSAttributedString
    /// attributesForBold is only required for bold<b> tag.
    /// attributesForCustom is only required for custom<custom> tag.
    /// - Parameters:
    ///   - stringWithTags: string that will be converted to attributed string. Should contain html tags or custom tag
    ///   - attributesForBold: required for bold tag because font size is unknown. Pass through [NSAttributedString.Key.font: BoldFont]
    ///   - attributesForCustom: required for custom tag
    static func convertStringToAttributedString(_ stringWithTags: String, attributesForBold: [NSAttributedString.Key: Any]? = nil, attributesForCustom: [NSAttributedString.Key: Any]? = nil) -> NSMutableAttributedString {
        handleAllTags(stringWithTags: stringWithTags, attributesForBold: attributesForBold, attributesForCustom: attributesForCustom)
    }
    
    private static func handleAllTags(stringWithTags: String, attributesForBold: [NSAttributedString.Key: Any]?, attributesForCustom: [NSAttributedString.Key: Any]?) -> NSMutableAttributedString {
        var attributedString: NSMutableAttributedString = NSMutableAttributedString(string: stringWithTags)
        supportedTags[boldTag] = attributesForBold
        supportedTags[customTag] = attributesForCustom
        
        for (tag, attributes) in supportedTags {
            handleTag(attributes, tag: tag, attributedString: &attributedString)
        }
        
        return attributedString
    }
    
    private static func handleTag(_ attributes: [NSAttributedString.Key: Any], tag: String, attributedString: inout NSMutableAttributedString) {
        let stringToFindRange = attributedString.string as NSString
        let openRange = stringToFindRange.range(of: tag)
        
        var closingTag = tag
        
        closingTag.insert("/", at: closingTag.index(after: closingTag.startIndex))
        var closedRange = stringToFindRange.range(of: closingTag)
        
        if openRange.location == NSNotFound {
            if closedRange.location != NSNotFound {
                // no open tag remove close tag
                removeTags(openRange: nil, closedRange: closedRange, attributedString: &attributedString)
            }
            // no open tag found exit function
            return
        }
        
        if closedRange.location == NSNotFound {
            // open tag but no matching closing bracket. Format string till end of string
            closedRange = NSRange(location: stringToFindRange.length, length: 0)
        }
        
        if openRange.location > closedRange.location {
            // open tag is after closing tag. Remove closing tag and start again.
            removeTags(openRange: nil, closedRange: closedRange, attributedString: &attributedString)
            handleTag(attributes, tag: tag, attributedString: &attributedString)
            return
        }
        
        removeTags(openRange: openRange, closedRange: closedRange, attributedString: &attributedString)
        
        let combinedRange = NSRange(location: openRange.location, length: closedRange.location - openRange.length - openRange.location)
        attributedString.addAttributes(attributes, range: combinedRange)
        
        handleTag(attributes, tag: tag, attributedString: &attributedString)
    }
    
    private static func removeTags(openRange: NSRange?, closedRange: NSRange?, attributedString: inout NSMutableAttributedString) {
        if let closeRange = closedRange {
            attributedString.deleteCharacters(in: closeRange)
        }
        if let startRange = openRange {
            attributedString.deleteCharacters(in: startRange)
        }
    }
}

