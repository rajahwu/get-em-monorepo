import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
export default function Controls({ onHit, onStand, onNew }) {
    return (_jsxs("div", { className: "flex gap-3 mt-4", children: [_jsx("button", { onClick: onHit, className: "bg-yellow-400 text-black px-4 py-2 rounded", children: "Hit" }), _jsx("button", { onClick: onStand, className: "bg-blue-500 text-white px-4 py-2 rounded", children: "Stand" }), _jsx("button", { onClick: onNew, className: "bg-gray-300 text-black px-4 py-2 rounded", children: "New Game" })] }));
}
