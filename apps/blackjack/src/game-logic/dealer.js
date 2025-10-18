import { calculateHandValue } from './hand-calculator';
export function playDealer(hand, deck) {
    while (calculateHandValue(hand) < 17 && deck.length > 0) {
        hand.push(deck.pop());
    }
    return hand;
}
