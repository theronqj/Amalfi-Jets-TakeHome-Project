# **Amalfi Jets Booking App - Take-Home Project**
### **Theron Jones**
### **July 8, 2025**

## **1. My Approach**
My goal for this project was to build a clean, modern, and user-friendly booking form using Apple's latest technologies. I chose **SwiftUI** for the user interface and **Combine** for handling asynchronous events and state management, following the **MVVM (Model-View-ViewModel)** architectural pattern.

**Key Architectural Decisions:**

**Declarative UI with SwiftUI:** The entire UI is built with SwiftUI, which allows for a declarative and state-driven approach. Views are a direct function of their state, leading to more predictable and maintainable UI code. I broke down the UI into small, reusable components (e.g., `AirportInputRow`, `DatePickerButton`) to keep the main `ContentView` clean and readable.

**Reactive State Management with Combine & MVVM:**

The `BookingFormViewModel` acts as the single source of truth for the main booking form's data (airports, date, passenger count, etc.).

The `AirportSearchViewModel` encapsulates all the logic for the airport search feature, including making network calls, handling loading and error states, and debouncing user input.

Using `@Published` property wrappers and `@StateObject` / `@ObservedObject` creates a reactive pipeline where the UI automatically updates whenever the underlying data changes in the view model.

**Efficient & Responsive Airport Search:**

**Debouncing:** To prevent excessive network calls while the user is typing, I implemented a 400ms debounce on the search query using Combine's `.debounce` operator. This ensures an API request is only made when the user pauses typing.

**Cancellation:** The pipeline is set up to automatically cancel any in-flight network request if a new search is initiated, preventing race conditions and ensuring the UI only displays results for the most recent query.

**Handling API Quirks:**

I discovered that the Aviowiki API returns a `200 OK` status with an empty response body for queries that yield no results. A standard decoding pipeline would fail with a `DecodingError`. I implemented a solution using Combine's `.tryCatch` operator to intercept this specific error, transform it into a successful result with an empty array, and prevent an erroneous error message from being shown to the user. Other, legitimate errors (like network failures) are still passed through and displayed correctly.

## **2. What I Would Like to Improve**
Given more time, I would focus on the following areas to make the application more robust, scalable, and production-ready.

**Dependency Injection & Testability:**

Currently, the `AirportSearchViewModel` creates its own `URLSession` publisher. To enable unit testing, I would introduce a networking protocol (e.g., `AirportAPIServiceProtocol`) and inject it into the view model's initializer. This would allow me to substitute a `MockAirportAPIService` during tests to simulate various network conditions (success, different errors, etc.) without hitting a live endpoint.

**Dedicated Networking Layer:**

I would abstract the URL construction and `URLSession` logic into a generic `APIClient`. This would centralize networking logic, make it reusable for future API integrations, and further decouple it from the view models.

**Comprehensive Testing:**

Unit Tests: I would write a full suite of unit tests for the `AirportSearchViewModel` to verify all business logic, including the debouncing mechanism, state changes (`isLoading`, `errorMessage`), and the handling of success and all failure scenarios from the mock service.

UI Tests: I would add UI tests for the critical user flow: selecting departure and arrival airports, verifying the form expands correctly, and ensuring the passenger count can be modified.

**Enhanced Error Handling & User Experience:**

Instead of displaying errors as a simple string, I would create dedicated views for different states. For example, the airport list could show a user-friendly view for "No Results Found" or a "Could not connect. Please try again." view with a retry button for network failures.

**Accessibility:**

I would perform a full accessibility audit to ensure all elements have proper VoiceOver labels, hints, and traits, making the app fully usable for users with visual impairments.

## **3. Feedback on the Designs**
Overall, I found the designs to be clean, modern, and intuitive. The progressive disclosure of the form—showing the detailed input fields only after the primary route is selected—is an excellent UX pattern that reduces initial cognitive load for the user.

**What I Liked:**

The minimalist aesthetic is very effective and aligns well with a luxury brand.

The color palette is simple and uses the brand's orange as an effective accent color for primary actions.

The flow is logical and easy to follow.

**Potential Improvements:**

**Clarity on "Notes" Field:** The placeholder text "Notes & Preferred Timing" is a bit long and could be ambiguous. It might be clearer to separate these into two distinct fields if they represent different types of input, or to simplify the placeholder to just "Add Notes or Preferences."

## **4. Other Notes & Context**
**Project Structure:** I organized the project files into a scalable, feature-based structure (`Features/Booking`, `Shared/`). This makes the codebase easy to navigate and maintain as new features are added. I also included a `Tests/` directory to outline where unit tests and UI tests would live.

## **5. How to Run**
This project is a standard iOS application built with SwiftUI and requires no special configuration.

**Prerequisites**

**macOS:** Sonoma 14.0 or later

**Xcode:** 15.0 or later

**Target iOS:** The project is configured for **iOS 17.0** or later. Please select a simulator running a compatible iOS version.

**Steps**

1. Clone the repository to your local machine.

2. Navigate to the project's root directory and open the `AmalfiJetsTakeHome.xcodeproj` file in Xcode.

3. Select an iOS simulator of your choice from the target menu (e.g., iPhone 16 Pro, running iOS 17.0 or later).

4. Click the Run button (or press `Cmd + R`) to build and run the application.

I enjoyed the challenge, and thank you for the opportunity to work on it.
