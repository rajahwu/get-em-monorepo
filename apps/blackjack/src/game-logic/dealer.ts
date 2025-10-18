import type { Card } from './deck';
import { calculateHandValue } from './hand-calculator';

export function playDealer(hand: Card[], deck: Card[]): Card[] {
  while (calculateHandValue(hand) < 17 && deck.length > 0) {
    hand.push(deck.pop()!);
  }
  return hand;
}
