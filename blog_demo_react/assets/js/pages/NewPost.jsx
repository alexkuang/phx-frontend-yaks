import React from 'react';
import { useForm } from '@inertiajs/react';

export default function NewPost() {
  const { data, setData, post, processing, errors } = useForm({title: '', body: ''});

  function submit(e) {
    e.preventDefault();
    post('/posts');
  }

  return (
    <form onSubmit={submit}>
      <div>
        <h2 className="text-base font-semibold leading-7 text-gray-900">New Post</h2>

        <div className="mt-6 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
          <div className="sm:col-span-4">
            <label htmlFor="title" className="block text-sm/6 font-medium text-gray-900">title</label>

            <div className="mt-2">
              <input
                type="text"
                value={data.title}
                onChange={e => setData('title', e.target.value)}
                id="title"
                className="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
              />
            </div>

            {errors?.title && (<p className="mt-2 text-sm text-red-600">{errors.title}</p>)}
          </div>
        </div>

        <div className="mt-6 grid grid-cols-1 gap-x-6 gap-y-8 sm:grid-cols-6">
          <div className="sm:col-span-4">
            <label htmlFor="body" className="block text-sm/6 font-medium text-gray-900">body</label>

            <div className="mt-2">
              <textarea
                value={data.body}
                onChange={e => setData('body', e.target.value)}
                id="body"
                className="block w-full rounded-md bg-white px-3 py-1.5 text-base text-gray-900 outline outline-1 -outline-offset-1 outline-gray-300 placeholder:text-gray-400 focus:outline focus:outline-2 focus:-outline-offset-2 focus:outline-indigo-600 sm:text-sm/6"
              />
            </div>

            {errors?.body && (<p className="mt-2 text-sm text-red-600">{errors.body}</p>)}
          </div>
        </div>
      </div>

      <div className="mt-12 flex items-center">
        <button
          type="submit"
          disabled={processing}
          className="rounded-md bg-indigo-600 px-2.5 py-1.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600"
        >
          Submit
        </button>
      </div>
    </form>
  )
}
