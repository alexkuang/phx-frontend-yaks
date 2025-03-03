<script>
  const { posts } = $props()
</script>

<div>
  <div>
    <a href="/posts/new" data-phx-link="redirect" data-phx-link-state="push" class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
      New post
    </a>
  </div>

  <ul role="list" class="flex flex-col gap-4 mt-8">
    {#each posts as post (post.id)}
      <li>
        <div class="block text-sm/6 font-medium text-gray-900">{post.title} (by {post.author})</div>
        <div class="mt-1 text-gray-500">{post.body}</div>
        <div class="py-2 text-sm font-medium">
          <a href={`/posts/${post.id}/comments`} class="text-indigo-600 hover:text-indigo-900" data-phx-link="redirect" data-phx-link-state="push">
            view comments
          </a>
        </div>
      </li>
    {/each}
  </ul>
</div>
