require('dotenv').config()

import { URL } from 'url'
import colors from 'colors'

const defaultDbName = 'st_main'

enum Env {
  none  = '',
  local = 'local',
}

const {
  ENV_GROUP,
  DB_NAME,
  PG_USER,
  PG_PW,
  PGPASS,
  PORT,
} = process.env

const envs = Object.values(Env),
      envRaw = envs.find((e) => e === ENV_GROUP),
      env = envRaw || Env.local

if (!envRaw) {
    console.error(colors.brightRed('!!! Bad ENV_GROUP !!!'))
    console.log(colors.white('Provided:'), colors.brightRed(ENV_GROUP))
    console.log(colors.white('Available Options:'), Object.values(envs).filter((v) => v.length))
    process.exit(100);
}

const origin = ({
  [Env.local]: '127.0.0.1:5454',
}[env])


const user = PG_USER ?? 'spoti'

let password = ""
if (PGPASS && PGPASS?.length > 0) {
  password = PGPASS.split(':')[4]
} else {
  password = PG_PW ?? 'spc'
}

// CONNECTION_ANADEV, CONNECTION_ANAQC, CONNECTION_ANAPROD set in pipeline
// fallover allows us to reach local and dev db running it locally and qc/prod if we pass PG_USER and PG_PW
const envUrl = `postgres://${user}:${password}@${origin}/postgres${env !== Env.local ? '?sslmode=no-verify' : ''}`
const envUrlSafe = `postgres://${user}:${password}@${origin}/postgres${env !== Env.local ? '?sslmode=no-verify' : ''}`

/**
 * `postgres://` connection for entrypoint
 */
export const envConnection = new URL(envUrl)
export const envPass = password
export const dbEnvConfig = {
  user,
  password,
  host: origin.split(":")[0],
  port: origin.split(":")[1],
  database: 'postgres',
  ssl: env === Env.local ? undefined : {
    rejectUnauthorized: false
  }
}

/**
 * bld-based db name
 */
export const envDB = DB_NAME ?? defaultDbName

export const envIsDefaultDb = envDB === defaultDbName


if (process.env.V === '1') {
  console.log(colors.green('Env:'), env)
  console.log(colors.grey('-----------------------------------'))
  console.log(colors.green('Conn:'), envUrlSafe)
  console.log(colors.green('envDB:'), envDB)
  console.log(colors.green('envIsDefault:'), envIsDefaultDb)
}
