import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
import { Button, Card } from '@gttm-hub/shared-ui';
export default function App() {
    return (_jsx("div", { className: "min-h-screen bg-surface flex items-center justify-center", children: _jsxs(Card, { title: "Training Mode", children: [_jsx("p", { className: "text-color-text-muted mb-md", children: "Sharpen your Blackjack skills." }), _jsx(Button, { variant: "primary", children: "Start" })] }) }));
}
