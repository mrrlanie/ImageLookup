# ImageLookup

ImageLookup is a small UIKit demo app that streams placeholder photos, caches them for faster reuse, and lets you quickly prune the feed with a swipe animation.

## Features
- Grid feed of images from `placehold.co` with pull-to-refresh to rebuild the dataset.
- Lazy image loading as cells appear via `URLSession`.
- Two-level caching (`NSCache` in-memory + file-based cache) to avoid repeat downloads.
- Tap a cell to delete it with an animated swipe-off gesture.
- Compositional layout-based collection view with reusable, programmatic UI.

## Architecture
- UIKit, programmatic layout, no storyboards for the main UI.
- Module-oriented (View / Presenter / Interactor / Router) separation for the main screen.
- Service layer for networking and caching (`ImageDownloaderService`, `ImageCachingService`).

## Tech Stack
- Swift 5.x, UIKit
- `UICollectionViewCompositionalLayout`
- `URLSession` for networking
- `NSCache` + `FileManager` for memory/disk image caching
- GCD/`DispatchQueue` for main-thread UI updates

## Getting Started
1) Requirements: Xcode 15+ and iOS 15+ simulator or device.  
2) Open `ImageLookup.xcodeproj` in Xcode.  
3) Run the `ImageLookup` scheme on your chosen simulator/device.  
4) Pull to refresh the feed; tap any image to remove it and clear its cached copy.

## Project Layout
- `AppLayer/Modules/MainScreen`: View/Presenter/Interactor/Router setup for the main feed.
- `AppLayer/Cells` and `AppLayer/Layouts`: Collection view cell and compositional layout.
- `ServiceLayer/Services`: Networking and caching services.
- `Helpers`: App/Scene delegates and assets.
