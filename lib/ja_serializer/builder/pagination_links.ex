defmodule JaSerializer.Builder.PaginationLinks do
  @moduledoc """
  Builds JSON-API spec pagination links.

  Pass in a map with the necessary data:

      JaSerializer.Builder.PaginationLinks.build(%{
          number: 1,
          size: 20,
          total: 5,
          base_url: "https://example.com"
        },
        Plug.Conn%{}
      )

  Would produce a list of links such as:

      [
        self: "https://example.com/posts?page[number]=2&page[size]=10",
        next: "https://example.com/posts?page[number]=3&page[size]=10",
        first: "https://example.com/posts?page[number]=1&page[size]=10",
        last: "https://example.com/posts?page[number]=20&page[size]=10"
      ]

  The param names can be customized on your application's config:

      config :ja_serializer,
        page_key: "page",
        page_base_url: "https://example.com/posts"
        page_number_key: "offset",
        page_size_key: "limit",
        page_number_origin: 0,

  The defaults are:

  * `page_key` : `"page"`
  * `page_base_url`: `nil`
  * `page_number_key`: `"number"`
  * `page_size_key` : `"size"`
  * `page_number_origin`: `1`

  Please note that if the value for `page_number_origin` is changed JaSerializer will have to be recompiled:

      $ mix deps.clean ja_serializer
      $ mix deps.get ja_serializer
  """

  # @spec build(data, conn) :: map, map
  def build(data, _conn) do
    data
    |> links()
  end

  defp links(data) do
    [total_pages: data[:total],
     page_number: data[:number],
     page_size: data[:size]]
  end
end
