import { auth, signIn, signOut } from "@/auth"

export default async function SignIn() {
  const session = await auth()

  if (!session || session.user == null) {
    return (
      <form
        action={async () => {
          "use server"
          await signIn("spotify")
        }}
      >
        <h1>Spotify Web API Typescript SDK in Next.js</h1>
        <button type="submit">Sign in with Spotify</button>
      </form>
    )
  }

  return (
    <form
      action={async () => {
        "use server"
        await signOut()
      }}
    >
      <p>Logged in as {session.user?.name}</p>
      <button type="submit">Sign out</button>
    </form>
  )
}
