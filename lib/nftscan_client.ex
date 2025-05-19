defmodule NFTScanClient.Client do
  @moduledoc """
  Client module for interacting with the NFTScan API.
  """
  alias NFTScanClient.{Collection, Parser}

  @api_base_url "https://restapi.nftscan.com/api/v2/account/own/"
  @collections_base_url "https://restapi.nftscan.com/api/v2/collections/"

  @spec get_api_key :: String.t()
  def get_api_key do
    Application.fetch_env!(:nftscan_client, :api_key)
  end

  @spec nfts_by_account(any(), keyword()) :: list() | {:error, any()}
  @doc """
  ## `nfts_by_account/2`

  Retrieves a list of NFTs associated with a given account address. This function provides a flexible interface to specify various query parameters that can refine the search results based on the ERC type, visibility of attributes, sorting field, and sorting direction.

  ### Parameters:

    * `address` (String): The wallet address for which to retrieve NFTs. This must be a valid Ethereum address.
    * `opts` (Keyword list, optional): Additional options to customize the query. Defaults to an empty list.

  ### Supported Options in `opts`:

    * `:erc_type` (String): Specifies the ERC token type to filter NFTs. Default is `"erc721"`.
    * `:show_attribute` (String): Determines whether to show attributes of NFTs. The default value is `"false"`.
    * `:sort_field` (String): Designates the field by which to sort the results. Defaults to an empty string, indicating no specific sort order.
    * `:sort_direction` (String): Sets the direction of sorting (`"asc"` for ascending or `"desc"` for descending). By default, there is no sorting applied.

  Optional parameters can be provided to override these defaults. For example, if you want to retrieve ERC-1155 NFTs and sort them by date in ascending order, you would pass `[erc_type: "erc1155", sort_field: "date", sort_direction: "asc"]` as the `opts`.

  ### Examples:

  To fetch the default ERC-721 NFTs without any sorting:

      nfts_by_account("0x123...")

  To fetch ERC-1155 NFTs for a specific contract address:

      nfts_by_account("0x123...", [erc_type: "erc1155", contract_address: "0xabc..."])

  To sort NFTs by date in ascending order:

      nfts_by_account("0x123...", [sort_field: "date", sort_direction: "asc"])

  ### Returns:

    * A list of NFTScanClient.NFT matching the query parameters, each represented as a map of attributes corresponding to the NFT's properties.
  """
  def nfts_by_account(address, opts \\ []) do
    # Default params can be overridden by opts
    default_params = [
      erc_type: "erc721",
      show_attribute: "false",
      sort_field: "",
      sort_direction: ""
    ]

    # Merge opts into the default_params, opts will override or add to defaults
    params = Keyword.merge(default_params, opts)

    url = "#{@api_base_url}#{address}"

    # Replace "API_KEY" with your actual API key
    headers = [{"X-API-KEY", get_api_key()}]

    case HTTPoison.get(url, headers, params: params) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Jason.decode!()
        |> parse_response()

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end

  # Parse the JSON response into a list of NFT structs
  defp parse_response(%{"data" => %{"content" => content}}) do
    Enum.map(content, &Parser.parse_nft/1)
  end

  @doc """
  Retrieves collection information for a given contract address.

  ## Parameters:

    * `contract_address` (String): The contract address of the collection to retrieve.
    * `opts` (Keyword list, optional): Additional options to customize the query. Defaults to an empty list.

  ## Supported Options in `opts`:

    * `:show_attribute` (boolean): Whether to include collection attributes in the response. Default is `false`.

  ## Examples:

      get_collection("0x123...")
      get_collection("0x123...", show_attribute: true)

  ## Returns:

    * `{:ok, NFTScanClient.Collection.t()}` on success
    * `{:error, reason}` on failure
  """
  @spec get_collection(String.t(), keyword()) :: {:ok, Collection.t()} | {:error, any()}
  def get_collection(contract_address, opts \\ []) do
    show_attribute = Keyword.get(opts, :show_attribute, false)
    url = "#{@collections_base_url}#{contract_address}?show_attribute=#{show_attribute}"

    headers = [{"X-API-KEY", get_api_key()}]

    case HTTPoison.get(url, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        case Jason.decode!(body) do
          %{"data" => data} ->
            {:ok, Parser.parse_collection(data)}
          _ ->
            {:error, "Invalid response format"}
        end

      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Collection not found"}

      {:error, %HTTPoison.Error{reason: reason}} ->
        {:error, reason}
    end
  end
end
