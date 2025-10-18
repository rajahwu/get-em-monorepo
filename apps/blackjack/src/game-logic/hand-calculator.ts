import type { Card } from './deck';

export function calculateHandValue(hand: Card[]): number {
  let total = 0;
  let aces = 0;

  for (const card of hand) {
    if (card.value === 'A') {
      aces++;
      total += 11;
    } 
    else if (['K','Q','J'].includes(card.value)) {
      total += 10;

    } 
    else {
      total += Number(card.value);

    } 
  }

  while (total > 21 && aces > 0) {
    total -= 10;
    aces--;
  }

  return total;
}
