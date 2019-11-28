# horchata.logger

When you need to print something for debug or just for having your own logs, you can use this logger.

## How to use

Instanciate a new `Logger`

```lua
    local Logger = require 'horchata.logger'
```

And print you code with three awesome logging levels

**INFO**

```lua
    Logger:info("Hello user")
```

Will print...

```
[INFO] Hello user
```

**DEBUG**

```lua
    local n_vars = 5
    Logger:debug("There is " .. n_vars .. " on your code.")
```

Will print...

```
[DEBUG] There is 5 on your code.
```

**ERROR**

```lua
    Logger:error("Something went wrong!")
```

Will print...

```
[ERROR] Something went wrong!
```
