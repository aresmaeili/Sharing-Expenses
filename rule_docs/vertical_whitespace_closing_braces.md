# Vertical Whitespace before Closing Braces

Don't include vertical whitespace (empty line) before closing braces.

* **Identifier:** vertical_whitespace_closing_braces
* **Enabled by default:** No
* **Supports autocorrection:** Yes
* **Kind:** style
* **Analyzer rule:** No
* **Minimum Swift compiler version:** 5.0.0
* **Default configuration:** N/A

## Non Triggering Examples

```swift
do {
  print("x is 5")
}
```

```swift
print([foo {
  var sum = 0
  for i in 1...5 { sum += i }
  return sum

}, foo {
  var mul = 1
  for i in 1...5 { mul *= i }
  return mul
}])
```

```swift
do {
  print("x is 5")
}
```

```swift
func foo() {
  run(5) { x in
    print(x)
  }
}
```

```swift
[
1,
2,
3
]
```

```swift
foo(
    x: 5,
    y:6
)
```

```swift
do {
  print("x is 5")
}
```

```swift
print([
  1
])
```

```swift
[1, 2].map { $0 }.filter { true }
```

```swift
[1, 2].map { $0 }.filter { num in true }
```

```swift
/*
    class X {

        let x = 5

    }
*/
```

```swift
if bool1 {
  // do something
  // do something

} else if bool2 {
  // do something
  // do something
  // do something

} else {
  // do something
  // do something
}
```

## Triggering Examples

```swift
do {
  print("x is 5")
↓

}
```

```swift
print([foo {
  var sum = 0
  for i in 1...5 { sum += i }
  return sum

}, foo {
  var mul = 1
  for i in 1...5 { mul *= i }
  return mul
↓
}])
```

```swift
do {
  print("x is 5")
↓
  
}
```

```swift
func foo() {
  run(5) { x in
    print(x)
  }
↓
}
```

```swift
[
1,
2,
3
↓
]
```

```swift
foo(
    x: 5,
    y:6
↓
)
```

```swift
do {
  print("x is 5")
↓
}
```

```swift
print([
  1
↓
])
```