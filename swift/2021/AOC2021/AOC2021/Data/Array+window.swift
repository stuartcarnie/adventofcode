import Combine

extension Array {
    func window(count n: Int) -> Array<ArraySlice<Element>> {
        let windows = count - n + 1
        guard windows > 0 else { return [] }
        
        var slices = Array<ArraySlice<Element>>(repeating: ArraySlice<Element>(), count: windows)
        for start in 0..<windows {
            slices[start] = self[start..<start+n]
        }
        return slices
    }
}
