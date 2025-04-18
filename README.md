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

### Acknowledgments

Original code created by: [Paul Hudson - @twostraws](https://x.com/twostraws) (Thank you!)

Made with :heart: by [@cewitte](https://x.com/cewitte)
