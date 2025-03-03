import React from 'react';

export default function ListPosts({ posts }) {
  return (
    <div>
      <ul role="list" className="flex flex-col gap-4">
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
