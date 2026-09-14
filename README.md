
# iOS API Integration

A sample native iOS application demonstrating clean and maintainable API integration using **Swift, UIKit, MVVM, URLSession, Codable, and Dependency Injection**.

The project demonstrates how to structure a scalable networking layer, handle API responses and errors, decode JSON data into Swift models, and separate UI, business logic, and networking responsibilities.

## Technologies

* Swift
* UIKit
* MVVM Architecture
* URLSession
* Codable / JSONDecoder
* Async/Await
* Protocol-Oriented Programming
* Dependency Injection
* XCTest

## Key Features

* REST API integration using URLSession
* Generic API client for reusable network requests
* Codable-based JSON parsing
* Centralized network error handling
* MVVM architecture
* Protocol-based service abstraction
* Dependency injection for better maintainability and testability
* Loading, success, and error UI states
* Unit testing with mock services

## Architecture

The application follows a layered architecture:

**ViewController → ViewModel → Service → APIClient → URLSession → REST API**

This separation of responsibilities makes the code easier to understand, maintain, test, and extend.

## Purpose

This project is created as a technical showcase to demonstrate practical iOS development practices for building structured, testable, and maintainable applications that consume REST APIs.

