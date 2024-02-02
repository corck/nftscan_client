defmodule ParserTest do
  use ExUnit.Case
  alias NFTScanClient.Parser

  @nfts File.read!(Path.join(__DIR__, "fixtures/nfts_for_account.json"))
        |> Jason.decode!()

  test "parse_nft/1" do
    %{"data" => %{"content" => content}} = @nfts
    [nft | tail] = content

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
end
