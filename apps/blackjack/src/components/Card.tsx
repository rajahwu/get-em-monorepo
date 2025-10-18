import type { Card } from '../game-logic/deck';

export default function CardDisplay({ card }: { card: Card }) {
  const symbolMap = { hearts: '♥', diamonds: '♦', clubs: '♣', spades: '♠' };
  return (
    <div className="bg-white text-black p-2 border-2 border-gray-700 rounded w-10 text-center">
      {card.value}
      <span className="text-red-500">{symbolMap[card.suit]}</span>
    </div>
  );
}