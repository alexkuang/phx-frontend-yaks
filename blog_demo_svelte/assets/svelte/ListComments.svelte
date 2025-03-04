<script>
  import { onMount } from "svelte"
  const { post_id, post_comments, live } = $props();

  let comments = $state(post_comments)

  onMount(() => {
    live.handleEvent("new_comment", (payload) => {
      // hacky dedup in case of race condition for new comments being added
      comments = [... new Set([...comments, payload])]
    });
  });
</script>

<div>
  <div>
    <a
      href={`/posts/${post_id}/comments/new`}
      data-phx-link="redirect" data-phx-link-state="push"
      class="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
    >
      New comment
    </a>
  </div>
  <ul role="list" class="flex flex-col gap-4 mt-8">
    {#each comments as comment (comment.id)}
      <li>
        <div class="block text-sm/6 font-medium text-gray-900">{comment.author}</div>
        <div class="mt-1 text-gray-500">{comment.body}</div>
      </li>
    {/each}
  </ul>
</div>
