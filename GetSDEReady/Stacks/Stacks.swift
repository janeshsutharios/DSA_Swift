// https://getsdeready.com/courses/dsa/lesson/valid-parentheses/
// https://leetcode.com/problems/valid-parentheses/description/
class Solution {
    func isValid(_ s: String) -> Bool {
        guard s.count % 2 == 0 else { return false }
        
        var stack: [Character] = []
        // Here we are maintaing stack . adding element with close bracket & removing values from stack if the braces not matched.
        for ch in s {
            switch ch {
            case "(": stack.append(")")
            case "[": stack.append("]")
            case "{": stack.append("}")
            default:
                // Return false for unbalanced stack
                if stack.isEmpty || stack.removeLast() != ch {
                    return false
                }
            }
        }
        return stack.isEmpty
    }
}


// https://getsdeready.com/courses/dsa/lesson/remove-all-adjacent-duplicates-in-string/
// https://leetcode.com/problems/remove-all-adjacent-duplicates-in-string/description/
func removeDuplicates(_ s: String) -> String {
    var stack = [Character]() // Use a stack to keep characters that are not removed

    for char in s {
        // If the top of the stack is the same as current char, it's a duplicate → remove it
        if stack.last == char {
            stack.removeLast()
        } else {
            // Else, push the current char to the stack
            stack.append(char)
        }
    }

    // Convert final character array (stack) back to a string and return
    return String(stack)
}

// https://getsdeready.com/courses/dsa/lesson/next-greater-element-i/
// https://leetcode.com/problems/next-greater-element-i/description/
class Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var result: [Int] = []

        for num in nums1 {
            var found = -1
            // Find index of num in nums2
            if let index = nums2.firstIndex(of: num) {
                // Scan to the right to find the next greater element
                for i in (index + 1)..<nums2.count {
                    if nums2[i] > num {
                        found = nums2[i]
                        break
                    }
                }
            }
            result.append(found)
        }
        return result
    }
}
// Soution 2 using Stacks 
class Solution {
    func nextGreaterElement(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var stack: [Int] = []
        var nextGreater: [Int: Int] = [:]

        for num in nums2 {
            // Maintain decreasing stack
            while let last = stack.last, num > last {
                nextGreater[stack.removeLast()] = num
            }
            stack.append(num)
        }

        // For remaining elements in stack, no next greater
        for num in stack {
            nextGreater[num] = -1
        }

        // Build result for nums1
        return nums1.map { nextGreater[$0] ?? -1 }
    }
}
// https://getsdeready.com/courses/dsa/lesson/number-of-students-unable-to-eat-lunch/
// https://leetcode.com/problems/number-of-students-unable-to-eat-lunch/description/
class Solution {
    func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
        // 0th index who prefers circular sandwich & 1st index prefers square sandwich
        var studentPreferences: [Int] = [0,0]
        // Now insert count of circular & square sandwiches
        for student in students {
            studentPreferences[student] += 1
        }

        // Iterate over sandwiches which students can eat 

        for sandwitch in sandwiches {
            // If no student prefer to eat partcular sandwitch 
            /* Test case students =    [1,1,1,0,0] sandwiches =  [0,0,0,1,1] */
            if studentPreferences[sandwitch] == 0 {
                break
            }
            studentPreferences[sandwitch] -= 1
        }
        return studentPreferences[0] + studentPreferences[1]
    }
}  
    /* Approach 2 
func countStudents(_ students: [Int], _ sandwiches: [Int]) -> Int {
    var students = students
    var sandwiches = sandwiches
    var count = 0 // tracks how many students rotated without eating

    while !students.isEmpty && count < students.count {
        if students[0] == sandwiches[0] {
            // student takes sandwich
            students.removeFirst()
            sandwiches.removeFirst()
            count = 0
        } else {
            // student goes to end
            let student = students.removeFirst()
            students.append(student)
            count += 1
        }
    }

    return students.count // remaining students who couldn’t eat
}
*/
// https://getsdeready.com/courses/dsa/lesson/remove-all-adjacent-duplicates-in-string/
// https://leetcode.com/problems/remove-all-adjacent-duplicates-in-string/description/
func removeDuplicates(_ s: String) -> String {
    var stack = [Character]() // Use a stack to keep characters that are not removed

    for char in s {
        // If the top of the stack is the same as current char, it's a duplicate → remove it
        if stack.last == char {
            stack.removeLast()
        } else {
            // Else, push the current char to the stack
            stack.append(char)
        }
    }

    // Convert final character array (stack) back to a string and return
    return String(stack)
}

// https://getsdeready.com/courses/dsa/lesson/evaluate-expression/
class Solution {
    func evalRPN(_ tokens: inout [String]) -> Int {
        var stack = [Int]()  // Stack to store operands
        
        for token in tokens {
            // If the token is a number, push it to the stack
            if let number = Int(token) {
                stack.append(number)
            } else {
                // Token is an operator, pop two operands from stack
                let rightOperand = stack.removeLast()
                let leftOperand = stack.removeLast()
                
                // Apply the operation and push result back to stack
                let result: Int
                switch token {
                case "+":
                    result = leftOperand + rightOperand
                case "-":
                    result = leftOperand - rightOperand
                case "*":
                    result = leftOperand * rightOperand
                case "/":
                    result = leftOperand / rightOperand  // Integer division
                default:
                    fatalError("Unsupported operator: \(token)")
                }
                
                stack.append(result)
            }
        }
        
        // The final result is the only item left in the stack
        return stack.last!
    }
}
// https://getsdeready.com/courses/dsa/lesson/min-stack/
// https://leetcode.com/problems/min-stack/description/
class MinStack {
    // Two stacks: one for all elements, one for tracking the minimum element
    private var stack: [Int]
    private var minStack: [Int]

    // Initializer to set up the stacks
    init() {
        stack = []
        minStack = []
    }

    // Push element x onto stack
    func push(_ x: Int) {
        stack.append(x)
        // If minStack is empty or x is less than or equal to the current minimum, push it onto minStack
        if minStack.isEmpty || x <= minStack.last! {
            minStack.append(x)
        }
    }

    // Remove the element on top of the stack
    func pop() {
        // If the top element is the same as the top of minStack, pop from minStack as well
        if stack.last == minStack.last {
            minStack.removeLast()
        }
        stack.removeLast()
    }

    // Get the top element
    func top() -> Int {
        return stack.last ?? -1
    }

    // Retrieve the minimum element in the stack
    func getMin() -> Int {
        return minStack.last ?? -1
    }
}
// https://getsdeready.com/courses/dsa/lesson/largest-rectangle-in-histogram/
// https://leetcode.com/problems/largest-rectangle-in-histogram/
class Solution {
    // ALGO: Monotonically Increasing Stack
    // TIME Complexity: O(N)
    // TIME Complexity: O(N)
    func largestRectangleArea(_ heights: [Int]) -> Int {
        // Initialize a stack to store indices of heights, and add -1 as a sentinel value.
        var stack: [Int] = [-1]
        let length = heights.count
        var maxArea = 0

        // Iterate through the heights array.
        for i in 0..<length {
            // While the stack is not empty (except for the sentinel) and the current height is less than or equal to the height at the top of the stack,
            while stack.last != -1 && heights[stack.last!] >= heights[i] {

                // Calculate the area of the rectangle formed by the height at the top of the stack.
                let currentHeight = heights[stack.removeLast()]

                // The width is the difference between the current index and the index of the previous smaller height (or -1 if none).
                let currentWidth = i - stack.last! - 1

                // Update the maximum area.
                maxArea = max(maxArea, currentHeight * currentWidth)
            }
            stack.append(i)
        }

        // Process any remaining heights in the stack.
        while stack.last != -1 {
            // Calculate the area of the rectangle formed by the height at the top of the stack.
            let currentHeight = heights[stack.removeLast()]

            // The width is the difference between the end of the array and the index of the previous smaller height (or -1 if none).
            let currentWidth = length - stack.last! - 1

            // Update the maximum area.
            maxArea = max(maxArea, currentHeight * currentWidth)
        }

        // Return the maximum area.
        return maxArea
    }
}
// https://getsdeready.com/courses/dsa/lesson/trapping-rain-water-2/
// https://leetcode.com/problems/trapping-rain-water/
/*
At each step, we compare the left and right bar heights.
We always process the shorter side, because water trapped depends on the shorter boundary.
We maintain the maximum height seen so far from each side.
If the current bar is shorter than the max seen, it can trap water (maxSoFar - currentHeight).
We move the pointer inward and keep adding trapped water.
*/
class Solution {
    func trap(_ height: [Int]) -> Int {
        var leftIndex = 0
        var rightIndex = height.count - 1
        var maxLeftHeight = height[leftIndex]
        var maxRightHeight = height[rightIndex]
        var totalTrappedWater = 0
        
        while leftIndex < rightIndex {
            if height[leftIndex] < height[rightIndex] {
                maxLeftHeight = max(maxLeftHeight, height[leftIndex])
                totalTrappedWater += maxLeftHeight - height[leftIndex]
                leftIndex += 1
            } else {
                maxRightHeight = max(maxRightHeight, height[rightIndex])
                totalTrappedWater += maxRightHeight - height[rightIndex]
                rightIndex -= 1
            }
        }
        
        return totalTrappedWater
    }
}

// https://getsdeready.com/courses/dsa/lesson/nearest-smaller-element/
// https://www.interviewbit.com/problems/matrix-search/
| Formula            | Meaning                                        |
| ------------------ | ---------------------------------------------- |
| `row = mid / cols` | Finds which row (floor) the element belongs to |
| `col = mid % cols` | Finds which column (rack) inside that row      |

class Solution {
    func searchMatrix(_ A: inout [[Int]], _ B: inout Int) -> Int {
        // Total number of rows
        let rows = A.count
        guard rows > 0 else { return 0 } // If matrix is empty, return 0
        
        // Total number of columns
        let cols = A[0].count
        guard cols > 0 else { return 0 } // If there are no columns, return 0
        
        // Treat the matrix as a flattened sorted array
        var left = 0
        var right = rows * cols - 1
        
        // Perform binary search
        while left <= right {
            // Middle index in the "flattened" array
            let mid = left + (right - left) / 2
            
            // Map the flattened index to 2D indices
            let row = mid / cols
            let col = mid % cols
            
            // Get the element at the mapped position
            let value = A[row][col]
            
            if value == B {
                // Found the target
                return 1
            } else if value < B {
                // Target is on the right side
                left = mid + 1
            } else {
                // Target is on the left side
                right = mid - 1
            }
        }
        
        // If we exit the loop, element not found
        return 0
    }
}

