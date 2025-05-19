defmodule NFTScanClient.Parser do
  @moduledoc """
  Parser module for converting API responses into structured data.
  """

  alias NFTScanClient.{NFT, Collection}

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

  @doc """
  Parses a collection from the NFTScan API response into a Collection struct.

  # Example response:

  Example response from NFTScan API:
  ```
  {
     "code": 200,
     "msg": null,
     "data": {
       "contract_address": "0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55",
       "name": "Outlaw Dogs",
       "symbol": "OGD",
       "description": "The DODGE CITY OUTLAW DOGS Are A Play-To-Earn NFT Outlaw Gang. No Limit Poker, Shootouts, Bounty Hunting & Treasure Hunts. Welcome To The Wild West!",
       "website": "https://www.outlawdogs.io/",
       "email": null,
       "twitter": "DCOutlawdogs",
       "discord": "https://discord.gg/pPMaCtb9",
       "telegram": null,
       "github": null,
       "instagram": null,
       "medium": null,
       "logo_url": "https://i.seadn.io/gae/KwYqH7tRxMQUJ6Cl-AQVPx21DJJyO0kLzmHXGfMBbDl0L827VGnfT5Fd4dnpsApRwzrNUtsCBeN9_Mzr9LjpO2ozd7V02O5W3L1ypA?w=500&auto=format",
       "banner_url": "https://i.seadn.io/gae/kCYJaOcyIZIWRUFjCcR8qLqz64szN6DJqkADPqrCQ30gIZ5Aqeodhnt2HzpBo9ERXdG_rNGROq4rF61nhtB3PM2WgHWbwM9Lml-Lp2U?w=500&auto=format",
       "featured_url": "https://image.nftscan.com/eth/banner/0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55.png",
       "large_image_url": "https://i.seadn.io/gae/5YzcP69gE2dtNOSjEAYhqotcKN8pLQrAbKBQM13QTpqYYilFypQarWtVYwdhI4WN_jkYvqsN9JVYuVOQ5ZWAqp-tSGp4LTeI1ARDNw?w=500&auto=format",
       "attributes": [],
       "erc_type": "erc721",
       "deploy_block_number": 13529442,
       "owner": "0x195edb48580fca079ade888213aea1359889fc4b",
       "verified": false,
       "opensea_verified": false,
       "is_spam": false,
       "royalty": 500,
       "items_total": 866,
       "amounts_total": 866,
       "owners_total": 213,
       "opensea_floor_price": 0.06,
       "opensea_slug": "outlaw-dogs",
       "floor_price": 0.06,
       "collections_with_same_name": ["0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55"],
       "price_symbol": "ETH"
     }
   }
  ```

  """
  @spec parse_collection(map()) :: Collection.t()
  def parse_collection(data) do
    %Collection{
      contract_address: data["contract_address"],
      name: data["name"],
      symbol: data["symbol"],
      description: data["description"],
      website: data["website"],
      email: data["email"],
      twitter: data["twitter"],
      discord: data["discord"],
      telegram: data["telegram"],
      github: data["github"],
      instagram: data["instagram"],
      medium: data["medium"],
      logo_url: data["logo_url"],
      banner_url: data["banner_url"],
      featured_url: data["featured_url"],
      large_image_url: data["large_image_url"],
      attributes: data["attributes"] || [],
      erc_type: data["erc_type"],
      deploy_block_number: data["deploy_block_number"],
      owner: data["owner"],
      verified: data["verified"],
      opensea_verified: data["opensea_verified"],
      is_spam: data["is_spam"],
      royalty: data["royalty"],
      items_total: data["items_total"],
      amounts_total: data["amounts_total"],
      owners_total: data["owners_total"],
      opensea_floor_price: data["opensea_floor_price"],
      opensea_slug: data["opensea_slug"],
      floor_price: data["floor_price"],
      collections_with_same_name: data["collections_with_same_name"],
      price_symbol: data["price_symbol"]
    }
  end
end
