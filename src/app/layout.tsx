import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.scss'
import '@carbon/react/index.scss';
import authOptions from "@/app/api/auth/[...nextauth]/authOptions";
import AuthSessionProvider from "@/components/AuthSessionProvider";
import { getServerSession } from "next-auth";

const inter = Inter({ subsets: ['latin'] })

export const metadata: Metadata = {
  title: 'Spotify Playlist Curator',
  description: 'Create playlists, keep playlists relevant',
}

export default async function RootLayout({
  children,
}: {
  children: React.ReactNode
}) {
  const session = await getServerSession(authOptions);
  return (
    <html lang="en">
      <AuthSessionProvider session={session}>
        <body className={inter.className}>{children}</body>
      </AuthSessionProvider>
    </html>
  )
}
