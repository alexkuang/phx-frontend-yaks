# phx-frontend-yaks

proofs of concept yak shaving around phoenix + client-centric frontend framework (e.g. react, vue, svelte, ...)

## Why?

Elixir/Phoenix is great.  It's my favorite gen-purpose web backend.

LiveView is great... most of the time.  But it gets rough for non-trivial frontend components.  Manual
DOM manipulation makes me feel like it's 2008 and not in a good way.

## Goal

Evaluate integrating a client-centric JS framework with Phoenix in terms of ergonomics and productivity:
- complexity compared to js-with-graphql-etc options
- keeping benefits of Elixir + Phoenix
- benefits vs cost of adding the JS framework vs just doing LiveView

Non-goal: production-ready code or best practices in any of the ecosystems in question :)  This is just a spike with a
side of yak shaving, take the code with the appropriate amount of salt.

## Bits and pieces

Stacks tested:
- [inertia.js](https://inertiajs.com/) + [react](https://react.dev)
- [svelte](https://svelte.dev/) + [live_svelte](https://github.com/woutdp/live_svelte)

The test case is a mini blog app that creates `Post`s and `Comment`s.  The `Post` features are done as
static pages + plain POST forms.  `Comment` features explore live-updating feeds, i.e. one window updates when another
adds a comment.

## Result notes

tl;dr: Both stack combos worked smoothly, and the choice mostly comes down to the preference of frontend framework.
inertia does what it says on the box: phx + react felt like "regular controllers" with react is the template language.
svelte was lighter to integrate and it was super easy to fall back to 'regular liveview'.  svelte also felt like a
natural extension of the phx / BEAM way of thinking: here's a process with some backend state, here's a component with
some frontend state, and you just push messages between the two.

### inertia + react

inertia + react feels like using "plain" Phoenix controllers with react as the template engine.  You can further use
phoenix channels (and/or something that looks like LiveState) to delay the journey to
"separate-backend-for-frontend-with-graphql-etc-etc"

All this comes with the tradeoff of react's all-or-nothing approach to frontend control, so it's the best fit for
projects that are expected to be 90%+ react.

#### feature impls

Initial setup + getting the first controller up was straightforward thanks to the excellent `inertia-phoenix` library.
Check out `post_controller.ex` and the corresponding `ListPosts.jsx` + `NewPost.jsx`.

Comments (`comment_controller.ex` + `ListComments.jsx`) was a bit more complicated.  I spent about an hour trying to get
the `live_state` library to work, but the documentation was extremely outdated, and it kept doing weird things like
churning blank updates + erroring out for unspecified reasons.  Eventually I dropped to plain Phoenix Channels
(`comment_feed_channel.ex`, `comment_feed_socket.js`, etc), which worked smoothly.

#### phx interop

react wants to take over the entire frontend, and inertia leans into that.  It's probably possible to have both react +
non-react if you:
- branch the root template for `live_title` vs `inertia_title` etc
- branch `app.js` that skips `createInertiaApp` + `react-dom`
- separate request pipeline without inertia plug

However, mix-and-match is probably not worth it because of further duplication, e.g. I don't see an easy way to call a
react component from a liveview template and vice versa.

### svelte + live_svelte

svelte + live_svelte is flexible and aligns well with Phoenix's design philosophy. It feels like a natural extension of
LiveView -- backend state and frontend state communicating via messages. This approach allows for incremental adoption
and mix-and-match, which makes for an easier transition for existing code as well.

The primary tradeoff is really in svelte vs a more established framework like react: hiring, richness of ecosystem, etc.
live_svelte could also have closer integration with other bits of the ecosystem like ecto changesets / phx formdata,
but that's pretty easy to work around.

#### feature impls

Initial setup + getting `Posts` up (`posts_live/{index.ex,form}.ex`) was pretty straightforward, +/- a bit of stumbling
around the recent svelte 5 upgrade with runes.  live_svelte also doesn't come with anything around formdata /
changesets, so a bit of duct tape was needed there to wire it up.

Svelte doesn't take over the entire frontend, so `Comments` could be a plain liveview (`comments_live/{index,form}.ex`)
and looks the same as if `live_svelte` were not a consideration.  The live updates were handled via PubSub, AKA bog
standard phoenix / liveview.

`comments/index2.ex` has a Svelte-centric feed implementation.  I played around with two approaches here.  First: on
receiving the `new_comment` message, we can update the assigns and let liveview->live_svelte->svelte do its thing.
However, this serializes the entire feed and sends it across the wire.  The second approach used live view's
`push_event` + `handleEvent` (exposed by live_svelte) to send only the new comment across the wire.

#### phx interop

Much of this was covered above, but svelte + live_svelte is pretty easy to mix in with a vanilla liveview setup.  With
the comments alone, you could:
- have the feed be a giant svelte component that receives events
- have the feed be plain liveview, 0 svelte involved
- have the feed be a liveview that itself uses svelte components for each entry

This flexibility means you can implement a design system as Svelte components and use them everywhere in the app,
liveview or not.  In theory, because Svelte compiles down to "plain html / js / etc," overhead should be minimal.

## References
- https://github.com/inertiajs/inertia-phoenix
- https://github.com/ChristianAlexander/phoenix-inertia-react-demo

- https://github.com/launchscout/live_state
- https://hexdocs.pm/live_state/tutorial_start.html

- https://blog.sequinstream.com/liveview-is-best-with-svelte/
    - https://www.reddit.com/r/sveltejs/comments/1btax85/liveview_is_best_with_svelte/
    - https://news.ycombinator.com/item?id=39916144
- https://dockyard.com/blog/2024/03/14/harnessing-liveview-and-svelte-for-complex-user-experiences
