import Foundation
import CoreGraphics

final public class GridImage {
    let rangeX: ClosedRange<Int>
    let rangeY: ClosedRange<Int>
    let blockSize: Int
    let ctx: CGContext
    
    public convenience init(minX: CGFloat, maxX: CGFloat, minY: CGFloat, maxY: CGFloat, blockSize: Int) {
        self.init(minX: Int(minX), maxX: Int(maxX), minY: Int(minY), maxY: Int(maxY), blockSize: blockSize)
    }
    
    public init(minX: Int, maxX: Int, minY: Int, maxY: Int, blockSize: Int) {
        self.rangeX     = minX ... maxX
        self.rangeY     = minY ... maxY
        self.blockSize  = blockSize
        self.ctx        = CGContext(
            data: nil,
            width: self.rangeX.count*blockSize,
            height: self.rangeY.count*blockSize,
            bitsPerComponent: 8,
            bytesPerRow: self.rangeX.count*blockSize*4,
            space: CGColorSpaceCreateDeviceRGB(),
            bitmapInfo: CGImageAlphaInfo.premultipliedLast.rawValue)!
        
        ctx.scaleBy(x: CGFloat(blockSize), y: CGFloat(blockSize))
        ctx.translateBy(x: CGFloat(-minX), y: CGFloat(-minY))
    }
    
    public func block(p: CGPoint, color: CGColor) {
        ctx.setFillColor(color)
        let inset = 2.0 / CGFloat(blockSize) // 2 pixels
        ctx.fill(CGRect(origin: p, size: CGSize(width: 1, height: 1)).insetBy(dx: inset, dy: inset))
    }
    
    public func write(to url: URL) {
        ctx.write(to: url, type: .png)
    }
}
