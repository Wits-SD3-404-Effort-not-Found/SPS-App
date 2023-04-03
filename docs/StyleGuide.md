# Styleguide

## Definition Guide

* Pascal case - ExampleIdentifier
* Camel case - exampleIdentifier
* Snake case - example_identifier

## Guide

1. Classes - Pascal Case
2. Filenames - Snake Case
3. Directories - Snake Case
4. Constants - Camel Case
5. Variables - Camel Case - Avoid type inference
6. Treat Acroymns and Variables as whole words - therefore they obey the rest of the rules
7. Braces
   1. Inline curly braces
   2. Space after round brackets between curly brace

## Example

```dart

    // Class decleration
    class ExampleClass {

    }

    // Variable Decleration
    String name = 'Bob';
    int peopleCounter = 100;
    const piValue = 3.14;

    // Function decleration
    bool isEven(int number) {
        return (number % 2 == 0);
    }

    if (isEven(32) == true) {
        // Do something
    }
```

## When in doubt

https://dart.dev/guides/language/effective-dart/style