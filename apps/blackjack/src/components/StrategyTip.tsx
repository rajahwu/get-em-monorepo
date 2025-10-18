export default function StrategyTip({ tip }: { tip: string }) {
  if (!tip) return null;
  return (
    <div className="mt-4 italic text-yellow-300">
      Strategy Tip: {tip}
    </div>
  );
}
