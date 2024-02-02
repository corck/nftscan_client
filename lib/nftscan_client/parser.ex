defmodule NFTScanClient.Parser do
  alias NFTScanClient.NFT

  # Private function to convert map data into the NFT struct
  def parse_nft(nft_data) do
    # Get the struct fields as atoms
    struct_fields = Map.keys(%NFT{})

    atomized =
      nft_data
      |> Map.new(fn {k, v} -> {String.to_atom(k), v} end)
      |> Map.filter(fn {key, _value} -> Enum.any?(struct_fields, fn field -> field == key end) end)

    struct(%NFT{}, atomized)
  end
end
