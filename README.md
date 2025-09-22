# SOLID Principles Flutter Example App

This is a Flutter application designed to demonstrate the five SOLID principles of object-oriented design. It serves as an educational tool for developers looking to understand and apply these principles in mobile app development.

## What are the SOLID Principles?

SOLID is an acronym for five design principles intended to make software designs more understandable, flexible, and maintainable.

-   **S - Single Responsibility Principle:** A class should have only one reason to change.
-   **O - Open/Closed Principle:** Software entities should be open for extension, but closed for modification.
-   **L - Liskov Substitution Principle:** Objects of a superclass should be replaceable with objects of a subclass without affecting the correctness of the program.
-   **I - Interface Segregation Principle:** No client should be forced to depend on methods it does not use.
-   **D - Dependency Inversion Principle:** High-level modules should not depend on low-level modules. Both should depend on abstractions.

## Application Structure

The application consists of a main screen with a list of the five SOLID principles. Tapping on a principle navigates to a dedicated screen that provides:

1.  A clear explanation of the principle.
2.  A code example demonstrating a "bad" approach that violates the principle.
3.  A code example demonstrating a "good" approach that adheres to the principle.
4.  Buttons to execute the code and see the results.

All the example code is located in the `lib/screens` directory.

## How to Run the App

1.  **Ensure you have Flutter installed.** You can find installation instructions on the [official Flutter website](https://flutter.dev/docs/get-started/install).
2.  **Clone the repository and `cd` into it.**
3.  **Get the dependencies:**
    ```bash
    flutter pub get
    ```
4.  **Run the app:**
    ```bash
    flutter run
    ```

This will launch the app on your connected device or emulator.
