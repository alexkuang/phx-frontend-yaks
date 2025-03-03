import React from 'react';

export default function ListComments({ comments }) {
  return (
    <div>
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
