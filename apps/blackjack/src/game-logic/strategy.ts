import type { Card } from './deck';
import { calculateHandValue } from './hand-calculator';

export function getStrategyTip(playerHand: Card[], dealerCard: Card | undefined): string {
  if (!dealerCard) return '';
  const playerValue = calculateHandValue(playerHand);
  const dealerValue = dealerCard.value;

  if (playerValue <= 11) return 'Hit';
  if (playerValue >= 17) return 'Stand';
  if (playerValue === 12 && ['4','5','6'].includes(dealerValue)) return 'Stand';
  if (playerValue >= 13 && playerValue <= 16 && ['2','3','4','5','6'].includes(dealerValue)) return 'Stand';
  return 'Hit';
}
