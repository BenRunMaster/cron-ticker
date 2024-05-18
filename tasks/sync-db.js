let times =0;
const syncDB = () => {
    times++;
    console.log('Each 5 seconds: ', times);

    return times;
}

module.exports = {
    syncDB
}