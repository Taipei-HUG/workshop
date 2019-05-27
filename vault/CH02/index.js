process.env.DEBUG = "node-vault"; // switch on debug mode

require("dotenv").config();
const mysql = require("promise-mysql");
const Vault = require("node-vault");

const { VAULT_TOKEN } = process.env;
const vault = Vault({ token: VAULT_TOKEN });

async function main() {
  const credential = await vault.read("database/creds/my-role");
  console.log(credential.data);

  const { username, password } = credential.data;
  const conn = await mysql.createConnection({
    host: "127.0.0.1",
    port: 3307,
    user: username,
    password: password
  });
  const result = await conn.query("SELECT USER() as user");
  console.log(result[0]["user"]);

  await vault.revoke({ lease_id: credential.lease_id });
  console.log(
    `use this command to access mysql: mysql -u ${username} -P 3307 -h 127.0.0.1 -p"${password}"`
  );
  process.exit(0);
}

if (require.main === module) {
  main();
}
