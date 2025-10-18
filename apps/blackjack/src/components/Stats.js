import { jsxs as _jsxs } from "react/jsx-runtime";
export default function Stats({ wins, losses, bankroll }) {
    return (_jsxs("div", { className: "mb-4 text-center", children: [_jsxs("p", { children: ["Wins: ", wins] }), _jsxs("p", { children: ["Losses: ", losses] }), _jsxs("p", { children: ["Bankroll: $", bankroll] })] }));
}
