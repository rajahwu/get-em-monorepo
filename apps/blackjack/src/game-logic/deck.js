export function createDeck() {
    const suits = ['hearts', 'diamonds', 'clubs', 'spades'];
    const values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'];
    return suits.flatMap(suit => values.map(value => ({ suit, value })));
}
export function shuffle(deck) {
    return deck.slice().sort(() => Math.random() - 0.5);
}
