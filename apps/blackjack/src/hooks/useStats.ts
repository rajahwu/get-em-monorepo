import { useState } from 'react';

export default function useStats() {
  const [wins, setWins] = useState(0);
  const [losses, setLosses] = useState(0);
  const [bankroll, setBankroll] = useState(1000);

  const recordResult = (result: 'win' | 'loss') => {
    if (result === 'win') {
      setWins(w => w + 1);
      setBankroll(b => b + 50);
    } else {
      setLosses(l => l + 1);
      setBankroll(b => b - 50);
    }
  };

  return { wins, losses, bankroll, recordResult };
}
