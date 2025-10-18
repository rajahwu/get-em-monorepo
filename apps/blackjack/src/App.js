import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
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
    return (_jsxs("div", { className: "min-h-screen bg-green-700 text-white flex flex-col items-center p-6", children: [_jsx("h1", { className: "text-3xl font-semibold mb-6", children: "Blackjack Trainer" }), _jsx(Stats, { wins: wins, losses: losses, bankroll: bankroll }), _jsx(Hand, { cards: dealerHand, label: "Dealer Hand" }), _jsx(Hand, { cards: playerHand, label: "Player Hand" }), _jsx(Controls, { onHit: hit, onStand: stand, onNew: startGame }), _jsx(Message, { message: message }), _jsx(StrategyTip, { tip: getStrategy() })] }));
}
