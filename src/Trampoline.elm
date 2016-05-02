module Trampoline exposing
  ( Trampoline
  , done, jump
  , evaluate
  )

{-| A [trampoline](http://en.wikipedia.org/wiki/Tail-recursive_function#Through_trampolining)
makes it possible to recursively call a function without growing the stack.

Popular JavaScript implementations do not perform any tail-call elimination, so
recursive functions can cause a stack overflow if they go too deep. Trampolines
permit unbounded recursion despite limitations in JavaScript.

This strategy may create many intermediate closures, which is very expensive in
JavaScript, so use this library only when it is essential that you recurse deeply.

# Trampolines
@docs Trampoline, done, jump, evaluate
-}


{-| A computation that has been broken up into a bunch of smaller chunks. The
programmer explicitly adds "pause points" so each chunk of computation can be
run without making the stack any deeper.
-}
type Trampoline a
    = Done a
    | Jump (() -> Trampoline a)


{-| When you do not want a computation to go through the trampoline.
-}
done : a -> Trampoline a
done =
  Done


{-| When you want a computation to be delayed so that it is handled by the
trampoline.
-}
jump : (() -> Trampoline a) -> Trampoline a
jump =
  Jump


{-| Evaluate a trampolined value in constant space. -}
evaluate : Trampoline a -> a
evaluate trampoline =
  case trampoline of
    Done value ->
      value

    Jump f ->
      evaluate (f ())
