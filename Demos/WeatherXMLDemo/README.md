## Set Up ##

To run the demo, first you need to obtain a **[World Weather Online](http://developer.worldweatheronline.com/)** API Key from their site. Don't worry, it's free! After you verify your email, they'll send you the key and you can insert it at the top of the <code>WebService.m</code> file in a #define. There is a warning at the top of that file that you can delete out if you like a clean project (we do). Once you have the key in your project, you can build and run to test it out.

## Testing ##

To test, just enter a city or zip code in the text field and click return. This will hit the web, return <code>NSData</code> and map that directly to an object without you doing any work at all! It's beautiful, isn't it? You can breakpoint inside of the success block in <code>ViewController.m</code> to see the object and all of its properties.

## Learning More ##

Look at the very top-level README of the project to see how it all works, and how to set up your custom NSObjects from the get-go. Leave an Issue if you have any questions.
