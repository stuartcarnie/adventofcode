import Foundation
import CoreGraphics
import ImageIO

extension CGContext {
    public enum MimeType {
        case png
        
        fileprivate var mimeType: CFString {
            switch self {
            case .png:
                return kUTTypePNG
            }
        }
    }
    
    @discardableResult
    public func write(to url: URL, type: MimeType) -> Bool {
        guard let img = self.makeImage() else { return false }
        guard let dest = CGImageDestinationCreateWithURL(url as CFURL, type.mimeType, 1, nil) else { return false }
        CGImageDestinationAddImage(dest, img, nil)
        CGImageDestinationFinalize(dest)
        return true
    }
}
