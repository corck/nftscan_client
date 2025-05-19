defmodule ParserTest do
  use ExUnit.Case
  alias NFTScanClient.Parser

  @nfts File.read!(Path.join(__DIR__, "fixtures/nfts_for_account.json"))
        |> Jason.decode!()

  @collection File.read!(Path.join(__DIR__, "fixtures/collection.json"))
              |> Jason.decode!()

  test "parse_nft/1" do
    %{"data" => %{"content" => content}} = @nfts
    [nft | _tail] = content

    assert %NFTScanClient.NFT{
             amount: "1",
             attributes: [],
             content_type: "text/html",
             content_uri: "bafybeiaslk2iutupnhgg3g4a5yc6qtyhrffsuqubce2ur44n4d2oi4qwim",
             contract_address: "0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55",
             contract_name: "Outlaw Dogs",
             contract_token_id:
               "0x000000000000000000000000000000000000000000000000000000000000000d",
             description: "",
             erc_type: "erc721",
             external_link: "",
             image_uri: "bafybeiaslk2iutupnhgg3g4a5yc6qtyhrffsuqubce2ur44n4d2oi4qwim",
             latest_trade_price: nil,
             latest_trade_symbol: nil,
             latest_trade_timestamp: nil,
             latest_trade_token: nil,
             metadata_json:
               "{\"name\":\"Rattlesnake Slim \\\"The Snake\\\" Watkins\",\"id\":13,\"image\":\"ipfs://bafybeiaslk2iutupnhgg3g4a5yc6qtyhrffsuqubce2ur44n4d2oi4qwim\",\"sialink\":\"sia://PAOB-tB5DndbSyRqLF8_XXUvB0xzfuXBpL29vLH-e3fsnw\",\"attributes\":{\"background\":\"Grey\",\"fur\":\"Light Brown\",\"breed\":\"Schnauzer\",\"tattoo\":\"No Tattoos\",\"mouth\":\"Cigar\",\"mustache\":\"Nothing\",\"eyes\":\"Bloodshot\",\"outfit\":\"Grey Headphones \\u0026 Prisoner\",\"onback\":\"Rifle\",\"eyewear\":\"No Eyewear\",\"hat\":\"Floppy\",\"hair\":\"No Hair\",\"hidden card\":\"Nothing\"}}",
             mint_price: 0.0,
             mint_timestamp: 1_635_751_031_000,
             mint_transaction_hash:
               "0x22bbf7cad5bd8fd9d686b11c638c59bc53c2bcb2768365c5a7ece4a2fa34636b",
             minter: "0x195edb48580fca079ade888213aea1359889fc4b",
             name: "Rattlesnake Slim \"The Snake\" Watkins",
             nftscan_id: "NS00BFA90171B7441D",
             nftscan_uri: nil,
             own_timestamp: 1_635_751_031_000,
             owner: "0xdd0cc42cfd8323d39ea4f261edcdc162684dd843",
             rarity_rank: 516,
             rarity_score: 0.9473063105462498,
             small_nftscan_uri: nil,
             token_id: "13",
             token_uri: "https://nfts.outlawdogs.io/13"
           } == Parser.parse_nft(nft)
  end

  test "parse_collection/1" do
    %{"data" => data} = @collection

    collection = Parser.parse_collection(data)

    assert %NFTScanClient.Collection{
             contract_address: "0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55",
             name: "Outlaw Dogs",
             symbol: "OGD",
             description: "The DODGE CITY OUTLAW DOGS Are A Play-To-Earn NFT Outlaw Gang. No Limit Poker, Shootouts, Bounty Hunting & Treasure Hunts. Welcome To The Wild West!",
             website: "https://www.outlawdogs.io/",
             email: nil,
             twitter: "DCOutlawdogs",
             discord: "https://discord.gg/pPMaCtb9",
             telegram: nil,
             github: nil,
             instagram: nil,
             medium: nil,
             logo_url: "https://i.seadn.io/gae/KwYqH7tRxMQUJ6Cl-AQVPx21DJJyO0kLzmHXGfMBbDl0L827VGnfT5Fd4dnpsApRwzrNUtsCBeN9_Mzr9LjpO2ozd7V02O5W3L1ypA?w=500&auto=format",
             banner_url: "https://i.seadn.io/gae/kCYJaOcyIZIWRUFjCcR8qLqz64szN6DJqkADPqrCQ30gIZ5Aqeodhnt2HzpBo9ERXdG_rNGROq4rF61nhtB3PM2WgHWbwM9Lml-Lp2U?w=500&auto=format",
             featured_url: "https://image.nftscan.com/eth/banner/0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55.png",
             large_image_url: "https://i.seadn.io/gae/5YzcP69gE2dtNOSjEAYhqotcKN8pLQrAbKBQM13QTpqYYilFypQarWtVYwdhI4WN_jkYvqsN9JVYuVOQ5ZWAqp-tSGp4LTeI1ARDNw?w=500&auto=format",
             attributes: [
               %{
                 "attributes_name" => "onback",
                 "attributes_values" => [
                   %{"attributes_value" => "Guitar", "total" => 93},
                   %{"attributes_value" => "Nothing", "total" => 608},
                   %{"attributes_value" => "Rifle", "total" => 165}
                 ],
                 "total" => 3
               }
             ],
             erc_type: "erc721",
             deploy_block_number: 13_529_442,
             owner: "0x195edb48580fca079ade888213aea1359889fc4b",
             verified: false,
             opensea_verified: false,
             is_spam: false,
             royalty: 500,
             items_total: 866,
             amounts_total: 866,
             owners_total: 213,
             opensea_floor_price: 0.06,
             opensea_slug: "outlaw-dogs",
             floor_price: 0.06,
             collections_with_same_name: ["0xbadbea1ef8e8ff955069fa5ef8603dbba9a3ce55"],
             price_symbol: "ETH"
           } == collection
  end
end
