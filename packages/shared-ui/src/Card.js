import { jsx as _jsx, jsxs as _jsxs } from "react/jsx-runtime";
export function Card({ title, children }) {
    return (_jsxs("div", { className: "bg-surface text-color-text rounded-lg shadow-md p-md", children: [_jsx("h2", { className: "font-heading text-lg mb-sm", children: title }), _jsx("div", { children: children })] }));
}
