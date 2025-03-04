<script>
  import { preventDefault } from "svelte/legacy";
  import Button from "./Button.svelte";

  let { live, formErrors } = $props();

  let title = $state("");
  let body = $state("");

  function createPost() {
    live.pushEvent("create_post", { title, body });
  }
</script>


<form onsubmit={preventDefault(createPost)}>
  <div>
    <h2 class="text-base font-semibold leading-7 text-gray-900">New Post</h2>

    <div class="mt-6 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
      <div class="sm:col-span-4">
        <label for="title" class="block text-sm/6 font-medium text-gray-900">title</label>

        <div class="mt-2">
          <input
            type="text"
            id="title"
            bind:value={title}
            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
          />

          {#if formErrors?.title}
            <p class="mt-2 text-sm text-red-600">{formErrors.title}</p>
          {/if}
        </div>
      </div>
    </div>

    <div class="mt-6 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
      <div class="sm:col-span-4">
        <label for="body" class="block text-sm/6 font-medium text-gray-900">body</label>

        <div class="mt-2">
          <textarea
            bind:value={body}
            id="body"
            class="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
          >
          </textarea>
          {#if formErrors?.body}
            <p class="mt-2 text-sm text-red-600">{formErrors.body}</p>
          {/if}
        </div>
      </div>
    </div>
  </div>

  <div class="mt-12 flex items-center">
    <Button type="submit" text="Submit" />
  </div>
</form>
