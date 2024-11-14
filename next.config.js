/** @type {import('next').NextConfig} */
const nextConfig = {
  sassOptions: {
    implementation: 'sass-embedded',
    silenceDeprecations: ["legacy-js-api"],
  },
  images: {
    remotePatterns: [
      {
        protocol: 'https',
        hostname: '**.fbcdn.net',
        port: '',
        search: '',
      },
    ],
  }
}

module.exports = nextConfig
