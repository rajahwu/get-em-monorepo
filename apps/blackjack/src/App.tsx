import { Button, Card } from '@gttm-hub/shared-ui';

export default function App() {
  return (
    <div className="min-h-screen bg-surface flex items-center justify-center">
      <Card title="Training Mode">
        <p className="text-color-text-muted mb-md">Sharpen your Blackjack skills.</p>
        <Button variant="primary">Start</Button>
      </Card>
    </div>
  );
}