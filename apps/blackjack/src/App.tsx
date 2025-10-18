import Controls from './components/Controls';
import Hand from './components/Hand';
import Stats from './components/Stats';
import Message from './components/Message';
import StrategyTip from './components/StrategyTip';
import useGame from './hooks/useGame';
import useStats from './hooks/useStats';
import './index.css';

export default function App() {
  const { wins, losses, bankroll, recordResult } = useStats();
  const { playerHand, dealerHand, message, hit, stand, startGame, getStrategy } = useGame(recordResult);

  return (
    <div className="min-h-screen bg-green-700 text-white flex flex-col items-center p-6">
      <h1 className="text-3xl font-semibold mb-6">Blackjack Trainer</h1>
      <Stats wins={wins} losses={losses} bankroll={bankroll} />
      <Hand cards={dealerHand} label="Dealer Hand" />
      <Hand cards={playerHand} label="Player Hand" />
      <Controls onHit={hit} onStand={stand} onNew={startGame} />
      <Message message={message} />
      <StrategyTip tip={getStrategy()} />
    </div>
  );
}