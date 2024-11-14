import { auth } from "@/auth"

export default async function UserAvatar() {
  const session = await auth()

  if (!session?.user) return null

  console.log('user session', session)
  if (!session.user.image) {
    return <div>Missing user image</div>
  }

  return (
    <div>
      {/* eslint-disable-next-line @next/next/no-img-element */}
      <img src={session.user.image} width={200} height={200} alt="User Avatar" />
    </div>
  )
}
