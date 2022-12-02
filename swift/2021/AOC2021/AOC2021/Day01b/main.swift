import Foundation

let windows = Day01.data.window(count: 3)

var gt = 0
for i in 1..<windows.count {
    if windows[i-1].reduce(0, &+) < windows[i].reduce(0, &+) {
        gt += 1
    }
}
print(gt)
