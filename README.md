# jQuery Background Size plugin

This is a jQuery plugin developed to work with background-size: cover and contain in Internet Explorer 8 and lower. The plugin focuses on leaving as much of CSS functionality intact as possible. It only takes up 2KB (minified) of space.


# What's in the 'box'?
The plugin comes with two shorthand functions that don't receive any parameters:

```
$('.element').cover();
$('.element').contain();
```

and the actual plugin that can receive parameters:

```
$('.element').background({
  size: 'cover',
  force: true
});
```

See the demo page for more infomation and all available parameters.

## How to use?
Let's say you have this CSS defined for a block:

```
.demo-block {
  background-size: cover;
  background-position: left top;
  background-repeat: no-repeat;
  background-image: url(./path-to/image.jpg);
}
```

All it would need for IE8 and lower to work is the following javascript:

```
$('.demo-block').cover();
```

All settings and paths will be inherited from the stylesheet you just need to tell the plugin what type of sizing it should use. Check out the demo page for more information and options.

## What does it not do?
The plugin only works with the `cover` and `contain` values for the background sizing. Pixel or percentage values are (currently) not supported. 

## Work in progress
This is the preliminary to-do list for this plugin's development:

* I'm still implementing repeat parameters. Even though I've never used anything else then `background-repeat: no-repeat;` when using `background-size:` `cover` or `contain`, I'm still implementing this for other users who might.
* Still hesitating to implement pixel and percentage value for `background-size`, I'm leaning towards **no**.
* Ability to pass image url and position paramaters directly to the plugin, mostly for testing.
* Bug fixing... If needed.






