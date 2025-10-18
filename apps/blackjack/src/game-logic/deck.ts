export type Suit = 'hearts' | 'diamonds' | 'clubs' | 'spades';
export type Card = { suit: Suit; value: string };

export function createDeck(): Card[] {
  const suits: Suit[] = ['hearts', 'diamonds', 'clubs', 'spades'];
  const values = ['2','3','4','5','6','7','8','9','10','J','Q','K','A'];
  return suits.flatMap(suit => values.map(value => ({ suit, value })));
}

export function shuffle(deck: Card[]): Card[] {
  return deck.slice().sort(() => Math.random() - 0.5);
}
