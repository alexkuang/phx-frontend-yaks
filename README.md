# phx-frontend-yaks

yak shaving around phoenix + client-centric frontend framework (e.g. react, vue, svelte, ...)

## Why?

Elixir/Phoenix is great.  It's probably my favorite gen-purpose web backend at this point.

LiveView is great... a lot of the time.  It has a lot of rough edges when frontend components get non-trivial.  Manual
DOM manipulation makes me feel like it's 2008 again, and not in a good way.

## Goal

Explore integration of client-centric js framework with Phoenix and evaluate ergonomics + productivity:
- complexity compared to js-with-graphql-etc options
- keeping benefits of Elixir + Phoenix
- benefits vs cost of adding the JS framework vs just doing LiveView

Non-goal: code that is production-ready or best practices in any of the ecosystems in question :)

## Bits and pieces

Stacks tested:
- inertia + react
- svelte + live_svelte

The example used is a mini blog app that creates `Post`s and `Comment`s.  The `Post` features are done as
static pages + plain POST forms.  The `Comment` features exercise options for providing a live-updating feed, i.e. the
list in one window updates when a comment is created in a separate window.

## Result notes

TODO

## References
- https://github.com/inertiajs/inertia-phoenix
- https://github.com/ChristianAlexander/phoenix-inertia-react-demo

- https://github.com/launchscout/live_state
- https://hexdocs.pm/live_state/tutorial_start.html

- https://blog.sequinstream.com/liveview-is-best-with-svelte/
    - https://www.reddit.com/r/sveltejs/comments/1btax85/liveview_is_best_with_svelte/
    - https://news.ycombinator.com/item?id=39916144
- https://dockyard.com/blog/2024/03/14/harnessing-liveview-and-svelte-for-complex-user-experiences
