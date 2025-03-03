import React from 'react';
import { Link } from '@inertiajs/react';

export default function ListComments({ comments, post }) {
  return (
    <div>
      <div>
        <Link href={`/posts/${post.id}/comments/new`} className="rounded-md bg-indigo-600 px-3.5 py-2.5 text-sm font-semibold text-white shadow-sm hover:bg-indigo-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-600">
          New comment
        </Link>
      </div>
      <ul role="list" className="flex flex-col gap-4 mt-8">
        {comments.map((comment) => (
          <li key={comment.id}>
            <div className="block text-sm/6 font-medium text-gray-900">{comment.author}</div>
            <div className="mt-1 text-gray-500">{comment.body}</div>
          </li>
        ))}
      </ul>
    </div>
  );
}
