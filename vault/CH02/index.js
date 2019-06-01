process.env.DEBUG = "node-vault"; // switch on debug mode

require("dotenv").config();
const mysql = require("promise-mysql");
const Vault = require("node-vault");

const { VAULT_TOKEN } = process.env;
const vault = Vault({ token: VAULT_TOKEN });
const host = "127.0.0.1";
const port = 3307;

async function main() {
  const credential = await vault.read("database/creds/my-role");
  console.log(JSON.stringify(credential, null, 2));

  const { username: user, password } = credential.data;
  const conn = await mysql.createConnection({ host, port, user, password });
  const result = await conn.query("SELECT USER() as user");
  console.log(result[0]["user"]);

  await vault.revoke({ lease_id: credential.lease_id });
  console.log(
    `use this command to access mysql & revoke credential: \n` +
      `- mysql -u ${user} -P 3307 -h 127.0.0.1 -p"${password}"\n` +
      `- vault lease revoke ${credential.lease_id}`
  );
  process.exit(0);
}

if (require.main === module) {
  main();
}
