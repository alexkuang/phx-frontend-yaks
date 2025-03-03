import { Link } from '@inertiajs/react';
import React from 'react';

export default function ListPosts({ posts }) {
  return (
    <div>
      <div>
        <Link href="/posts/new" className="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
          New post
        </Link>
      </div>
      <ul role="list" className="flex flex-col gap-4 mt-8">
        {posts.map((post) => (
          <li key={post.id}>
            <div className="block text-sm/6 font-medium text-gray-900">{post.title} (by {post.author})</div>
            <div className="mt-1 text-gray-500">{post.body}</div>
          </li>
        ))}
      </ul>
    </div>
  );
}
