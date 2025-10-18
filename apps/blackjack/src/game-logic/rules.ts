import type { Card } from './deck';
import { calculateHandValue } from './hand-calculator';

export const isBust = (hand: Card[]) => calculateHandValue(hand) > 21;
export const isBlackjack = (hand: Card[]) =>
  hand.length === 2 && calculateHandValue(hand) === 21;
