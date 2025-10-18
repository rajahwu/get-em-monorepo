import { calculateHandValue } from './hand-calculator';
export const isBust = (hand) => calculateHandValue(hand) > 21;
export const isBlackjack = (hand) => hand.length === 2 && calculateHandValue(hand) === 21;
