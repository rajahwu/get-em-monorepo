export default function Message({ message }: { message: string }) {
  if (!message) return null;
  return <div className="mt-4 text-lg font-bold">{message}</div>;
}
