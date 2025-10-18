import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
export default function CardDisplay({ card }) {
    const symbolMap = { hearts: '♥', diamonds: '♦', clubs: '♣', spades: '♠' };
    return (_jsxs("div", { className: "bg-white text-black p-2 border-2 border-gray-700 rounded w-10 text-center", children: [card.value, _jsx("span", { className: "text-red-500", children: symbolMap[card.suit] })] }));
}
