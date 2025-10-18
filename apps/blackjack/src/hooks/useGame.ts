import { useState } from 'react';
import { type Card,  createDeck, shuffle } from '../game-logic/deck';
import { calculateHandValue } from '../game-logic/hand-calculator';
import { playDealer } from '../game-logic/dealer';
import { getStrategyTip } from '../game-logic/strategy';
import { isBust } from '../game-logic/rules';

export default function useGame(recordResult: (result: 'win' | 'loss') => void) {
  const [deck, setDeck] = useState<Card[]>([]);
  const [playerHand, setPlayerHand] = useState<Card[]>([]);
  const [dealerHand, setDealerHand] = useState<Card[]>([]);
  const [message, setMessage] = useState<string>('');

  const startGame = () => {
    const newDeck = shuffle(createDeck());
    const player = [newDeck.pop()!, newDeck.pop()!];
    const dealer = [newDeck.pop()!, newDeck.pop()!];
    setDeck(newDeck);
    setPlayerHand(player);
    setDealerHand(dealer);
    setMessage('');
  };

  const hit = () => {
    const newDeck = [...deck];
    const newHand = [...playerHand, newDeck.pop()!];
    setPlayerHand(newHand);
    setDeck(newDeck);
    if (isBust(newHand)) {
      setMessage('You busted!');
      recordResult('loss');
    }
  };

  const stand = () => {
    const dealerFinal = playDealer([...dealerHand], [...deck]);
    const playerValue = calculateHandValue(playerHand);
    const dealerValue = calculateHandValue(dealerFinal);
    setDealerHand(dealerFinal);

    if (dealerValue > 21 || playerValue > dealerValue) {
      setMessage('You win!');
      recordResult('win');
    } else if (dealerValue > playerValue) {
      setMessage('Dealer wins.');
      recordResult('loss');
    } else {
      setMessage('Push.');
      // no bankroll change on push
    }
  };

  const getStrategy = () => getStrategyTip(playerHand, dealerHand[0]);

  return { playerHand, dealerHand, message, hit, stand, startGame, getStrategy };
}