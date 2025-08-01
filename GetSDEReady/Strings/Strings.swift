// Question - https://getsdeready.com/courses/dsa/lesson/repeated-substring-pattern/
// Answer - https://claude.ai/public/artifacts/ec97db0e-8270-4b83-89bc-de66c54e1f60
//https://leetcode.com/problems/repeated-substring-pattern/
class Solution {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        let n = s.count                     // Total length of the string
        let chars = Array(s)               // Convert string to array of characters for easy indexing

        // Try all possible substring lengths from 1 to n/2
        for index in 1..<(n / 2 + 1) {
            // The total length must be divisible by the substring length
            // Otherwise, it cannot be repeated evenly
            if n % index != 0 {
                // we’re just saying "this length can't be valid, try next".
                // Example s = "abcabcabc"   // n = 9
                continue
            }

            var match = true               // Assume it's a match unless proven otherwise

            // Start comparing from index 'index' up to 'n-1'
            for i in index..<n {
                  // ✅ Can you cut 12 meters into 3-meter pieces? Yes! (12 % 3 == 0)
                //❌ Can you cut it into 5-meter pieces? No! (12 % 5 == 2)
                if chars[i] != chars[i % index] {
                    match = false          // Mismatch found
                    break                  // No need to continue this pattern length
                }
            }

            if match {
                return true                // Found a valid repeating pattern
            }
        }

        return false                       // No valid repeating pattern found
    }
}
// Solution #2: Swift way 
/*
class Solution {
    func repeatedSubstringPattern(_ s: String) -> Bool {
        let doubled = s + s
        let trimmed = doubled.dropFirst().dropLast()
        return trimmed.contains(s)
    }
}
*/

// 
// https://leetcode.com/problems/valid-palindrome-ii/description/
class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let chars = Array(s)
        var left = 0
        var right = chars.count - 1

        // Helper function to check if a substring is palindrome
        func isPalindrome(_ l: Int, _ r: Int) -> Bool {
            var i = l, j = r
            while i < j {
                if chars[i] != chars[j] {
                    return false
                }
                i += 1
                j -= 1
            }
            return true
        }

        while left < right {
            if chars[left] != chars[right] {
                // Try skipping either left or right character
                return isPalindrome(left + 1, right) || isPalindrome(left, right - 1)
            }
            left += 1
            right -= 1
        }

        return true
    }
}

class Solution {
    func validPalindrome(_ s: String) -> Bool {
        let chars = Array(s)
        var left = 0
        var right = chars.count - 1

        // Helper function to check if a substring is palindrome
        func isPalindrome(_ l: Int, _ r: Int) -> Bool {
            var i = l, j = r
            while i < j {
                if chars[i] != chars[j] {
                    return false
                }
                i += 1
                j -= 1
            }
            return true
        }

        while left < right {
            if chars[left] != chars[right] {
                // Try skipping either left or right character
                return isPalindrome(left + 1, right) || isPalindrome(left, right - 1)
            }
            left += 1
            right -= 1
        }

        return true
    }
}


// In this way we can find the dropped characer 
func validPalindrome(_ s: String) -> Bool {
    let chars = Array(s)
    var left = 0
    var right = chars.count - 1
    
    // Helper function to check if a substring is palindrome
    func isPalindrome(_ l: Int, _ r: Int, dropped: Character) -> Bool {
        var i = l, j = r
        while i < j {
            if chars[i] != chars[j] {
                return false
            }
            i += 1
            j -= 1
        }
        print("Found by dropping ", dropped)
        return true
    }
    
    while left < right {
        if chars[left] != chars[right] {
            // Try skipping either left or right character
            return isPalindrome(left + 1, right, dropped: chars[left]) || isPalindrome(left, right - 1, dropped: chars[right])
        }
        left += 1
        right -= 1
    }
    
    return true
}

// https://getsdeready.com/courses/dsa/lesson/find-common-characters/
// https://leetcode.com/problems/find-common-characters/
class Solution {
    func commonChars(_ words: [String]) -> [String] {
        // Initialize a frequency array with max values for 26 lowercase letters
        var minFreq = [Int](repeating: Int.max, count: 26)

        // For each word, calculate the frequency of each character
        for word in words {
            var freq = [Int](repeating: 0, count: 26)

            // Count frequency of each character in current word
            for char in word {
                let index = Int(char.asciiValue! - Character("a").asciiValue!)
                freq[index] += 1
            }
            print("   freq", freq)
            // Update the global minFreq with minimum count for each character
            for i in 0..<26 {
                minFreq[i] = min(minFreq[i], freq[i])
            }
            print("minFreq", minFreq)
        }

        // Build the result using characters that have frequency > 0 in all words
        var result = [String]()
        for i in 0..<26 {
            // Append the character as many times as it appears commonly
            for _ in 0..<minFreq[i] {// will only executes for 1,2 i.e. e & l,l
                let char = Character(UnicodeScalar(i + Int(Character("a").asciiValue!))!)
                result.append(String(char))// Adds ["e", "l", "l"]
            }
        }
        return result
    }
}
print(Solution().commonChars(["bella","label","roller"]))
prints -
   freq [1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
minFreq [1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
   freq [1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
minFreq [1, 1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
   freq [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 1, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0]
minFreq [0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
["e", "l", "l"]

// https://getsdeready.com/courses/dsa/lesson/check-if-a-word-occurs-as-a-prefix-of-any-word-in-a-sentence/
// https://leetcode.com/problems/check-if-a-word-occurs-as-a-prefix-of-any-word-in-a-sentence/description/
class Solution {
    func isPrefixOfWord(_ sentence: String, _ searchWord: String) -> Int {
        // Split the sentence into words
        let words = sentence.split(separator: " ")

        // Iterate over the words with their index
        for (index, word) in words.enumerated() {
            // Check if the word starts with the searchWord
            if word.hasPrefix(searchWord) {
                // Return 1-based index
                return index + 1
            }
        }

        // If no prefix match found
        return -1
    }
}
// https://getsdeready.com/courses/dsa/lesson/day-of-the-year-2/ 
// https://leetcode.com/problems/day-of-the-year/description/
class Solution {
    func dayOfYear(_ date: String) -> Int {
        let parts = date.split(separator: "-").map { Int($0)! }
        let year = parts[0], month = parts[1], day = parts[2]
        /* Or 
        // Extract substrings using ranges
        let year = Int(date.prefix(4))! // "YYYY"
        let month = Int(date[date.index(date.startIndex, offsetBy: 5)...date.index(date.startIndex, offsetBy: 6)])! // "MM"
        let day = Int(date.suffix(2))! // "DD"
        */
        // Days in each month. February is 28 or 29 depending on leap year.
        let monthDays = [31, isLeapYear(year) ? 29 : 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

        var total = 0
        for i in 0..<month - 1 {
            total += monthDays[i]
        }

        return total + day
    }

    func isLeapYear(_ year: Int) -> Bool {
        // ✅ Rule 1: Divisible by 4 (e.g., 2004)
        // ❌ Rule 2: Not divisible by 100 (e.g., 1900 is NOT a leap year)
        // ✅ Rule 3: If divisible by 400, then leap year (e.g., 2000)
        return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)
        
        // Explanation with real years:
        // year = 2004 → true (divisible by 4, not by 100)
        // year = 1900 → false (divisible by 100 but not by 400)
        // year = 2000 → true (divisible by 400)
    }
}

// https://getsdeready.com/courses/dsa/lesson/longest-common-prefix/
// https://leetcode.com/problems/longest-common-prefix/
// Solution #1 Horizontal scaling. 
class Solution {
    func longestCommonPrefix(_ strs: [String]) -> String {
        // Return early if the array is empty
        guard !strs.isEmpty else {
            return ""
        }

        // Start with the first string as the initial common prefix
        var commonPrefix = strs[0]

        // Iterate over the remaining strings
        for currentString in strs.dropFirst() {
            // Shorten the prefix until the current string starts with it
            while !currentString.hasPrefix(commonPrefix) {
                // Remove the last character from the common prefix
                commonPrefix = String(commonPrefix.dropLast())

                // If the prefix becomes empty, no common prefix exists
                if commonPrefix.isEmpty {
                    return ""
                }
            }
        }

        return commonPrefix
    }
}
// Solution #2 verticle scanning
class Solution {
    func longestCommonPrefix(_ words: [String]) -> String {
        // Return early if input is empty
        guard let firstWord = words.first else {
            return ""
        }

        // Iterate over characters in the first word
        for characterIndex in firstWord.indices {
            let currentCharacter = firstWord[characterIndex]

            for word in words.dropFirst() {
                // If index is out of bounds or character mismatch
                if characterIndex >= word.endIndex || word[characterIndex] != currentCharacter {
                    return String(firstWord[..<characterIndex])
                }
            }
        }

        // All characters matched
        return firstWord
    }
}
/*
 | Index | `flower` | `flow` | `flight` | Match? | Common Prefix |
 | ----- | -------- | ------ | -------- | ------ | ------------- |
 | 0     | **f**    | **f**  | **f**    | ✅      | "f"           |
 | 1     | **l**    | **l**  | **l**    | ✅      | "fl"          |
 | 2     | **o**    | **o**  | **i**    | ❌      | **Stop here** |

 */

// https://getsdeready.com/courses/dsa/lesson/compare-version-numbers/
// https://leetcode.com/problems/compare-version-numbers/

class Solution {
    func compareVersion(_ version1: String, _ version2: String) -> Int {
        // ✅ Step 1: Split both version strings by '.' and convert components to integers
        let parts1 = version1.split(separator: ".").map { Int($0)! }
        let parts2 = version2.split(separator: ".").map { Int($0)! }

        // ✅ Step 2: Determine how many total components we need to compare
        let maxLength = max(parts1.count, parts2.count)

        // ✅ Step 3: Loop through each corresponding version component
        for i in 0..<maxLength {
            // Use 0 for missing components if one version has fewer parts
            let component1 = i < parts1.count ? parts1[i] : 0
            let component2 = i < parts2.count ? parts2[i] : 0

            // ✅ Step 4: Compare the two components
            if component1 > component2 {
                return 1  // version1 is greater
            } else if component1 < component2 {
                return -1 // version2 is greater
            }
            // If equal, continue to next component
        }

        // ✅ Step 5: All components are equal
        return 0
    }
}

// https://getsdeready.com/courses/dsa/lesson/reverse-the-string/
// https://leetcode.com/problems/reverse-string/
class Solution {
    func reverseString(_ s: inout [Character]) {
        var right = Int(s.indices.first!)
        var left = Int(s.indices.last!)
        
        while right < left {
            s.swapAt(right, left)
            right += 1
            left -= 1
        }
    }
}
// Solution 2 using tuple 
/*
class Solution {
    func reverseString(_ s: inout [Character]) {
        for i in 0..<s.count/2 {
            (s[i],s[s.count - i - 1])  = (s[s.count - i - 1],s[i])
        }
    }
}
*/

// https://getsdeready.com/courses/dsa/lesson/implement-strstr/
class Solution {
    
    // Step 1: Preprocess the pattern (needle) to create the LPS array
    func computeLPS(_ pattern: [Character]) -> [Int] {
        var lps = [Int](repeating: 0, count: pattern.count)
        var length = 0 // length of the previous longest prefix suffix
        var i = 1

        while i < pattern.count {
            if pattern[i] == pattern[length] {
                length += 1
                lps[i] = length
                i += 1
            } else {
                if length != 0 {
                    // Try the previous longest prefix suffix
                    length = lps[length - 1]
                } else {
                    // No prefix suffix found, move to next
                    lps[i] = 0
                    i += 1
                }
            }
        }
        return lps
    }

    // Step 2: Use KMP to search for needle in haystack
    func strStr(_ haystack: String, _ needle: String) -> Int {
        if needle.isEmpty { return 0 }

        let h = Array(haystack)
        let n = Array(needle)

        let lps = computeLPS(n)

        var i = 0 // index for haystack
        var j = 0 // index for needle

        while i < h.count {
            if h[i] == n[j] {
                // Characters match, move both pointers
                i += 1
                j += 1
            }

            if j == n.count {
                // Full match of needle found
                return i - j
            } else if i < h.count && h[i] != n[j] {
                if j != 0 {
                    // Mismatch after j matches, jump using LPS
                    j = lps[j - 1]
                } else {
                    // Mismatch at start, just move i
                    i += 1
                }
            }
        }

        // Needle not found in haystack
        return -1
    }
}
// print(Solution().strStr("lecleetcode", "leet"))


// https://getsdeready.com/courses/dsa/lesson/integer-to-roman/
// https://leetcode.com/problems/integer-to-roman/submissions/1692734096/
// Image - https://github.com/janeshsutharios/DSA_Swift/blob/main/GetSDEReady/Images/Integer-to-roman.jpeg
class Solution {
    func intToRoman(_ num: Int) -> String {
        // No, Roman numerals officially only go up to 3999.
        var m = ["", "M", "MM", "MMM"]
        var c = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"]
        var x = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"]
        var i = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"]
        // It's like 1,2,3,4,5,6,7,8,9 
        // 10,20,30,40,50,60,70,80,90
        // example job of c[(num%1000)/100] --> 1987 % 1000 = 987 further 987 / 100 = 9 = c[9] which is CM
        // which is Roman numeral for 900
        return m[num/1000] + c[(num%1000)/100] + x[(num%100)/10] + i[num%10]
    }
}
/*
class Solution {
    func intToRoman(_ num: Int) -> String {
        // Define Roman numerals and their integer values in descending order
        let romanMap: [(value: Int, symbol: String)] = [
            (1000, "M"),
            (900,  "CM"),
            (500,  "D"),
            (400,  "CD"),
            (100,  "C"),
            (90,   "XC"),
            (50,   "L"),
            (40,   "XL"),
            (10,   "X"),
            (9,    "IX"),
            (5,    "V"),
            (4,    "IV"),
            (1,    "I")
        ]

        var result = ""
        var number = num

        // Greedy approach: subtract the largest possible value repeatedly
        for (value, symbol) in romanMap {
            while number >= value {
                result += symbol       // Append the Roman symbol
                number -= value        // Subtract the value
            }
        }

        return result
    }
}
*/
// https://leetcode.com/problems/roman-to-integer/
class Solution {
    func romanToInt(_ s: String) -> Int {
        var ans = 0, num = 0;
        
        for i in stride(from: s.count - 1, to: -1, by: -1) {
            switch String(s[s.index(s.startIndex, offsetBy: i)]) {
                case "I": num = 1;
                case "V": num = 5;
                case "X": num = 10;
                case "L": num = 50;
                case "C": num = 100;
                case "D": num = 500;
                case "M": num = 1000;
                default: num = 1
            }
            if ans > 4 * num {
                ans -= num
            } else {
                ans += num
            }
        }
        return ans
        // Approach 2 using Hashmap.
        /*
          func romanToInt(_ s: String) -> Int {
        var prev = 0, out = 0
         let dict: [Character:Int] = ["I":1,"V":5,"X":10,"L":50,"C":100,"D":500,"M":1000]

       for i in s {
           let val = dict[i] ?? 0
           let calculation = (val <= prev) ? prev : -prev
           print("prevv--->", prev)
           print("current--->", val, (val <= prev))
           out += calculation
           prev = val
       }
       print("Out-->", out)
       print("prev-->", prev)
       out += prev
       return out 
    }
        */
    }
}
