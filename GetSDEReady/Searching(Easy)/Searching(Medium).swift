// https://getsdeready.com/courses/dsa/lesson/reach-a-number/
// https://leetcode.com/problems/reach-a-number/
class Solution {
    func reachNumber(_ target: Int) -> Int {
       var target = abs(target)
       var minSteps = 0
       while target > 0 {
         minSteps += 1
         target -= minSteps
       }
       if target % 2 == 0 {
          return minSteps
       } else {
          return minSteps + 1 + minSteps % 2
       }
    }
}

When we exit the `while target > 0` loop:

* We’ve **already taken enough steps** so that our sum of steps has **overshot or exactly reached** the target.
* The variable `target` is now **negative or zero**, and represents the “overshoot gap”:

  * Example: If original target = `5` and after some steps we’re at sum = `7`,
    overshoot = `7 - 5 = 2`,
    and `target` in code is `-2`.

---

## Why `% 2` is the magic check

The only way to fix overshoot is to **flip** some steps (turn a `+step` into a `-step`).

Flipping step `x` changes position by exactly `2 × x`, which is **always even**.

**Implication:**
If the overshoot gap is even → we can fix it right away by flipping steps, no extra steps needed.

If the overshoot gap is odd → we **cannot** fix it unless we make it even by taking extra steps.

---

## Why `+1 + minSteps % 2`

Let’s say we end with:

* `minSteps` steps taken
* Overshoot gap is **odd**

Case breakdown:

1. **First extra step** (`+1`):

   * Adds `(minSteps + 1)` to total sum.
   * This changes the overshoot parity (odd → even or even → odd depending on `minSteps`’s parity).

2. **Check if we need a second extra step** (`+ minSteps % 2`):

   * If `minSteps` is odd, then `(minSteps + 1)` is even, and the parity shift fixes it in one extra step.
   * If `minSteps` is even, then `(minSteps + 1)` is odd, and we need **one more** extra step to make the gap even.

This is why:

```swift
return minSteps + 1 + minSteps % 2
```

* `+1` → always take one more step for odd gap
* `+minSteps % 2` → take another step if needed due to parity

---

## Example where it happens

Target = 2

```
Step 1: sum = 1  (target now 1)
Step 2: sum = 3  (target now -1) ← overshoot gap = 1 (odd)
minSteps = 2 (even)

Need:
+1 step → sum = 6 (gap now 4, even) ✅
Actually in this case, minSteps % 2 = 0 → total steps = 2 + 1 = 3
```

Target = 4

```
Step 1: sum = 1  (target now 3)
Step 2: sum = 3  (target now 1)
Step 3: sum = 6  (target now -2, even) → done in 3 steps
```

Target = 5

```
Step 1: sum = 1 (target 4)
Step 2: sum = 3 (target 2)
Step 3: sum = 6 (target -1, odd)
minSteps = 3 (odd)

Need:
+1 step → sum = 10 (gap 5, odd) → still odd
So +1 more step → sum = 15 (gap 10, even) ✅
Total steps = 3 + 1 + 1 = 5
```
