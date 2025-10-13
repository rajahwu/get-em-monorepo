import React from 'react';

type CardProps = {
  title: string;
  children: React.ReactNode;
};

export function Card({ title, children }: CardProps) {
  return (
    <div className="bg-surface text-color-text rounded-lg shadow-md p-md">
      <h2 className="font-heading text-lg mb-sm">{title}</h2>
      <div>{children}</div>
    </div>
  );
}
