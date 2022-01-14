const axios = require('axios');

const url = 'url';

const timer = (time) => new Promise((resolve) => setTimeout(resolve, time));

// create 50 users
const main = async () => {
  for (let i = 33; i < 53; i++) {
    const user = {};
    try {
      const result = await axios.post(url, user);
      console.log(result);
    } catch (e) {
      console.log('error');
      console.log(e);
      i--;
    }
    await timer(5000);
  }
};

main();
