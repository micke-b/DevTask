# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

SwiftUI iOS app that fetches blog posts from JSONPlaceholder API and displays posts with `id < 50`. Tapping a post navigates to its comments. Built as a coding task.

**API base URL:** `https://jsonplaceholder.typicode.com/`

## Build & Test

The Xcode project is at `DevTask/DevTask.xcodeproj`.

```bash
# Build
xcodebuild -project DevTask/DevTask.xcodeproj -scheme DevTask -destination 'platform=iOS Simulator,name=iPhone 17 Pro' build

# Run tests
xcodebuild -project DevTask/DevTask.xcodeproj -scheme DevTask -destination 'platform=iOS Simulator,name=iPhone 17 Pro' test

# Run a single test
xcodebuild -project DevTask/DevTask.xcodeproj -scheme DevTask -destination 'platform=iOS Simulator,name=iPhone 17 Pro' test -only-testing:DevTaskTests/GetFiftyFirstPostsUseCaseTests
```

Uses Swift 6 and Swift Testing framework (not XCTest) for tests.

## Architecture

Three-layer architecture with dependency injection:

**Presentation** -> **Business Logic (Use Cases)** -> **Services (via Repository)**

- **Presentation**: SwiftUI views are "dumb" (just render state). `@Observable` ViewModels manage state and call use cases. Navigation uses `NavigationStack` with `NavigationPath`.
- **Business Logic**: Use cases (`GetFiftyFirstPostsUseCase`, `GetCommentsForPostUseCase`) — one unit of business logic per class. These are the primary test targets.
- **Services**: Each service follows a three-part structure:
  - `API/` — public protocol + models (e.g., `PostsService`, `Post`)
  - `Impl/` — internal implementation (e.g., `DefaultPostsService`)
  - `TestUtils/` — fakes for testing (e.g., `FakePostsService`, `FakeBlogRepository`)

**BlogRepository** aggregates `PostsService` and `CommentsService` behind a single `BlogRepository` protocol, simplifying error types for upstream consumers.

Dependencies are wired manually in `DevTaskApp.init()` (no DI framework).

## Concurrency

Both app and test targets use `SWIFT_DEFAULT_ACTOR_ISOLATION = MainActor` and `SWIFT_VERSION = 6.0`. All non-UI types (services, protocols, use cases, models, error enums, fakes) are explicitly marked `nonisolated` to opt out, so networking and business logic run off the main actor. `Post` and `Comment` are explicitly `Sendable` for safe crossing of isolation boundaries.

## Design System

`DesignTokens` enum provides semantic color tokens (`primary`, `secondary`, `onSurface`, `onSurfaceVariant`) and a shared `backgroundGradient`. Views reference these tokens instead of hardcoded colors.

## Feature Spec Files

Each service directory contains a `.md` feature spec (e.g., `PostService/PostService.md`) with YAML frontmatter describing the module's name, dependencies, Swift version, and owner. These are intended for scaffolding/code generation of new features.

## Typed Throws

The codebase uses Swift 6 typed throws throughout: services throw specific error enums (e.g., `PostsServiceError`), the repository translates these into `BlogRepositoryError`, and use cases throw their own errors (e.g., `FetchPostWithIdUnderFiftyError`). Each layer maps errors from the layer below.

## UI

Uses iOS 26 Liquid Glass effects (`GlassEffectContainer`, `.glassEffect()`). Tappable cells use `.glassEffect(.regular.interactive())` for press/hover feedback. Requires Xcode 26 / iOS 26 SDK.
