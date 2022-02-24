# Tags_Multi_Tenant

[![CircleCI](https://circleci.com/gh/bizneo/taglet/tree/master.svg?style=svg)](https://circleci.com/gh/bizneo/taglet/tree/master)

Tags_Multi_Tenant allows you to manage tags associated to your records.

It also allows you to specify various contexts

## Installation

  1. Add `taglet` to your list of dependencies in `mix.exs`:

  ```elixir
  def deps do
    [{:taglet, "~> 0.6.0"}]
  end
  ```

  2. Configure Tags_Multi_Tenant to use your repo in `config/config.exs`:

  ```elixir
  # Options
  # taggable_id - This field is default :integer, but you can set it as :uuid

  config :taglet,
    repo: ApplicationName.Repo,
    taggable_id: :uuid
  ```

  3. Install your dependencies:

  ```mix deps.get```

  4. Generate the migrations:

  ```mix taglet.install```

  5. Run the migrations:

  ```mix ecto.migrate```

## Include it in your models

Now, you can use the library in your models.

You should add the next line to your taggable model:

`use Tags_Multi_Tenant.TagAs, :tag_context_name`

i.e.:

  ```elixir
  defmodule Post do
    use Ecto.Schema
    use Tags_Multi_Tenant.TagAs, :tags
    use Tags_Multi_Tenant.TagAs, :categories

    import Ecto.Changeset

    schema "posts" do
      field :title, :string
      field :body, :boolean

      timestamps()
    end

    def changeset(struct, params \\ %{}) do
      struct
      |> cast(params, [:title, :body])
      |> validate_required([:title])
    end
  end
  ```
As you can see, we have included two different contexts, tags and
categories

Now we can use a set of metaprogrammed functions:

`Post.add_category(struct, tag)` - Passing a persisted struct will
allow you to associate a new tag

`Post.add_categories(struct, tags)` - Passing a persisted struct will
allow you to associate a new list of tags

`Post.add_category(tag)` - Add a Tag without associate it to a persisted struct,
this allow you have tags availables in the context. Example using `Post.categories`

`Post.remove_category(struct, tag)` - Will allow you to remove the relation `struct - tag`,
but the tag will persist.

`Post.remove_category(tag)` - Will allow you to remove a tag in the context `Post - category`. Tag and relations with Post will be deleted.

`Post.rename_category(old_tag, new_tag)` - Will allow you to rename the tag name.

`Post.categories_list(struct)` - List all associated tags with the given
struct

`Post.categories` - List all associated tags with the module

`Post.categories_queryable` - Same as `Post.categories` but it returns a `queryable` instead of a list.

`Post.tagged_with_category(tag)` - Search for all resources tagged with
the given tag

`Post.tagged_with_categories(tags)` - Search for all resources tagged
with the given list tag

`Post.tagged_with_query_category(queryable, tags)` - Allow to
concatenate ecto queries and return the query.

`Post.tagged_with_query_categories(queryable, tags)` - Same than previous function but allow to receive a list of tags


## Working with functions

If you want you can use directly a set of functions to play with tags:

[`Tags_Multi_Tenant.add/4`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#add/4)

[`Tags_Multi_Tenant.remove/4`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#remove/4)

[`Tags_Multi_Tenant.rename/5`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#rename/5)

[`Tags_Multi_Tenant.tag_list/3`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#tag_list/3)

[`Tags_Multi_Tenant.tag_list_queryable/2`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#tag_list_queryable/2)

[`Tags_Multi_Tenant.tagged_with/4`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#tagged_with/4)

[`Tags_Multi_Tenant.tagged_with_query/3`](https://hexdocs.pm/taglet/Tags_Multi_Tenant.html#tagged_with_query/3)
