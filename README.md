# jQuery Background Size plugin

This is a jQuery plugin developed to work with background-size: cover and contain in Internet Explorer 8 and lower.

The plugin focuses on leaving as much of CSS functionality intact as possible.

## How to use?

The plugin comes with two shorthand functions:

```
$('.element').cover();
$('.element').contain();
```

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