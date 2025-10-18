import { jsxs as _jsxs } from "react/jsx-runtime";
export default function StrategyTip({ tip }) {
    if (!tip)
        return null;
    return (_jsxs("div", { className: "mt-4 italic text-yellow-300", children: ["Strategy Tip: ", tip] }));
}
