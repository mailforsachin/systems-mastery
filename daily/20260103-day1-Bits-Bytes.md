# Day 1: Bits & Bytes
**Date:** 20260103

## ❓ Question
How does data physically travel from my VPS to users?

## 📝 My Answer
Your VPS = You writing the letter  
NIC = Putting it in an envelope with address  
Switch = Your local post office  
Router = Major sorting hubs  
Fiber cables = Trucks/planes between cities  
User's device = Recipient opening the letter  

## 🔧 Practical Investigation
*(Add your practical investigation here)*

## 📚 Resources
1️⃣ Where does a Python string live in memory?  
“the actual string lives in the heap but the pointer/reference lives in the stack”  
✅ Correct  
Stack holds the reference  
Heap holds the object  

## Why is result = char + result expensive?  
“On every iteration we are reading the string and prepending it. Per space time complexity it is o(n2)”  
Let me sharpen it to FAANG-grade clarity:  
Python strings are immutable  
text = "hello"  
# Trying to change a character directly will cause an error  
    try:  
        text[0] = "H"  
    except TypeError as e:  
        print(e)  # Output: 'str' object does not support item assignment   "
    
Instead, you create a new string  
new_text = "H" + text[1:]  
print(new_text)  # Output: Hello  

Every concatenation creates a new string  
Each iteration copies existing characters  
Total work = 1 + 2 + 3 + ... + n → O(n²)  

The question was:  
## If reversing a string this way is inefficient, what might be a better data structure to use and why?  

✅ Correct Answer (What Interviewers Expect)  
A list (array) is better.  
Why?  
Lists are mutable  
Elements can be swapped in place  
No new objects need to be created  
Enables O(n) time and O(1) extra space   

## EXECUTION  
Convert string → list of characters  
Swap left and right elements  
Convert back if needed  

## Data structure choice  
Mutability  
Time/space optimization  

## ❌ Why “maps” (dictionaries) are not suitable  
Maps/dicts:  
Are key–value stores  
Do not preserve order (conceptually)  
Are optimized for lookup, not sequential access  
Reversing requires ordered, index-based access  

## Why is a list more suitable than a string for in-place reversal?  
A list is mutable, meaning its elements can be modified in place, whereas strings are immutable.   
By using a list, we can swap characters directly without creating new copies of the string on each iteration.  
This avoids repeated copying and improves performance, resulting in O(n) time complexity with O(1) extra space.  

## 🔗 Related Files
- [Assets](/home/ubuntu/systems-mastery/assets/20260103-day1-Bits-Bytes_ASSETS.md)
- [Concepts](/home/ubuntu/systems-mastery/concepts/20260103-day1-Bits-Bytes_CONCEPTS.md)
- [Diagrams](/home/ubuntu/systems-mastery/diagrams/20260103-day1-Bits-Bytes_DIAGRAMS.md)
- [Labs](/home/ubuntu/systems-mastery/labs/20260103-day1-Bits-Bytes_LABS.md)
- [Templates](/home/ubuntu/systems-mastery/templates/20260103-day1-Bits-Bytes_TEMPLATES.md)
