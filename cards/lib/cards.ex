defmodule Cards do
  @moduledoc """
    Provides methos for creating and handling a deck of cards
  """

  @doc """
    Returns a list of strings representing a deck of playing cards
  """
  def create_deck do
    suits = ["♠️", "♣️", "♥️", "♦️"]
    values = ["A", "2", "3", "4", "5", "6","7", "8", "9", "J", "Q", "K"]

    for suit <- suits, value <- values do
      "#{value} #{suit}"
    end
  end


  def suffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines wheter a deck contains a given card

  ## Examples
      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "A ♠️")
      true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` argument indicates how many cards should 
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _} = Cards.deal(deck, 1)
      iex> hand
      ["A ♠️"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term binary
      {:error, reason} -> "That file does not exists. Reason: #{reason}"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck 
    |> Cards.suffle 
    |> Cards.deal(hand_size)
  end

end
