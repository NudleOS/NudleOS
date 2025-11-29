const fs = require('fs');

const username = "vega.username";
const password = "vega.password";

const accountData = {
    username: username,
    password: password
};

fs.writeFile('vega_account.json', JSON.stringify(accountData, null, 4), (err) => {
    if (err) {
        console.error("Error creating account:", err);
    } else {
        console.log("Vega account created successfully!");
    }
});
