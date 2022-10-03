What's new

· Free draw canvas
If a drawing app can only stipulate that you can only draw a specific shape, most of you will not choose to draw with such an app. Users want to create their own unique things, so our app implements the function of free draw, you are no longer bound to draw triangles, rectangles and circles, you can create your own doodles! Simply click the FreeDraw button in the upper right corner and you can enter the free canvas. Again, you can choose different colors to draw, and if you think you made a mistake, you can enter "Undo" mode and click on the canvas to undo the latest drawing.

How do we implement it?
Drawing Mode
1. Add a new view controller named freeDraw, connect it with FreeDraw button.
2. Create a class named Line which is the subclass of Shape.
3. Create a context by using UIGraphicsGetCurrentContext, for each line, store all CGPoints. If it the first point of the line, we move the point to the current point, otherwise, we add this points to current line.
4. Clear the points which store temporarily in order to start a new line when user touches again.
Undo Mode
5. Remove the last item of the shapeCanvas.items array every time user touched the canvas.



· Save your shapes:
It would be such a shame if you had a great creation but couldn't save it. No one wants to be unable to save a perfect drawing when it's done, or if a drawing app can only save images via user screenshots, it's incomplete. However in this app, you are able to save your shapes and doodles on the drawing canvas to your photo library by simply clicking “save shapes”.

How do we implement it?
1. Use UIGraphicsBeginImageContext to create a bitmap-based context with the same size of the drawing canvas, and sets it to the current context
2. Render it as an image using UIGraphicsGetImageFromCurrentImageContext
3. Use UIImageWriteToSavedPhotosAlbum to save it to the image library
4. Check if it is succesfully saved by using didFinishSavingWithError with the corresponding alert view pops up.



Reference:
1. https://blog.csdn.net/qq_36332133/article/details/86593646
2. https://www.youtube.com/watch?v=E2NTCmEsdSE
3. https://medium.com/@Shubhransh-Gupta/add-home-screen-quick-action-menu-in-ios-xcode-storyboard-swift-4553dd450d77

