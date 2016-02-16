# Trampolines

Popular JavaScript implementations do not perform any tail-call elimination, so recursive functions can cause a stack overflow if they go too deep. That said, the Elm compiler optimizes [tail calls](https://en.wikipedia.org/wiki/Tail_call) into loops for functions that call themselves, so most situations will just get optimized behind the scenes for you.

The compiler does not do anything for *mutually* tail-recursive functions though. If you find yourself needing that, you can use a [trampoline](http://en.wikipedia.org/wiki/Tail-recursive_function#Through_trampolining). Trampolines make it possible to call functions recursively without growing the stack.

This strategy creates intermediate closures, which is very expensive in JavaScript, so use this library only when it is essential that you recurse deeply.
