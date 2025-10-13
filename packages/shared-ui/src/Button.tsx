import React from 'react';

type ButtonProps = React.ButtonHTMLAttributes<HTMLButtonElement> & {
  variant?: 'primary' | 'secondary';
};

export function Button({ variant = 'primary', className = '', ...props }: ButtonProps) {
  const base = 'px-md py-sm rounded-md font-body transition-colors';
  const styles =
    variant === 'primary'
      ? 'bg-brand text-surface hover:bg-accent'
      : 'bg-surface text-color-text hover:bg-color-text-muted border border-color-text-muted';

  return <button className={`${base} ${styles} ${className}`} {...props} />;
}
