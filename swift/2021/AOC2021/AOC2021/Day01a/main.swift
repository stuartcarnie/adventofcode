import Foundation

var gt = 0
for i in 1..<Day01.data.count {
    if Day01.data[i-1] < Day01.data[i] {
        gt += 1
    }
}
print(gt)
