#1 We can add multiple elements on min as - min(bCounts,aCounts,lCounts/2,oCounts/2,nCounts)
#2 Int to Char conversion - let char = Character(UnicodeScalar(i + Int(Character("a").asciiValue!))!)
#3 Char to Int conversion - let index = Int(char.asciiValue! - Character("a").asciiValue!)

// MARK: How to access string index
let name = "Janesh"
print("second char", name[name.index(name.startIndex, offsetBy: 1)])
print("third last char", name[name.index(name.endIndex, offsetBy: -3)])

// MARK: indices on loop
  for characterIndex in firstWord.indices {
