import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
import CardDisplay from './Card';
export default function Hand({ cards, label }) {
    return (_jsxs("div", { className: "mb-4", children: [_jsx("h3", { className: "text-xl mb-2", children: label }), _jsx("div", { className: "flex gap-2 justify-center", children: cards.map((card, i) => (_jsx(CardDisplay, { card: card }, i))) })] }));
}
