import Config

# Default configuration for the NFTScanClient
config :nftscan_client, api_key: System.get_env("NFTSCAN_API_KEY")
