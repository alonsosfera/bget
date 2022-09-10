import { SessionProvider as AuthProvider, useSession } from 'next-auth/react'
import '../styles/globals.css'

function MyApp({ Component, pageProps: { session, ...pageProps } }) {
  return (
    <AuthProvider session={session}>
      {Component.auth ? (
        <Auth>
          <Component {...pageProps} />
        </Auth>
      ) : <Component {...pageProps} />}
    </AuthProvider>
  );
}

function Auth({ children }) {
  // if `{ required: true }` is supplied, `status` can only be "loading" or "authenticated"
  const { status } = useSession({ required: true })

  if (status === "loading") {
    return <div>Loading...</div>
  }
  return children
}

export default MyApp
