import { jsx as _jsx } from "react/jsx-runtime";
export default function Message({ message }) {
    if (!message)
        return null;
    return _jsx("div", { className: "mt-4 text-lg font-bold", children: message });
}
