# Instafilter: Introduction

Paul Hudson's ([@twostraws](https://x.com/twostraws)) 100 Days of Swift UI Project 13.

## Project 13

Source URL: [Instafilter: Introduction](https://www.hackingwithswift.com/books/ios-swiftui/instafilter-introduction)

"In this project we’re going to build an app that lets the user import photos from their library, then modify them using various image effects. We’ll cover a number of new techniques, but at the center of it all are one useful app development skill – using Apple’s Core Image framework – and one important SwiftUI skill – integrating with UIKit. There are other things too, but those two are the big takeaways.

Core Image is Apple’s high-performance framework for manipulating images, and it’s extraordinarily powerful. Apple has designed dozens of example image filters for us, providing things like blurs, color shifts, pixellation, and more, and all are optimized to take full advantage of the graphics processing unit (GPU) on iOS devices.

Tip: Although you can run your Core Image app in the simulator, don’t be surprised if most things are really slow – you’ll only get great performance when you run on a physical device.

As for integrating with UIKit, you might wonder why this is needed – after all, SwiftUI is designed to replace UIKit, right? Well, sort of. Before SwiftUI launched, almost every iOS app was built with UIKit, which means that there are probably several billion lines of UIKit code out there. So, if you want to integrate SwiftUI into an existing project you’ll need to learn how to make the two work well together.

But there’s another reason, and I’m hoping it won’t always be a reason: many parts of Apple’s frameworks don’t have SwiftUI wrappers yet, which means if you want to integrate MapKit, Safari, or other important APIs, you need to know how to wrap their code for use with SwiftUI. I’ll be honest, the code required to make this work isn’t pretty, but at this point in your SwiftUI career you’re more than ready for it."

### Showing multiple options with `confirmationDialog()`

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/showing-multiple-options-with-confirmationdialog)

Branch: `01-confirmation-dialog`

"SwiftUI gives us `alert()` for presenting important choices, and `sheet()` for presenting whole views on top of the current view, but it also gives us `confirmationDialog()`: an alternative to alert() that lets us add many buttons.

Visually alerts and confirmation dialogs are very different: on iPhones, alerts appear in the center of the screen and must actively be dismissed by choosing a button, whereas confirmation dialogs slide up from the bottom, can contain lots of buttons, and can be dismissed by tapping on Cancel or by tapping outside of the options.

Although they look very different, confirmation dialogs and alerts are created almost identically:

- Both are created by attaching a modifier to our view hierarchy – alert() for alerts and confirmationDialog() for confirmation dialogs.
- Both get shown automatically by SwiftUI when a condition is true.
- Both can be filled with buttons to take various actions.
- Both can have a second closure attached to provide an extra message."

Adding a confirmation dialog:

```
.confirmationDialog("Change background", isPresented: $showingConfirmation) {
    Button("Red") { backgroundColor = .red }
    Button("Green") { backgroundColor = .green }
    Button("Blue") { backgroundColor = .blue }
    Button("Cancel", role: .cancel) { }
} message: {
    Text("Select a new color")
}
```

Result:

![Confirmation Dialog](/images/confirmation_dialog.png)

### Integrating `CoreImage`with `SwiftUI`

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/integrating-core-image-with-swiftui)

Branch: `02-ingrating-coreimage-swiftui`

"What actually is an Image? As you know, it’s a view, which means it’s something we can position and size inside our SwiftUI view hierarchy. It also handles loading images from our asset catalog and SF Symbols, and it’s capable of loading from a handful of other sources too. However, ultimately it is something that gets displayed – we can’t write its contents to disk or otherwise transform them beyond applying a few simple SwiftUI filters.

If we want to use Core Image, SwiftUI’s Image view is a great end point, but it’s not useful to use elsewhere. That is, if we want to create images dynamically, apply Core Image filters, and so on, then SwiftUI’s images aren’t up to the job.

Apple gives us three other image types to work with, and cunningly we need to use all three if we want to work with Core Image. They might sound similar, but there is some subtle distinction between them, and it’s important that you use them correctly if you want to get anything meaningful out of Core Image.

Apart from SwiftUI’s Image view, the three other image types are:

- `UIImage`, which comes from UIKit. This is an extremely powerful image type capable of working with a variety of image types, including bitmaps (like PNG), vectors (like SVG), and even sequences that form an animation. `UIImage` is the standard image type for `UIKit`, and of the three it’s closest to SwiftUI’s Image type.
- `CGImage`, which comes from Core Graphics. This is a simpler image type that is really just a two-dimensional array of pixels.
- `CIImage`, which comes from Core Image. This stores all the information required to produce an image but doesn’t actually turn that into pixels unless it’s asked to. Apple calls CIImage “an image recipe” rather than an actual image.

There is some interoperability between the various image types:

- We can create a `UIImage` from a `CGImage`, and create a `CGImage` from a `UIImage`.
- We can create a `CIImage` from a `UIImage` and from a `CGImage`, and can create a `CGImage` from a `CIImage`.
- We can create a SwiftUI `Image` from both a `UIImage` and a `CGImage`.

[...] 

we need to convert the output from our filter to a SwiftUI Image that we can display in our view. This is where we need to lean on all four image types at once, because the easiest thing to do is:

1. Read the output image from our filter, which will be a `CIImage`. This might fail, so it returns an optional.
2. Ask our context to create a `CGImage` from that output image. This also might fail, so again it returns an optional.
3. Convert that `CGImage` into a `UIImage`.
4. Convert that `UIImage` into a SwiftUI `Image`.

[...]

If you’re implementing precise Core Image adjustments you should definitely be using the newer API that uses exact property names and types, but in this project the older API comes in useful because it lets us send in adjustments regardless of what filter is actually used."

Result:

![`photoEffectMono()` applied](/images/photo_effect_mono.png)

### Showing empty states with `ContentUnavailableView`

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/showing-empty-states-with-contentunavailableview)

Branch: `03-empty-states-contentunavailableview`

"SwiftUI's `ContentUnavailableView` shows a standard user interface for when your app has nothing to display. I know, that sounds redundant, right? After all, if you have nothing to display, you have nothing to display!

But `ContentUnavailableView` is perfect for times your app relies on user information that hasn't been provided yet, such as when your user hasn't created any data, or if they are searching for something and there are no results."

Result:

![ContentUnavailableView](/images/content_unavailable_view.png)

### Loading photos from the user's photo library

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/loading-photos-from-the-users-photo-library)

Branch: `04-loading-photos-from-library`

"SwiftUI's PhotosPicker view provides us with a simple way to import one or more photos from the user's photo library. To avoid causing any performance hiccups, the data gets provided to us as a special type called PhotosPickerItem, which we can then load asynchronously to convert the data into a SwiftUI image.

This takes five steps in total."

Note: there are 2 commits (so far) in this branch: one that shows the most basic code to import a single photo from the user's library, and another one that shows how to import multiple photos.

Result (simple version with single photo):

![Simple version](/images/simple_version.gif)

Result (multiple photo selection):

![Multiple photo selection](/images/multiple_photo_selection.gif)

### How to let the user share content with ShareLink

Source URL: [link](https://www.hackingwithswift.com/books/ios-swiftui/how-to-let-the-user-share-content-with-sharelink)

Branch: `05-share-with-sharelink`

"SwiftUI's ShareLink view lets users export content from our app to share elsewhere, such as saving a picture to their photo library, sending a link to a friend using Messages, and more.

We provide the content we want to share, and iOS takes care of showing all the apps that can handle the data we're sending."

Example

``
ShareLink(item: URL(string: "https://www.hackingwithswift.com")!) {
    Label("Spread the word about Swift", systemImage: "swift")
}
``

Result:

![ShareLink view](/images/sharelink.gif)

### Acknowledgments

Original code created by: [Paul Hudson - @twostraws](https://x.com/twostraws) (Thank you!)

Made with :heart: by [@cewitte](https://x.com/cewitte)
