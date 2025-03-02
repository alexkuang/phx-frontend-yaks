# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BlogDemoReact.Repo.insert!(%BlogDemoReact.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BlogDemoReact.Comment
alias BlogDemoReact.Post
alias BlogDemoReact.Repo

posts =
  [
    %Post{title: "post 1", author: "some author", body: "post body 1"},
    %Post{title: "post 2", author: "some author", body: "post body 2"},
    %Post{title: "post 3", author: "some author", body: "post body 3"}
  ]

[post1 | _rest] = Enum.map(posts, &Repo.insert!/1)

[
  %Comment{author: "some commenter", body: "comment 1", post_id: post1.id},
  %Comment{author: "some commenter", body: "comment 2", post_id: post1.id}
]
|> Enum.each(&Repo.insert!/1)
