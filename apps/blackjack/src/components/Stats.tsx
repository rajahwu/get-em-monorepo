interface StatsProps {
  wins: number;
  losses: number;
  bankroll: number;
}

export default function Stats({ wins, losses, bankroll }: StatsProps) {
  return (
    <div className="mb-4 text-center">
      <p>Wins: {wins}</p>
      <p>Losses: {losses}</p>
      <p>Bankroll: ${bankroll}</p>
    </div>
  );
}
