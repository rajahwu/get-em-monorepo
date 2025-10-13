import { jsx as _jsx } from "react/jsx-runtime";
export function Button({ variant = 'primary', className = '', ...props }) {
    const base = 'px-md py-sm rounded-md font-body transition-colors';
    const styles = variant === 'primary'
        ? 'bg-brand text-surface hover:bg-accent'
        : 'bg-surface text-color-text hover:bg-color-text-muted border border-color-text-muted';
    return _jsx("button", { className: `${base} ${styles} ${className}`, ...props });
}
