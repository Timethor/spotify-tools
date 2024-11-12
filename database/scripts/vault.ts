import fetch from 'node-fetch'

const {
  VAULT_ADDR,
  VAULT_NONCE: nonce,
} = process.env

export async function getDBPassword() {
  const pkcs7Resp = await fetch('http://169.254.169.254/latest/dynamic/instance-identity/pkcs7')
  const pkcs7Text = await pkcs7Resp.text()
  const pkcs7 = pkcs7Text.trim()

  const tokenResp = await fetch(`${VAULT_ADDR}/v1/auth/aws-ec2/login`, {
    body: JSON.stringify({
      pkcs7,
      nonce,
      role: "iris-product-feedback",
    })
  })
  const tokenJson = await tokenResp.json() as any
  const token = tokenJson.auth.client_token

  const secretResp = await fetch(`${VAULT_ADDR}/v1/secret/iris/product-feedback/postgres`, {
    headers: {
      'X-Vault-Token': token,
    }
  })
  const secretJson = await secretResp.json() as any
  const secret = secretJson.data.password

  return secret
}
