import CoreGraphics

extension CGPoint: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(self.x)
        hasher.combine(self.y)
    }
    
    public static func +=(_ lhs: inout CGPoint, _ rhs: CGVector) {
        lhs.x += rhs.dx
        lhs.y += rhs.dy
    }
}
