# Melanoma

The source repository for some of the image processing done for the Melanoma Model in my Image processing class

In order to run, you'll need Erlang, and Elixir installed.

Once you have everything set up run:

```
mix deps.get
mix compile
mix run
```

Just warning that you need images, and when you compile an elixir program for the first time, it runs the code as well.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `melanoma` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:melanoma, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/melanoma>.

