interface ControlsProps {
  onHit: () => void;
  onStand: () => void;
  onNew: () => void;
}

export default function Controls({ onHit, onStand, onNew }: ControlsProps) {
  return (
    <div className="flex gap-3 mt-4">
      <button onClick={onHit} className="bg-yellow-400 text-black px-4 py-2 rounded">Hit</button>
      <button onClick={onStand} className="bg-blue-500 text-white px-4 py-2 rounded">Stand</button>
      <button onClick={onNew} className="bg-gray-300 text-black px-4 py-2 rounded">New Game</button>
    </div>
  );
}
