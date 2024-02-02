defmodule NFTScanClient.NFT do
  defstruct [
    :contract_address,
    :contract_name,
    :contract_token_id,
    :token_id,
    :erc_type,
    :amount,
    :minter,
    :owner,
    :own_timestamp,
    :mint_timestamp,
    :mint_transaction_hash,
    :mint_price,
    :token_uri,
    :metadata_json,
    :name,
    :content_type,
    :content_uri,
    :description,
    :image_uri,
    :external_link,
    :latest_trade_price,
    :latest_trade_symbol,
    :latest_trade_token,
    :latest_trade_timestamp,
    :nftscan_id,
    :nftscan_uri,
    :small_nftscan_uri,
    :attributes,
    :rarity_score,
    :rarity_rank
  ]
end
