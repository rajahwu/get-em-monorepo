// Hand.tsx
import type { Card } from '../game-logic/deck';
import CardDisplay from './Card';

export default function Hand({ cards, label }: { cards: Card[]; label: string }) {
  return (
    <div className="mb-4">
      <h3 className="text-xl mb-2">{label}</h3>
      <div className="flex gap-2 justify-center">
        {cards.map((card, i) => (
          <CardDisplay key={i} card={card} />
        ))}
      </div>
    </div>
  );
}