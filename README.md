# GestureRecognizerDemo
## Create app using all kinds of gesture recognizer in Swift

### Kinds of UIGestureRecognizer:
1. **UITapGestureRecognizer:** recognize single or multiple taps in a specified number of times.
2. **UIPinchGestureRecognizer:** recognize pinching gestures involving two touches.
3. **UIRotationGestureRecognizer:** recognize rotation gestures involving two touches.
4. **UISwipeGestureRecognizer:** recognize swiping gestures in one or more directions.
5. **UIPanGestureRecognizer:** recognize panning (dragging) gestures.
6. **UIScreenEdgePanGestureRecognizer:** recognize panning (dragging) gestures that start near an edge of the screen.
7. **UILongPressGestureRecognizer:** recognize long-press gestures with one or more fingers

### States of gesture recognizer:
- **Possible:** The gesture recognizer has not yet recognized its gesture, but may be evaluating touch events. This is the default state.
- **Began:** The gesture recognizer has received touch objects recognized as a continuous gesture. It sends its action message (or messages) at the next cycle of the run loop.
- **Changed:** The gesture recognizer has received touches recognized as a change to a continuous gesture. It sends its action message (or messages) at the next cycle of the run loop.
- **Ended:** The gesture recognizer has received touches recognized as the end of a continuous gesture. It sends its action message (or messages) at the next cycle of the run loop and resets its state to Possible.
- **Cancelled:** The gesture recognizer has received touches resulting in the cancellation of a continuous gesture. It sends its action message (or messages) at the next cycle of the run loop and resets its state to Possible.
- **Failed:** The gesture recognizer has received a multi-touch sequence that it cannot recognize as its gesture. No action message is sent and the gesture recognizer is reset to Possible.

### Custom UIGestureRecognizer: based on [link](https://www.raywenderlich.com/433-uigesturerecognizer-tutorial-getting-started).
